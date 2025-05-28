import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rjs_store/Features/Signin/data/repo/user_repository.dart';
import 'package:rjs_store/Features/login/views/login_view.dart';
import 'package:rjs_store/core/utils/constants/colors.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/utils/popups/loaders.dart';
import '../../../Features/Signin/data/repo/user_model.dart';
import '../../product_model.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/texts.dart';
import '../../utils/network/network_manager.dart';
import '../../utils/popups/full_screen_loader.dart';
import '../../utils/repositories/authentication_repository.dart';
import 're_auth_login_form.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  // obs means : it will observe this user and when data change it will redraw the UI
  final profileLoading = false.obs;
  final imageUploading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());

  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();
  final localeData = GetStorage();
  final Rxn<Map<String, dynamic>> storedDataRx = Rxn<Map<String, dynamic>>();

  @override
  void onInit() {
    super.onInit();
    final data = GetStorage().read(TTexts.kuserData) as Map<String, dynamic>?;
    storedDataRx.value = data;

    fetchUserRecord();
  }

  Future<void> loadStoredData() async {
    final data = GetStorage().read(TTexts.kuserData) as Map<String, dynamic>?;
    storedDataRx.value = data;
  }

  /// Fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      // Attempt to fetch the user details from the remote server.
      final fetchedUser = await userRepository.fetchUserDetails();

      // Check if the fetched user looks valid.
      // ignore: unrelated_type_equality_checks
      if (fetchedUser != Null && fetchedUser.id.isNotEmpty) {
        // Successfully fetched: update our reactive user and store its JSON representation offline.
        user(fetchedUser);
        localeData.write(TTexts.kuserData, fetchedUser.toJson());
        user.refresh(); // This forces the UI to update
        if (kDebugMode) {
          print(
              '*************************************************************************');
          print('User Data :');
          print('products : ${fetchedUser.products?.length}');
          print('favorites : ${fetchedUser.favoriteList?.length}');
          print(
              '*************************************************************************');
        }
      } else {
        // Fetched data is null or invalid.
        // Try to load offline stored data.
        final storedData = localeData.read(TTexts.kuserData);
        if (storedData != null) {
          try {
            // Convert the stored map to a UserModel.
            final offlineUser = UserModel.fromJson(storedData);
            user(offlineUser);
          } catch (e) {
            // Parsing failed: show an empty user model.
            user(UserModel.empty());
          }
        } else {
          // No stored data available: set an empty user model.
          user(UserModel.empty());
        }
      }
    } catch (e) {
      TLoaders.warningSnackBar(
          title: 'Warning',
          message: 'Leak in user data , or it is not updated data');
      // In the event of an error, attempt to load offline stored data.
      final storedData = localeData.read(TTexts.kuserData);
      if (storedData != null) {
        try {
          user(UserModel.fromJson(storedData));
        } catch (e) {
          user(UserModel.empty());
        }
      } else {
        user(UserModel.empty());
      }
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      if (userCredentials != null) {
        // Convert Name to Fist and Last Name
        final nameParts =
            UserModel.nameParts(userCredentials.user!.displayName ?? '');
        final username =
            UserModel.generateuserName(userCredentials.user!.displayName ?? '');

        // Map data
        final user = UserModel(
          id: userCredentials.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
          userName: username,
          email: userCredentials.user!.email ?? '',
          phoneNumber: userCredentials.user!.phoneNumber ?? '',
          profilePicture: userCredentials.user!.photoURL ?? '',
          dateOfBirth: null,
          // no need for it because I related it on the back4app site feature
          products: [],
          favoriteList: [],
        );

        // Save user data
        await userRepository.saveUserRecord(user);
      }
    } catch (e) {
      TLoaders.warningSnackBar(
          title: 'Data not saved',
          message:
              'Something went wrong while saving your information. You can re-save your data in you profile');
    }
  }

  /// Function to show a Delete Account warning dialog.
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Delete Account',
      middleText:
          'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
      // Confirm button: deletes the account and closes the dialog.
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
          backgroundColor: TColors.error,
          side: const BorderSide(color: TColors.error),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
          child: Text('Delete'),
        ),
      ),
      // Cancel button: simply closes the dialog.
      cancel: OutlinedButton(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
      ),
    );
  }

  // Delete User Account
  void deleteUserAccount() async {
    try {
      TFullScreenLoader.openLoadingDialog('Processing', TImages.dacerAnimation);

      // First re-authenticate user
      final auth = AuthenticationRepository.Instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        // Re Verify Auth Email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          await userRepository.removeUserRecord();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginView());
        } else if (provider == 'password') {
          TFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// RE-AUTHENTICATE before deleting
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      // Open a full-screen loading dialog with an animation
      TFullScreenLoader.openLoadingDialog('Processing', TImages.dacerAnimation);

      // Check Internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
            title: 'No Internet Connection',
            message: 'Please check your network settings.');
        return;
      }

      // Validate the re-authentication form
      if (!reAuthFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Re-authenticate the user with email and password
      await AuthenticationRepository.Instance
          .reAuthenticateWithEmailAndPassword(
        verifyEmail.text.trim(),
        verifyPassword.text.trim(),
      );

      // Delete the user's account after successful re-authentication
      await AuthenticationRepository.Instance.deleteAccount();
      // Stop the loading dialog
      TFullScreenLoader.stopLoading();

      // Navigate to the LoginScreen after account deletion
      Get.offAll(() => const LoginView());
    } catch (e) {
      // Handle any errors and show a warning snackbar
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// update favorite list / wishlist
  Future<void> updateFavoriteList(ProductModel product) async {
    try {
      final storedData = localeData.read(TTexts.kuserData);
      if (storedData == null) {
        throw Exception("No stored user data available.");
      }

      // Get the favorite list stored locally.
      final List<dynamic>? favListDynamic =
          storedData['FavoriteList'] as List<dynamic>?;
      final List<String> favoriteList =
          favListDynamic != null ? List<String>.from(favListDynamic) : [];

      // Toggle the favorite status for the product.
      if (favoriteList.contains(product.objectId)) {
        favoriteList.remove(product.objectId);
      } else {
        favoriteList.add(product.objectId);
      }

      // Update the storedData map with the new favorite list.
      storedData['FavoriteList'] = favoriteList;

      // Update the reactive user model.
      user.update((userModel) {
        userModel?.favoriteList = favoriteList;
      });

      // Trigger an update only for the card with this product.
      update([product.objectId]);
      user.refresh();
      // Write the updated storedData  back to local storage.
      localeData.write(TTexts.kuserData, storedData);
      storedDataRx.value = storedData;

      // Optionally: Update the favorite details on the remote repository.
      await userRepository.updateFavoriteProductDetails(
          updatedProduct: product);

      // Optionally: Fetch the user record to refresh the full user data.
      await fetchUserRecord();
    } catch (e) {
      TLoaders.warningSnackBar(
          title: 'Something went wrong', message: e.toString());
    }
  }

  /// Upload Profile Image
  Future<void> uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        imageUploading.value = true;
        //////////////////////////////////// @@@@@@@@@@@@@ edit the url @@@@@@@@@@@@@@ ///////////////////////////
        /// Upload Image
        final imageUrl = await userRepository.uploadImage(
            'https://res.cloudinary.com/dolast4ks/image/upload/v1745434543/',
            image);

        /// Update User Image Record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);
        user.refresh();
        user.value.profilePicture = imageUrl;
        TLoaders.successSnackBar(
            title: 'Congratulations',
            message: 'Your profile image has been updated');
      }
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Error', message: 'Something went wrong:$e');
    } finally {
      imageUploading.value = false;
    }
  }
}
