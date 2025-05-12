import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rjs_store/core/utils/constants/texts.dart';
import 'package:rjs_store/core/utils/network/network_manager.dart';
import 'package:rjs_store/core/utils/popups/full_screen_loader.dart';
import 'package:rjs_store/core/utils/popups/loaders.dart';
import 'package:rjs_store/core/utils/repositories/authentication_repository.dart';
import '../../../../core/utils/constants/image_strings.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  // Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  // For Best Practices: (Prevents Memory Leaks)+(Efficient Resource Management)+(Clean Widget Lifecycle)+(Avoids Unexpected Behavior)
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    email.text = localStorage.read(TTexts.kEmail) ?? '';
    // password.text = localStorage.read(TTexts.kPassword) ?? '';
    super.onInit();
  }

  /// -- Email and password log in
  Future<void> emailAndPasswordLogin() async {
    try {
      // start internet connectivity
      TFullScreenLoader.openLoadingDialog(
        'Loggin you in ... ',
        TImages.dacerAnimation,
      );

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
            title: 'No Internet Connection',
            message: 'Please check your network settings.');
        return;
      }

      // Form Validation
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save Data if Remember Me is selected
      if (rememberMe.value) {
        localStorage.write(TTexts.kEmail, email.text.trim().toLowerCase());
        // localStorage.write(TTexts.kPassword, password.text.trim());
      } else {
        localStorage.write(TTexts.kEmail, '');
      }

      // login user using Email & Password Authentication
      // final userCredentials =
      await AuthenticationRepository.Instance.loginWithEmailAndPassword(
          email.text.trim().toLowerCase(), password.text.trim());

      // Redirect
      AuthenticationRepository.Instance.screenRedirect();
      // // Remove Loader
      // TFullScreenLoader.stopLoading();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// -- Google Login Authentication
  Future<void> loginWithGoogle() async {
    try {
      // Start loading
      TFullScreenLoader.openLoadingDialog('Logging you in',
          'assets/images/animations/141594-animation-of-docer.json');

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
            title: 'No Internet Connection',
            message: 'Please check your network settings.');
        return;
      }

      // Google Authentication & Save User Record
      await AuthenticationRepository.Instance.signInWithGoogle();

      /// Remove Loader
      // TFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.Instance.screenRedirect();
    } catch (e) {
      // Remove Loader
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
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
