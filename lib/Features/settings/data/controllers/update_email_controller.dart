import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rjs_store/core/utils/popups/loaders.dart';
import 'package:rjs_store/navigation_menu.dart';
import '../../../../core/utils/constants/image_strings.dart';
import '../../../../core/utils/network/network_manager.dart';
import '../../../../core/utils/popups/full_screen_loader.dart';
import '../../../../core/widgets/user/user_controller.dart';
import '../../../Signin/data/repo/user_repository.dart';

class UpdateEmailController extends GetxController {
  static UpdateEmailController get instance => Get.find();

  // TextEditingController to capture email input.
  final email = TextEditingController();

  // Access your user data controller.
  final userController = UserController.instance;

  // Repository for user-related operations.
  final userRepository = Get.put(UserRepository());

  // GlobalKey to manage the Email update form.
  GlobalKey<FormState> updateEmailFormKey = GlobalKey<FormState>();

  /// Called when the controller is first initialized.
  @override
  void onInit() {
    initializeEmail();
    super.onInit();
  }

  /// Pre-populate the email field with the current email.
  Future<void> initializeEmail() async {
    email.text = userController.user.value.email;
  }

  /// Updates the user's email.
  Future<void> updateEmail() async {
    try {
      // Show the full-screen loader.
      TFullScreenLoader.openLoadingDialog(
        'Updating your email...',
        TImages.dacerAnimation,
      );

      // Check Internet connectivity.
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
            title: 'No Internet Connection',
            message: 'Please check your network settings.');
        return;
      }

      // Build the update payload using a helper function.
      final Map<String, dynamic> updatedFields = _buildUpdatedFields();

      if (kDebugMode) {
        print('Updated Email Fields: $updatedFields');
      }

      // Update the user record.
      await userRepository.updateSingleField(updatedFields);
      await userRepository.fetchUserDetails();

      TFullScreenLoader.stopLoading();

      // Show success message.
      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your email has been updated',
      );

      // Navigate to the home (or profile) screen.
      Get.offAll(() => const NavigationMenu());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        title: 'Something went wrong',
        message: e.toString(),
      );
    }
  }

  /// Helper function to construct the update payload.
  Map<String, dynamic> _buildUpdatedFields() {
    final String newEmail = email.text.trim().toLowerCase();
    return {
      'email': newEmail,
      'userData': {
        'Email': newEmail,
      },
    };
  }
}
