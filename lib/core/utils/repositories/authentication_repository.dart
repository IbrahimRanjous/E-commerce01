import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rjs_store/Features/login/views/login_view.dart';
import 'package:rjs_store/Features/onBoarding/views/onboarding_view.dart';
import 'package:rjs_store/core/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:rjs_store/core/utils/exceptions/format_exceptions.dart';
import 'package:rjs_store/core/utils/exceptions/platform_exceptions.dart';
import '../exceptions/firebase_exceptions.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository extends GetxController {
  // ignore: non_constant_identifier_names
  static AuthenticationRepository get Instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  /// Called from main.dart on app lunch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  /// Function to Show Relevant Screen
  screenRedirect() async {
    // Local Storage

    deviceStorage.writeIfNull(kIsFirstTime, true);
    if (kDebugMode) {
      print(' =================== Get Storage Auth Repo =================== ');
      print('First time open app :${deviceStorage.read(kIsFirstTime)}');
    }

    deviceStorage.read(kIsFirstTime) != true
        ? Get.offAll(() => const LoginView())
        : Get.offAll(() => const OnboardingView());
  }

  /// ====================== Email & Password Sing-in ====================== ///

  /// [Email Authentication] - SignIn

  /// [Email Authentication] - Register
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on TFirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on TFormatException catch (_) {
      throw const TFormatException();
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  /// [ReAuthenticate] - ReAuthenticate User

  /// [Email Verification] - Mail Verification

  /// [Email Authentication] - Forget Password

  /// ====================== Federated identity & Social Sign-in ====================== ///

  /// [Google Authentication] - Google

  /// [Facebook Authentication] - Facebook

  /// ====================== ./end Federated Identity & Social Sign-in ====================== ///

  /// [Logout User] - Valid for any authentication

  /// Delete User - Remove user Auth and Firestore Account
}
