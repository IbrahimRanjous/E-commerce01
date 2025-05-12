import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
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

  /// Function to save user data to Firestore.
  Future<void> saveUserRecord(UserModel user) async {
    try {
      if (kDebugMode) {
        print("Saaaaaaaaaaaaaaaaaaaaaavinggggggggggggggggggggggg");
      }
      var userData = ParseObject('Users')
        ..set('userData', user.toJson())
        ..set('accountID', user.id)
        ..set('firstName', user.firstName)
        ..set('lastName', user.lastName)
        ..set('userName', user.userName)
        ..set('phoneNumber', user.phoneNumber)
        ..set('email', user.email);
      await userData.save();
      if (kDebugMode) {
        print("Finiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiish");
      }
      if (userData.objectId == null) {
        var response = await userData.saveEventually();
        if (response.success == false) {
          throw 'Data Not Saved';
        }
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Something Wrong', message: e.toString());
    }
  }

  /// Function to save user data by google login to back4app
  Future<void> saveUserRecordByBack4app(GoogleSignInAccount userAccount) async {
    try {
      // save data
      if (kDebugMode) {
        print("Saaaaaaaaaaaaaaaaaaaaaavinggggggggggggggggggggggg");
      }
      var userData = ParseObject('Users')
        ..set('email', userAccount.email)
        ..set('userName', userAccount.displayName)
        ..set('profilePhoto', userAccount.photoUrl);

      await userData.save();
      if (kDebugMode) {
        print("Finiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiish");
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

  /// Function to fetch user details based on user ID
  Future<UserModel> fetchUserDetails() async {
    try {
      // Retrieve all objects of the "Profile" class
      final apiResponse = await ParseObject('Users').getAll();
      final key = AuthenticationRepository.Instance.authUser!.uid;
      if (apiResponse.success && apiResponse.results != null) {
        // Assuming you need to fetch user details based on the provided key
        for (var o in apiResponse.results!) {
          final object = o as ParseObject;

          // Validate if the object matches the key (assuming objectId is the key)
          if (object.get<String>('accountID') == key) {
            if (kDebugMode) {
              print(
                  '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
              print(object.get<String>('userName'));
            }
            return UserModel(
              id: object.objectId!,
              userName: object.get<String>('userName') ?? '',
              firstName: object.get<String>('firstName') ?? '',
              lastName: object.get<String>('lastName') ?? '',
              phoneNumber: object.get<String>('phoneNumber') ?? '',
              email: object.get<String>('email') ?? '',
              profilePicture: object.get<String>('profilePicture') ?? '',
            );
          } else {
            TLoaders.warningSnackBar(
                title: "Warning", message: 'The user data not fetched');
            return UserModel.empty();
          }
        }
      }

      // If no matching user is found, return an error
      throw 'User not found';
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
      // Create a ParseObject representing the user
      final userObject = ParseObject('Users')
        ..objectId = updatedUser.id
        ..set<String>('userName', updatedUser.userName)
        ..set<String>('firstName', updatedUser.firstName)
        ..set<String>('lastName', updatedUser.lastName)
        ..set<String>('phoneNumber', updatedUser.phoneNumber)
        ..set<String>('email', updatedUser.email)
        ..set<String>('profilePicture', updatedUser.profilePicture);

      // Update the object on Back4App
      final apiResponse = await userObject.save();

      if (!apiResponse.success) {
        throw 'Failed to update user details: ${apiResponse.error?.message}';
      }
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Update any field in specific Users Collection
  /// OLLLLD
  // Future<void> updateSingleField(Map<String, dynamic> json) async {
  //   try {
  //     // Get the user ID from the authentication repository
  //     final userId = AuthenticationRepository.Instance.authUser?.uid;
  //     if (userId == null) throw 'User ID is null';
  //     // Create a ParseObject for the user
  //     final userObject = ParseObject('Users')..objectId;
  //     // Set the fields dynamically based on the provided JSON
  //     json.forEach((key, value) {
  //       userObject.set<dynamic>(key, value);
  //     });
  //     // Save the updated object to Back4App
  //     final apiResponse = await userObject.save();
  //     if (!apiResponse.success) {
  //       throw 'Failed to update user field: ${apiResponse.error?.message}';
  //     }
  //   } on FormatException catch (_) {
  //     throw const TFormatException();
  //   } on PlatformException catch (e) {
  //     throw TPlatformException(e.code).message;
  //   } catch (e) {
  //     throw 'Something went wrong. Please try again';
  //   }
  // }
  /// Update any field in specific Users Collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      // Get the current authenticated user's accountID.
      final String? currentUserId =
          AuthenticationRepository.Instance.authUser?.uid;
      if (currentUserId == null) {
        throw 'User ID is null';
      }

      // Automatically insert the accountID if not provided.
      json.putIfAbsent('accountID', () => currentUserId);

      // If objectId is not provided, retrieve it by querying the Users table by accountID.
      if (!json.containsKey('objectId')) {
        final queryForObjectId = QueryBuilder<ParseObject>(ParseObject('Users'))
          ..whereEqualTo('accountID', currentUserId);
        final ParseResponse queryForObjectIdResponse =
            await queryForObjectId.query();

        if (!queryForObjectIdResponse.success ||
            queryForObjectIdResponse.results == null ||
            queryForObjectIdResponse.results!.isEmpty) {
          throw 'User not found';
        }

        final ParseObject userRecord =
            queryForObjectIdResponse.results!.first as ParseObject;
        json['objectId'] = userRecord.objectId;
      }

      // Extract the identifiers.
      final String objectId = json['objectId'];
      final String accountID = json['accountID'];

      // Double-check that our authenticated user matches the payload.
      if (currentUserId != accountID) {
        throw 'Authenticated user does not match provided accountID.';
      }

      // Query for the user object with both unique identifiers.
      final query = QueryBuilder<ParseObject>(ParseObject('Users'))
        ..whereEqualTo('objectId', objectId)
        ..whereEqualTo('accountID', accountID);
      final ParseResponse queryResponse = await query.query();
      if (!queryResponse.success ||
          queryResponse.results == null ||
          queryResponse.results!.isEmpty) {
        throw 'User not found';
      }

      // Retrieve the user object from the query result.
      final userObject = queryResponse.results!.first as ParseObject;

      // Remove unique identifiers from the JSON update payload to avoid overwriting them.
      json.remove('objectId');
      json.remove('accountID');

      // Check for nested "userData" updates.
      Map<String, dynamic>? nestedUserData;
      if (json.containsKey('userData') &&
          json['userData'] is Map<String, dynamic>) {
        nestedUserData = json.remove('userData');
      }

      // Dynamically update only the provided top-level fields.
      json.forEach((key, value) {
        userObject.set<dynamic>(key, value);
      });

      // If there are updates for userData, merge them with the existing data.
      if (nestedUserData != null) {
        // Try to retrieve the current userData from the object.
        Map<String, dynamic> currentUserData = {};
        final existingUserData = userObject.get('userData');
        if (existingUserData != null &&
            existingUserData is Map<String, dynamic>) {
          currentUserData = Map<String, dynamic>.from(existingUserData);
        }
        // Merge the provided keys into the current userData.
        nestedUserData.forEach((key, value) {
          currentUserData[key] = value;
        });
        // Save the merged result back into userData.
        userObject.set<Map<String, dynamic>>('userData', currentUserData);
      }

      // Save the changes to Back4App.
      final apiResponse = await userObject.save();
      if (!apiResponse.success) {
        throw 'Failed to update user field: ${apiResponse.error?.message}';
      }
      print(
          'Saaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaavedddddddddddddddddddddddd');
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Function to remove user data from Firestore.
  Future<void> removeUserRecord(String storeID) async {
    try {
      // Get the current authenticated user's accountID.
      final String? currentUserId =
          AuthenticationRepository.Instance.authUser?.uid;
      if (currentUserId == null) {
        throw 'User ID is null';
      }

      // Create a ParseObject for the user with the specified objectId
      final queryForObjectId = QueryBuilder<ParseObject>(ParseObject('Users'))
        ..whereEqualTo('accountID', currentUserId);
      final ParseResponse queryForObjectIdResponse =
          await queryForObjectId.query();

      if (!queryForObjectIdResponse.success ||
          queryForObjectIdResponse.results == null ||
          queryForObjectIdResponse.results!.isEmpty) {
        throw 'User not found';
      }

      final ParseObject userRecord =
          queryForObjectIdResponse.results!.first as ParseObject;

      // Attempt to delete the user record from Back4App
      final apiResponse = await userRecord.delete();

      if (!apiResponse.success) {
        TLoaders.errorSnackBar(
            title: 'Failed to remove user record',
            message: ' ${apiResponse.error?.message}');
      }
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
