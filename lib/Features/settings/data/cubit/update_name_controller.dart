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

/// Controller to manage user-related functionality.
class UpdateNameController extends GetxController {
  // Retrieve the instance of UpdateNameController using GetX dependency injection.
  static UpdateNameController get instance => Get.find();

  // TextEditingControllers for capturing the user's first and last names.
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  // Access the user data controller (assumed to be already defined).
  final userController = UserController.instance;
  // Instantiate the UserRepository for user-related operations.
  final userRepository = Get.put(UserRepository());
  // GlobalKey to manage the state of the Name update form.
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  /// Called when the controller is first initialized.
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  /// Initializes the text fields with the current user data.
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  /// Updates the user's name.
  Future<void> updateUserName() async {
    try {
      // Start the loading dialog.
      TFullScreenLoader.openLoadingDialog(
        'We are updating your information...',
        TImages.dacerAnimation,
      );

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Build the update payload using a helper function.
      final Map<String, dynamic> updatedFields = _buildUpdatedFields();

      // Debug prints (if running in debug mode).
      if (kDebugMode) {
        print('Updated Fields: $updatedFields');
        print('Proceeding with update...');
      }

      // Call the update function with the constructed JSON payload.
      await userRepository.updateSingleField(updatedFields);

      // Optionally, fetch user details after updating.
      await userRepository.fetchUserDetails();

      TFullScreenLoader.stopLoading();

      // Show success message.
      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your Name has been updated',
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

  /// Helper function to build the updatedFields map.
  Map<String, dynamic> _buildUpdatedFields() {
    final String trimmedFirstName = firstName.text.trim();
    final String trimmedLastName = lastName.text.trim();

    return {
      'firstName': trimmedFirstName,
      'lastName': trimmedLastName,
      'userData': {
        'FirstName': trimmedFirstName,
        'LastName': trimmedLastName,
      },
    };
  }
}
