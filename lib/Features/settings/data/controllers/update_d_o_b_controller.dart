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

class UpdateDOBController extends GetxController {
  static UpdateDOBController get instance => Get.find();

  // TextEditingController for the date of birth.
  final dob = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateDOBFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeDOB();
    super.onInit();
  }

  Future<void> initializeDOB() async {
    // Assuming your user model has a dateOfBirth field of type DateTime.
    final DateTime? dobValue = userController.user.value.dateOfBirth;
    if (dobValue != null) {
      // Format the date for display, e.g., "2025-05-12"
      dob.text = dobValue.toLocal().toString().split(' ')[0];
    }
  }

  Future<void> updateDOB() async {
    try {
      TFullScreenLoader.openLoadingDialog(
        'Updating your date of birth...',
        TImages.dacerAnimation,
      );

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
            title: 'No Internet Connection',
            message: 'Please check your network settings.');
        return;
      }

      final Map<String, dynamic> updatedFields = _buildUpdatedFields();

      if (kDebugMode) {
        print('Updated DOB Fields: $updatedFields');
      }

      await userRepository.updateSingleField(updatedFields);
      await userRepository.fetchUserDetails();
      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your date of birth has been updated',
      );
      Get.offAll(() => const NavigationMenu());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        title: 'Something went wrong',
        message: e.toString(),
      );
    }
  }

  Map<String, dynamic> _buildUpdatedFields() {
    final String newDOBStr = dob.text.trim();

    // Convert the string to a DateTime object.
    final DateTime newDOB = DateTime.parse(newDOBStr);

    return {
      'dateOfBirth': newDOB, // Send a DateTime value
      'userData': {
        'DateOfBirth': newDOB
            .toIso8601String(), // Optionally store as ISO string in userData
      },
    };
  }
}
