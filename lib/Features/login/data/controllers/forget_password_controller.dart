import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rjs_store/Features/login/views/password_reset_view.dart';
import 'package:rjs_store/core/utils/network/network_manager.dart';
import 'package:rjs_store/core/utils/popups/full_screen_loader.dart';
import 'package:rjs_store/core/utils/popups/loaders.dart';
import 'package:rjs_store/core/utils/repositories/authentication_repository.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  /// Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  /// Send reset password email
  void sendPasswordResetEmail() async {
    try {
      // Strart Loader
      TFullScreenLoader.openLoadingDialog('Processing your request ... ',
          'assets/images/animations/141594-animation-of-docer.json');
      // Check internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
            title: 'No Internet Connection',
            message: 'Please check your network settings.');
        return;
      }
      // Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Send email to reset password
      await AuthenticationRepository.Instance.sendPasswordResetEmail(
          email.text.trim());

      // Remove loader
      TFullScreenLoader.stopLoading();

      // Show success screen
      TLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Email link sent to reset your password');

      // redirect
      Get.to(() => PasswordResetView(email: email.text.trim()));
    } catch (e) {
      // Remove loader
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  void resendPasswordResetEmail(String email) async {
    try {
      // Strart Loader
      TFullScreenLoader.openLoadingDialog('Processing your request ... ',
          'assets/images/animations/141594-animation-of-docer.json');
      // Check internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
            title: 'No Internet Connection',
            message: 'Please check your network settings.');
        return;
      }

      // Send email to reset password
      await AuthenticationRepository.Instance.sendPasswordResetEmail(email);

      // Remove loader
      TFullScreenLoader.stopLoading();

      // Show success screen
      TLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Email link sent to reset your password');
    } catch (e) {
      // Remove loader
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
