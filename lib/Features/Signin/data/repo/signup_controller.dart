import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:rjs_store/Features/Signin/data/repo/user_repository.dart';
import 'package:rjs_store/Features/Signin/view/verify_email_view.dart';
// import 'package:rjs_store/core/utils/network/network_manager.dart';
import 'package:rjs_store/core/utils/popups/full_screen_loader.dart';
import 'package:rjs_store/core/utils/popups/loaders.dart';
import 'package:rjs_store/core/utils/repositories/authentication_repository.dart';

import '../../../../core/utils/network/network_manager.dart';
// import '../cubit/user_model.dart';

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

  /// -- Sign Up
  void signup() async {
    try {
      /// start loading
      TFullScreenLoader.openLoadingDialog(
          'We are processing your information...',
          'assets/images/animations/loader-animation.json');

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        TFullScreenLoader.stopLoading();
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
      // final userCredential =
      //     await AuthenticationRepository.Instance.registerWithEmailAndPassword(
      //         email.text.trim(), password.text.trim());

      /// save authenticated user data in the firebase firestore
      // final newUser = UserModel(
      //   id: userCredential.user!.uid,
      //   firstName: firstName.text.trim(),
      //   lastName: lastName.text.trim(),
      //   userName: userName.text.trim(),
      //   email: email.text.trim(),
      //   phoneNumber: phoneNumber.text.trim(),
      //   profilePicture: '',
      // );
      // final userRepository = Get.put(UserRepository());
      // await userRepository.saveUserRecord(newUser);

      // Remove Loader
      TFullScreenLoader.stopLoading();

      /// show success message
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your account has been created. Verify email to continue.');

      /// move to verify email screen
      Get.to(() => const VerifyEmailView());
    } catch (e) {
      // remove loader
      TFullScreenLoader.stopLoading();
      // show some generic error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
