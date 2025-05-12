import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/network/network_manager.dart';
import '../../../../core/utils/popups/full_screen_loader.dart';
import '../../../../core/utils/popups/loaders.dart';
import '../../../../core/utils/repositories/authentication_repository.dart';
import '../../view/verify_email_view.dart';
import '../repo/user_repository.dart';
import 'user_model.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Variables
  final hidePassword = true.obs; // Observable for hiding/showing password
  final privacyPolicy = false.obs; // Observable for privacy policy acceptance
  final email = TextEditingController();
  final userName = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  // Form key for form validation
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // For Best Practices: (Prevents Memory Leaks)+(Efficient Resource Management)+(Clean Widget Lifecycle)+(Avoids Unexpected Behavior)
  @override
  void dispose() {
    email.dispose();
    userName.dispose();
    firstName.dispose();
    lastName.dispose();
    password.dispose();
    phoneNumber.dispose();
    super.dispose();
  }

  /// -- Sign Up
  void signup() async {
    try {
      /// start loading
      TFullScreenLoader.openLoadingDialog(
          'We are processing your information...',
          'assets/images/animations/cloud-uploading-animation.json');

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
            title: 'No Internet Connection',
            message: 'Please check your network settings.');
        return;
      }

      /// Form Validaion
      if (!signupFormKey.currentState!.validate()) {
        // Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Privacy Policy Check
      if (!privacyPolicy.value) {
        // Remove Loader
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'In order to create account , you must have to read and accept the Privacy Policy & Terms of Use.');
        return;
      }

      /// Register user in the firebase authentication & Save user data in the firebase
      final userCredential =
          await AuthenticationRepository.Instance.registerWithEmailAndPassword(
              email.text.trim().toLowerCase(), password.text.trim());

      // confirm userCredential.user is not null
      if (userCredential.user == null) {
        throw Exception('User credential is null!');
      }
      if (kDebugMode) {
        print(
            'Regesteringggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg');
      }

      /// save authenticated user data in the firebase firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        userName: userName.text.trim(),
        email: email.text.trim().toLowerCase(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
        dateOfBirth: null,
      );
      if (kDebugMode) {
        print('Creating modelllllllllllllllllllllllllllllllllllllllllllllllll');
      }
      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Remove Loader
      TFullScreenLoader.stopLoading();

      /// show success message
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your account has been created. Verify email to continue.');

      /// move to verify email screen
      Get.to(() => VerifyEmailView(
            email: email.text.trim().toLowerCase(),
          ));
    } catch (e) {
      // remove loader
      TFullScreenLoader.stopLoading();
      // show some generic error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  @override
  void onClose() {
    // Cleanup logic here
    if (kDebugMode) {
      print("LoginController disposed");
    }
    super.onClose();
  }
}
