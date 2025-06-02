import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rjs_store/Features/Signin/data/repo/user_repository.dart';
import 'package:rjs_store/Features/Signin/view/verify_email_view.dart';
import 'package:rjs_store/Features/login/views/login_view.dart';
import 'package:rjs_store/Features/onBoarding/views/onboarding_view.dart';
import 'package:rjs_store/core/utils/constants/texts.dart';
import 'package:rjs_store/core/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:rjs_store/core/utils/exceptions/firebase_exceptions.dart';
import 'package:rjs_store/core/utils/exceptions/format_exceptions.dart';
import 'package:rjs_store/core/utils/exceptions/platform_exceptions.dart';
import 'package:rjs_store/core/utils/network/network_manager.dart';
import 'package:rjs_store/core/utils/popups/loaders.dart';
import 'package:rjs_store/navigation_menu.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class AuthenticationRepository extends GetxController {
  // ignore: non_constant_identifier_names
  static AuthenticationRepository get Instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  /// Get Authentication User Data
  User? get authUser => _auth.currentUser;

  Future<bool> isConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    // ignore: unrelated_type_equality_checks
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
// Use the singleton instance provided by the package.
    return await InternetConnectionChecker.instance.hasConnection;
  }

  /// Called from main.dart on app lunch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  /// Function to Show Relevant Screen
  Future<void> screenRedirect() async {
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
        deviceStorage.read(TTexts.kLoggedIn) == true
            ? {Get.offAll(() => const NavigationMenu())}
            : {
                TLoaders.successSnackBar(
                    title: 'Let\'s Go', message: 'You are logged in'),
                Get.offAll(() => const NavigationMenu())
              };
      } else {
        TLoaders.warningSnackBar(
            title: 'Ops!!!', message: 'user email is not verified !');
        Get.offAll(() => VerifyEmailView(
              email: _auth.currentUser!.email,
            ));
      }
    } else {
      /// Local Storage
      deviceStorage.writeIfNull(TTexts.kIsFirstTime, true);
      if (kDebugMode) {
        print(
            ' =================== Get Storage Auth Repo =================== ');
        print(
            'First time open app :${deviceStorage.read(TTexts.kIsFirstTime)}');
      }

      deviceStorage.read(TTexts.kIsFirstTime) != true
          ? Get.offAll(() => const LoginView())
          : Get.offAll(() => const OnboardingView());
    }
  }

  /// ====================== Email & Password Sing-in ====================== ///

  /// [Email Authentication] - Login
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    if (!await isConnected()) {
      throw 'No internet connection. Please check your network settings.';
    }

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
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(
            title: 'No Internet Connection',
            message: 'Please check your network settings.');
      }

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
  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      // Create a credential
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      // ReAuthenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
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
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
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

  /// ====================== Federated identity & Social Sign-in ====================== ///

  /// [Google Authentication] - Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      if (userAccount == null) {
        if (kDebugMode) print('User cancelled the Google sign-in.');
        return null;
      }
      if (kDebugMode) print('User Account found: ${userAccount.email}');

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await userAccount.authentication;

      // Create a new credential
      // Note: You may also want to pass idToken if required by your Firebase project.
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // save data
      final user = Get.put(UserRepository());
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final String uid = userCredential.user!.uid;
      user.saveUserRecordByBack4app(userAccount, uid);

      // Once signed in , return the UserCredential
      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Something went wrong : $e');
      return null;
    }
  }

  /// [Facebook Authentication] - Facebook
  ///////// Not Working //////////
  /// ====================== ./end Federated Identity & Social Sign-in ====================== ///

  /// [Logout User] - Valid for any authentication
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
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
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord();
      await _auth.currentUser?.delete();
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
}
