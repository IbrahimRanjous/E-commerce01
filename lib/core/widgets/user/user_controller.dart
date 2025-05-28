import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
import '../images/profile_image_store_locally.dart';
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
  final userLocaleData = GetStorage();
  // Reactive variable for storing the profile image file path.
  var profileImagePath = ''.obs;
  List<String>? localeFavoriteListProducts;
  List<ProductModel>? localeProducts;
  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
    final localStorage = GetStorage();
    profileImagePath.value = localStorage.read(TTexts.kProfileImage) ?? '';
    localeFavoriteListProducts = userLocaleData.read(TTexts.kFavoriteList);
    localeProducts = userLocaleData.read(TTexts.kProductList);
  }

  /// Fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      // Attempt to fetch the user details from the remote server.
      final fetchedUser = await userRepository.fetchUserDetails();

      // Check if the fetched user looks valid.
      if (fetchedUser.id.isNotEmpty) {
        // Successfully fetched: update our reactive user and store its JSON representation offline.
        user(fetchedUser);
        userLocaleData.write(TTexts.kuserData, fetchedUser.toJson());
        userLocaleData.write(TTexts.kFavoriteList, fetchedUser.favoriteList);
        userLocaleData.write(TTexts.kFavoriteList, fetchedUser.products);
        user.refresh(); // This forces the UI to update
      } else {
        // Fetched data is null or invalid.
        // Try to load offline stored data.
        final storedData = userLocaleData.read(TTexts.kuserData);
        if (storedData != null) {
          try {
            user(UserModel.fromJson(storedData));
            user.refresh(); // This forces the UI to update
          } catch (e) {
            // Parsing failed: show an empty user model.
            user(UserModel.empty());
            user.refresh(); // This forces the UI to update
          }
        } else {
          // No stored data available: set an empty user model.
          user(UserModel.empty());
          user.refresh(); // This forces the UI to update
        }
      }
    } catch (e) {
      // TLoaders.warningSnackBar(title: 'Warning', message: 'Leak in user data');
      // In the event of an error, attempt to load offline stored data.
      final storedData = userLocaleData.read(TTexts.kuserData);
      if (storedData != null) {
        try {
          user(UserModel.fromJson(storedData));
        } catch (e) {
          user(UserModel.empty());
          user.refresh(); // This forces the UI to update
        }
      } else {
        user(UserModel.empty());
        user.refresh(); // This forces the UI to update
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
      await userRepository.updateFavoriteProductDetails(
          updatedProduct: product);
      userLocaleData.write(TTexts.kFavoriteList, localeFavoriteListProducts);

      fetchUserRecord();
    } catch (e) {
      TLoaders.warningSnackBar(
          title: 'Something went wrong', message: e.toString());
    }
  }

  // A helper to update the reactive variable and write to storage.
  void updateProfileImagePath(String newPath) {
    profileImagePath.value = newPath;
    final localStorage = GetStorage();
    localStorage.write(TTexts.kProfileImage, newPath);
  }

  // This function will be called to update the profile image.
  // It uses the helper class below to pick and save the image.
  Future<void> updateLocalProfileImage() async {
    // Create an instance of your storage helper
    final storage = ProfileImageStoreLocally();
    final pickedImage = await storage.pickImage();
    if (pickedImage != null) {
      // Save the image locally and get the file.
      final savedFile = await storage.saveProfileImage(pickedImage);
      if (savedFile != null) {
        // Update the reactive variable with the new file path.
        updateProfileImagePath(savedFile.path);
      }
    }
  }
}
