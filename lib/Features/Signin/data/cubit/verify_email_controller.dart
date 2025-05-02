import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:rjs_store/Features/Signin/view/success_view.dart';
import 'package:rjs_store/core/utils/constants/image_strings.dart';
import 'package:rjs_store/core/utils/constants/texts.dart';
import 'package:rjs_store/core/utils/popups/loaders.dart';
import 'package:rjs_store/core/utils/repositories/authentication_repository.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  /// Send Email whenever verify screen appears & Set timer for auto redirect.
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  /// Send Email verification link
  void sendEmailVerification() async {
    try {
      await AuthenticationRepository.Instance.sendEmailVerification();
      TLoaders.successSnackBar(
          title: "Email Sent!",
          message: 'Please check your email and verify your email');
    } catch (e) {
      TLoaders.errorSnackBar(title: "OPSSS!", message: e.toString());
    }
  }

  /// Timer to automatically redirect on Email verfication
  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      try {
        await FirebaseAuth.instance.currentUser?.reload();
      } on Exception catch (_) {
        TLoaders.errorSnackBar(
            title: 'Failed',
            message: 'Error while reloading email verification');
      }

      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(
          () => SuccessView(
              image: TImages.staticSuccessIllustration,
              title: TTexts.yourAccountCreatedTitle,
              subTitle: TTexts.yourAccountCreatedSubTitle,
              onPressed: () =>
                  AuthenticationRepository.Instance.screenRedirect()),
        );
      }
    });
  }

  /// Manually check if Email verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(
        () => SuccessView(
          image: TImages.staticSuccessIllustration,
          title: TTexts.yourAccountCreatedTitle,
          subTitle: TTexts.yourAccountCreatedSubTitle,
          onPressed: () => AuthenticationRepository.Instance.screenRedirect(),
        ),
      );
      VerifyEmailController.instance.onClose();
    }
  }
}
