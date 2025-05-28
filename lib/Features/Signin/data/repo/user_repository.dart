import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:rjs_store/core/utils/constants/texts.dart';
import 'package:rjs_store/core/utils/exceptions/firebase_exceptions.dart';
import 'package:rjs_store/core/utils/exceptions/format_exceptions.dart';
import 'package:rjs_store/core/utils/repositories/authentication_repository.dart';
import 'package:rjs_store/core/widgets/user/user_controller.dart';
import '../../../../core/product_model.dart';
import '../../../../core/utils/exceptions/platform_exceptions.dart';
import '../../../../core/utils/popups/loaders.dart';
import 'user_model.dart';

/// Repository class for user-related operations.
class UserRepository extends GetxController {
  // Provides a static way to access the UserRepository instance using Get.find().
  static UserRepository get instance => Get.find();

  /// -- Function to save user data to back4app.
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

      ////////////TO RELATION BEFORE SAVING /////////////////////

      await createRelationToProducts(userData);

      ///////////// FINAL SAVE (ONLY ONCE) /////////////////
      final ParseResponse saveResponseUser = await userData.save();

      if (!saveResponseUser.success) {
        throw 'Data Not Saved';
      }

      if (kDebugMode) {
        print("User and products relation saved successfully.");
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Something Wrong', message: e.toString());
    }
  }

  Future<void> createRelationToProducts(ParseObject userData) async {
    final QueryBuilder<ParseObject> productQuery =
        QueryBuilder<ParseObject>(ParseObject(TTexts.kProducts));

    final ParseResponse productsResponse = await productQuery.query();

    if (productsResponse.success &&
        productsResponse.results != null &&
        productsResponse.results!.isNotEmpty) {
      final relation = userData.getRelation('products');

      for (var product in productsResponse.results!) {
        relation.add(product as ParseObject);
      }

      if (kDebugMode) {
        print("All products added to the user relation.");
      }
    } else {
      if (kDebugMode) {
        print("No products found.");
      }
    }
  }

  // Future<ParseObject> createRelationToFavorites() async {
  //   // Create a new ParseObject in the Favorites class.
  //   ProductModel product = ProductModel.empty();
  //   ParseObject favoriteData = ParseObject(TTexts.kProducts)
  //     ..set('objectId', product.objectId)
  //     ..set('createdAt', product.createdAt.toIso8601String())
  //     ..set('updatedAt', product.updatedAt.toIso8601String())
  //     ..set('ACL', product.ACL)
  //     ..set('title', product.title)
  //     ..set('brand', product.brand)
  //     ..set('isVerified', product.isVerified)
  //     ..set('price', product.price)
  //     ..set('rating', product.rating)
  //     ..set('discount', product.discount)
  //     ..set('instock', product.instock)
  //     ..set('description', product.description)
  //     ..set('reviews', product.reviews)
  //     ..set('category', product.category)
  //     ..set('priceRange', product.priceRange)
  //     ..set('status', product.status)
  //     ..set('image', product.image);
  //   //////////////// ADD FAVORITE TO RELATION BEFORE SAVING /////////////////////
  //   // Query the global Favorite class for the favorites by its objectId.
  //   final QueryBuilder<ParseObject> favoriteQuery =
  //       QueryBuilder<ParseObject>(ParseObject(TTexts.kFavorite))
  //         ..whereEqualTo('objectId', product.objectId)
  //         ..setLimit(1);\
  //   final ParseResponse favoritesResponse = await favoriteQuery.query();
  //   if (favoritesResponse.success &&
  //       favoritesResponse.results != null &&
  //       favoritesResponse.results!.isNotEmpty) {
  //     // Get the relation field from favoriteData.
  //     // Here we assume the relation field is named "products" (i.e. it points to the global Products).
  //     final relation = favoriteData.getRelation('favorites');
  //     // Add each found product (should be only one since we queried by objectId) as a pointer.
  //     for (var prod in favoritesResponse.results!) {
  //       relation.add(prod as ParseObject);
  //     }
  //     if (kDebugMode) {
  //       print("Product pointer added to the favorite relation.");
  //     }
  //   } else {
  //     if (kDebugMode) {
  //       print("No matching product found in the global Products class.");
  //     }
  //   }
  //   return favoriteData;
  // }

  /// -- Function to save user data by google login to back4app
  Future<void> saveUserRecordByBack4app(
      GoogleSignInAccount userAccount, String? accountID) async {
    try {
      // save data
      if (kDebugMode) {
        print("Saaaaaaaaaaaaaaaaaaaaaavinggggggggggggggggggggggg");
      }
      var userData = ParseObject('Users')
        ..set('accountID', accountID)
        ..set('email', userAccount.email.trim().toLowerCase())
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

  /// -- Function to fetch user details based on user ID
  Future<UserModel> fetchUserDetails() async {
    try {
      /////////////////////////////// ONLINE //////////////////////////////////

      // Get the current authenticated user's uid, used as the accountID.
      final String key = AuthenticationRepository.Instance.authUser!.uid;

      // Create a query to get the user record matching the accountID.
      final query = QueryBuilder<ParseObject>(ParseObject(TTexts.kUsers))
        ..whereEqualTo('accountID', key)
        ..setLimit(1); // Limit to one record to reduce resource usage.

      final ParseResponse apiResponse = await query.query();

      // Check if the API call was successful and that we got a result.
      if (apiResponse.success &&
          apiResponse.results != null &&
          apiResponse.results!.isNotEmpty) {
        final userObject = apiResponse.results!.first as ParseObject;

        if (kDebugMode) {
          print(
              '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
          print('Fetched user: ${userObject.get<String>('userName')}');
        }

        ////////////////////////////////
        // Fetch the related products //
        ////////////////////////////////
        List<ProductModel> products = await fetchTheRelatedProducts(userObject);

        // Build and return the UserModel using the data from the Parse object,
        // including the list of related products and the favorites.
        return UserModel(
          id: userObject.objectId!,
          userName: userObject.get<String>('userName') ?? '',
          firstName: userObject.get<String>('firstName') ?? '',
          lastName: userObject.get<String>('lastName') ?? '',
          phoneNumber: userObject.get<String>('phoneNumber') ?? '',
          email: userObject.get<String>('email') ?? '',
          profilePicture: userObject.get<String>('profilePicture') ?? '',
          dateOfBirth: userObject.get<DateTime?>('dateOfBirth'),
          products: products,
          // List<dynamic> because Parse returns raw JSON values ,
          // so this is the best way to fetch the data and change it to String type
          favoriteList: (userObject.get('favorites') as List<dynamic>?)
                  ?.map((e) => e.toString())
                  .toList() ??
              [],
        );
      } else {
        /////////////////////////////// OFFLINE //////////////////////////////////
        TLoaders.warningSnackBar(title: "Warning", message: 'You Are Offline');
        final storedData =
            UserController.instance.userLocaleData.read(TTexts.kuserData);
        if (storedData != null) {
          return UserModel.fromJson(storedData);
        } else {
          return UserModel.empty();
        }
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

  // Future<List<ProductModel>> fetchTheRelatedFavorites(
  //     ParseObject userObject) async {
  //   final QueryBuilder<ParseObject> favQuery =
  //       QueryBuilder<ParseObject>(ParseObject(TTexts.kFavorite))
  //         ..whereRelatedTo('favorites', TTexts.kUsers, userObject.objectId!);
  //   final ParseResponse favoritesResponse = await favQuery.query();
  //   if (kDebugMode) {
  //     print('!!!!!!!!!!!!!!!!!!!! Favorites !!!!!!!!!!!!!!!!!!!!!!');
  //     print(favoritesResponse.results);
  //   }
  //   List<ProductModel> favoriteList = [];
  //   if (favoritesResponse.success &&
  //       favoritesResponse.results != null &&
  //       favoritesResponse.results!.isNotEmpty) {
  //     if (kDebugMode) {
  //       print('1111111111111 Favorites Fetching   11111111111111111');
  //     }
  //     for (var favObj in favoritesResponse.results!) {
  //       // Convert each Favorite object to a ProductModel.
  //       // This assumes that the Favorite class contains the product details
  //       // (or you may choose to follow a pointer within the Favorite object).
  //       favoriteList.add(ProductModel.fromParse(favObj as ParseObject));
  //       if (kDebugMode) {
  //         print('Favorite fetched');
  //       }
  //     }
  //     if (kDebugMode) {
  //       print('222222222222 Favorites Fetched 22222222222222');
  //     }
  //   }
  //   if (kDebugMode) {
  //     print('%%%%%%%%%%%%%%%%%%% Favorites number %%%%%%%%%%%%%%%%%%%%%%%%%');
  //     print(favoriteList.length);
  //   }
  //   return favoriteList;
  // }

  Future<List<ProductModel>> fetchTheRelatedProducts(
      ParseObject userObject) async {
    final QueryBuilder<ParseObject> productQuery =
        QueryBuilder<ParseObject>(ParseObject(TTexts.kProducts))
          ..whereRelatedTo('products', TTexts.kUsers, userObject.objectId!);

    final ParseResponse productsResponse = await productQuery.query();
    if (kDebugMode) {
      print('!!!!!!!!!!!!!!!!!!!! Products !!!!!!!!!!!!!!!!!!!!!!');
      print(productsResponse.results);
    }

    List<ProductModel> products = [];
    if (productsResponse.success &&
        productsResponse.results != null &&
        productsResponse.results!.isNotEmpty) {
      if (kDebugMode) {
        print('1111111111111 Products Fetching   11111111111111111');
      }
      for (var prodObj in productsResponse.results!) {
        // Convert each ParseObject to a ProductModel.
        products.add(ProductModel.fromParse(prodObj as ParseObject));
        if (kDebugMode) {
          print('00000000000000');
        }
      }
      if (kDebugMode) {
        print('222222222222 Products Fetched 22222222222222');
      }
    }
    if (kDebugMode) {
      print('%%%%%%%%%%%%%%%%%%% Products number %%%%%%%%%%%%%%%%%%%%%%%%%');
      print(products.length);
    }
    return products;
  }

  /// -- Function ot update (favorite list) / (wishlist)
  Future<void> updateFavoriteProductDetails({
    required ProductModel updatedProduct,
  }) async {
    try {
      // 1. Get the current authenticated user's id.
      final String currentUserId =
          AuthenticationRepository.Instance.authUser!.uid;

      // 2. Query for the user's record in the Users class.
      final QueryBuilder<ParseObject> userQuery =
          QueryBuilder<ParseObject>(ParseObject(TTexts.kUsers))
            ..whereEqualTo('accountID', currentUserId)
            ..setLimit(1);
      final ParseResponse userResponse = await userQuery.query();

      if (!userResponse.success ||
          userResponse.results == null ||
          userResponse.results!.isEmpty) {
        throw 'User record not found';
      }

      final ParseObject userObject = userResponse.results!.first as ParseObject;

      // 3. Get the "favorites" field safely.
      //    Use a dynamic list and then convert to List<String> so that type issues are avoided.
      List<dynamic> favoritesRaw = userObject.get("favorites") ?? [];
      List<String> favorites = favoritesRaw.map((e) => e.toString()).toList();

      if (kDebugMode) {
        print('Current favorites: $favorites');
      }

      // (Optional) Validate the product's objectId isn’t empty.
      if (updatedProduct.objectId.isEmpty) {
        throw 'Invalid product objectId';
      }

      // 4. Check if the product's objectId is already in the favorites array.
      if (favorites.contains(updatedProduct.objectId)) {
        // If it exists, remove it.
        favorites.remove(updatedProduct.objectId);
        UserController.instance.localeFavoriteListProducts!
            .remove(updatedProduct.objectId);
        if (kDebugMode) {
          print("Removed product ${updatedProduct.objectId} from favorites.");
        }
        TLoaders.successSnackBar(title: "Removed From Wish List");
      } else {
        // Otherwise, add it.
        favorites.add(updatedProduct.objectId);
        UserController.instance.localeFavoriteListProducts!
            .add(updatedProduct.objectId);

        if (kDebugMode) {
          print("Added product ${updatedProduct.objectId} to favorites.");
        }
        TLoaders.successSnackBar(title: "Added To Wish List");
      }

      if (kDebugMode) {
        print('Updated favorites: $favorites');
      }

      // 5. Update the user object with the new favorites array and save it.
      userObject.set("favorites", favorites);
      final ParseResponse saveResponse = await userObject.save();

      if (!saveResponse.success) {
        throw 'Failed to update favorites: ${saveResponse.error?.message}';
      }

      if (kDebugMode) {
        print("Favorites updated successfully for the user.");
      }
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
      throw 'Something went wrong. Please try again';
    }
  }

  /// -- Function to update user data in Firestor.
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      // Create a ParseObject representing the user
      final userObject = ParseObject(TTexts.kUsers)
        ..objectId = updatedUser.id
        ..set<String>('userName', updatedUser.userName)
        ..set<String>('firstName', updatedUser.firstName)
        ..set<String>('lastName', updatedUser.lastName)
        ..set<String>('phoneNumber', updatedUser.phoneNumber)
        ..set<String>('email', updatedUser.email)
        ..set<String>('profilePicture', updatedUser.profilePicture ?? '')
        ..set<String>(
            'favorites', (updatedUser.favoriteList ?? List.empty()) as String)
        ..set<DateTime?>('dateOfBirth', updatedUser.dateOfBirth);

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

  /// -- Update any field in specific Users Collection
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
        final queryForObjectId =
            QueryBuilder<ParseObject>(ParseObject(TTexts.kUsers))
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
      final query = QueryBuilder<ParseObject>(ParseObject(TTexts.kUsers))
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
      if (kDebugMode) {
        print(
            'Saaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaavedddddddddddddddddddddddd');
      }
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// -- Function to remove user data from back4app.
  Future<void> removeUserRecord() async {
    try {
      // Get the current authenticated user's accountID.
      final String? currentUserId =
          AuthenticationRepository.Instance.authUser?.uid;
      if (currentUserId == null) {
        throw 'User ID is null';
      }

      // Create a ParseObject for the user with the specified objectId
      final queryForObjectId =
          QueryBuilder<ParseObject>(ParseObject(TTexts.kUsers))
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
      } else {
        TLoaders.successSnackBar(
            title: 'Success', message: 'User data deleted');
      }
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// -- Upload any Image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      // final ref = FirebaseStorage.instance.ref(path).child(image.name);
      // await ref.putFile(File(image.path));
      // final url = await ref.getDownloadURL();
      // return url;
      return '';
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
