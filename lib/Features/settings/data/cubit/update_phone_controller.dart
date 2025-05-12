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

class UpdatePhoneController extends GetxController {
  static UpdatePhoneController get instance => Get.find();

  final phone = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updatePhoneFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializePhone();
    super.onInit();
  }

  Future<void> initializePhone() async {
    phone.text = userController.user.value.phoneNumber;
  }

  Future<void> updatePhone() async {
    try {
      TFullScreenLoader.openLoadingDialog(
        'Updating your phone number...',
        TImages.dacerAnimation,
      );

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final Map<String, dynamic> updatedFields = _buildUpdatedFields();

      if (kDebugMode) {
        print('Updated Phone Fields: $updatedFields');
      }

      await userRepository.updateSingleField(updatedFields);
      await userRepository.fetchUserDetails();
      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your phone number has been updated',
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
    final String newPhone = phone.text.trim();
    return {
      'phoneNumber': newPhone,
      'userData': {
        'PhoneNumber': newPhone,
      },
    };
  }
}
