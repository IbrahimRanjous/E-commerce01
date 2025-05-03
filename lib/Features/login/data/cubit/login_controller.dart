import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rjs_store/core/utils/constants/texts.dart';
import 'package:rjs_store/core/utils/network/network_manager.dart';
import 'package:rjs_store/core/utils/popups/full_screen_loader.dart';
import 'package:rjs_store/core/utils/popups/loaders.dart';
import 'package:rjs_store/core/utils/repositories/authentication_repository.dart';
import 'package:rjs_store/core/widgets/user/user_controller.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  // Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

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
      TFullScreenLoader.openLoadingDialog('Loggin you in ... ',
          'assets/images/animations/141594-animation-of-docer.json');

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
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
        return;
      }

      // Google Authentication
      final userCredentials =
          await AuthenticationRepository.Instance.signInWithGoogle();

      // Save User Record
      await userController.saveUserRecord(userCredentials);

      // // Remove Loader
      // TFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.Instance.screenRedirect();
    } catch (e) {
      // Remove Loader
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
