import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rjs_store/Features/Signin/view/verify_email_view.dart';
import 'package:rjs_store/Features/login/views/login_view.dart';
import 'package:rjs_store/Features/onBoarding/views/onboarding_view.dart';
import 'package:rjs_store/core/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:rjs_store/core/utils/exceptions/firebase_exceptions.dart';
import 'package:rjs_store/core/utils/exceptions/format_exceptions.dart';
import 'package:rjs_store/core/utils/exceptions/platform_exceptions.dart';
import 'package:rjs_store/core/utils/popups/loaders.dart';
import 'package:rjs_store/navigation_menu.dart';

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
    final user = _auth.currentUser;
    if (user != null) {
      try {
        // Reload the user's data to update the emailVerified flag.
        await user.reload();
      } catch (e) {
        TLoaders.errorSnackBar(
            title: 'Something Wrong',
            message: 'Something went wrong. Please try again');
      }
      if (user.emailVerified) {
        TLoaders.successSnackBar(
            title: 'Let\'s Go', message: 'You are logged in');
        Get.offAll(() => const NavigationMenu());
      } else {
        TLoaders.warningSnackBar(
            title: 'Ops!!!', message: 'user email is not verified !');
        Get.offAll(() => VerifyEmailView(
              email: _auth.currentUser!.email,
            ));
      }
    } else {
      /// Local Storage
      deviceStorage.writeIfNull(kIsFirstTime, true);
      if (kDebugMode) {
        print(
            ' =================== Get Storage Auth Repo =================== ');
        print('First time open app :${deviceStorage.read(kIsFirstTime)}');
      }

      deviceStorage.read(kIsFirstTime) != true
          ? Get.offAll(() => const LoginView())
          : Get.offAll(() => const OnboardingView());
    }
  }

  /// ====================== Email & Password Sing-in ====================== ///

  /// [Email Authentication] - Login
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [Email Authentication] - Register
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [ReAuthenticate] - ReAuthenticate User

  /// [Email Verification] - Mail Verification
  Future<void> sendEmailVerification() async {
    try {
      return await _auth.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [Email Authentication] - Forget Password

  /// ====================== Federated identity & Social Sign-in ====================== ///

  /// [Google Authentication] - Google
  Future<void> signInWithGoogle() async {
    try {
      // Trigger the authentication flow 
      final GooogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await userAccount?.authentication;

      // Create a new credential
      final creadential = googleAuthProvider.creadential(accessToken : googleAuth?.accessToken);
      
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if(kDebugMode) print( 'Something went wrong : $e');
      return null;
    }
  }
  /// [Facebook Authentication] - Facebook

  /// ====================== ./end Federated Identity & Social Sign-in ====================== ///

  /// [Logout User] - Valid for any authentication
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginView());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Delete User - Remove user Auth and Firestore Account
}
