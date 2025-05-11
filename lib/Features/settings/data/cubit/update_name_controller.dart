import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constants/image_strings.dart';
import '../../../../core/utils/network/network_manager.dart';
import '../../../../core/utils/popups/full_screen_loader.dart';
import '../../../../core/widgets/user/user_controller.dart';
import '../../../Signin/data/repo/user_repository.dart';

// Make sure to import the following dependencies as they are assumed to be defined in your project:
// import 'package:your_project/controllers/user_controller.dart';
// import 'package:your_project/repositories/user_repository.dart';
// import 'package:your_project/network/network_manager.dart';
// import 'package:your_project/widgets/t_full_screen_loader.dart';
// import 'package:your_project/constants/t_images.dart';

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

      // Check Internet Connectivity.
      final bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Handle no internet connection (e.g., show an error message).
      }

      // Update user name logic here.
      // For example, you might call:
      // await userRepository.updateUserName(firstName.text, lastName.text);
    } catch (e) {
      // Handle error (you may log the error or display an error message).
    } finally {
      // Close the loading dialog.
      TFullScreenLoader.stopLoading();
    }
  }
}
