import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rjs_store/Features/Signin/data/cubit/signup_controller.dart';
import 'package:rjs_store/core/utils/exceptions/firebase_exceptions.dart';
import 'package:rjs_store/core/utils/exceptions/format_exceptions.dart';
import 'package:rjs_store/core/utils/repositories/authentication_repository.dart';
import '../../../../core/utils/exceptions/platform_exceptions.dart';
import '../../../../core/utils/popups/loaders.dart';
import '../cubit/user_model.dart';

/// Repository class for user-related operations.
class UserRepository extends GetxController {
  // Provides a static way to access the UserRepository instance using Get.find().
  static UserRepository get instance => Get.find();

  // Firestore instance.
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final userData = SignupController.instance;

  /// Function to save user data to Firestore.
  Future<void> saveUserRecord(UserModel user) async {
    // try {
    //   if (kDebugMode) {
    //     print(
    //         "//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////Saving User Dataaaaaaaaaaaaaaaa .");
    //   }
    //   if (FirebaseAuth.instance.currentUser != null) {
    //     final docRef =
    //         FirebaseFirestore.instance.collection('users').doc(user.id);
    //     if (kDebugMode) {
    //       print(
    //           "  DocRefffffffffffffffffffffffffffffffffffffffffffffffffffff .");
    //     }
    //     await docRef.set(user.toJson());
    //     if (kDebugMode) {
    //       print(
    //           "//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////User saved successfully.");
    //     }
    //   } else {
    //     if (kDebugMode) {
    //       print(
    //           "/////////////\n//////////////////////////////////////////\n////////////////////////////////////////////");
    //     }
    //   }
    // } on FirebaseException catch (e) {
    //   throw TFirebaseException(e.code).message;
    // } on FormatException catch (_) {
    //   throw const TFormatException();
    // } on PlatformException catch (e) {
    //   throw TPlatformException(e.code).message;
    // } catch (e) {
    //   throw 'Something went wrong. Please try again';
    // }

    try {
      if (FirebaseAuth.instance.currentUser != null) {
        if (kDebugMode) {
          print("Current User UID: ${FirebaseAuth.instance.currentUser!.uid}");
          print("UserModel id: ${user.id}");
        }
        // Attempt to write data here
        final docRef =
            _db.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);
        await docRef.set(user.toJson()).timeout(Duration(seconds: 10),
            onTimeout: () {
          throw Exception("Firestore write timed out");
        });

        if (kDebugMode) {
          print("User saved successfully.");
        }
      } else {
        if (kDebugMode) {
          print("User is not authenticated.");
        }
      }
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print("Error during Firestore set: $e");
        print(stacktrace);
      }
      rethrow;
    }
  }

  /// Function to save user data by google login to Firestore.
  Future<void> saveUserRecordByGoogle(GoogleSignInAccount account) async {
    try {
      await _db.collection('users').doc(account.email).set({
        'Email': account.email,
        "FirstName": account.displayName,
        "ProfilePicture": account.photoUrl,
      });
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

  /// Function to fetch user details based on user ID
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc(AuthenticationRepository.Instance.authUser?.email)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        TLoaders.warningSnackBar(
            title: 'Warning', message: 'Leak in user data');

        return UserModel.empty();
      }
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

  /// Function to update user data in Firestor.
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db
          .collection('Users')
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
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

  /// Update any field in specific Users Collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection('Users')
          .doc(AuthenticationRepository.Instance.authUser?.uid)
          .update(json);
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

  /// Function to remove user data from Firestore.
  Future<void> removeUserRecod(String userID) async {
    try {
      await _db.collection('Users').doc(userID).delete();
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

  /// Upload any Image
}
