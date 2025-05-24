import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/product_model.dart';
import '../../../../core/utils/formatters/formatters.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String userName;
  final String email;
  String phoneNumber;
  String? profilePicture;
  DateTime? dateOfBirth;
  List<ProductModel> products;
  List<String>? favoriteList;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    required this.dateOfBirth,
    required this.products,
    required this.favoriteList,
  });

  /// Helper function to get the full name.
  String get fullName => '$firstName $lastName';

  /// Helper function to format phone number.
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  /// Static function to split full name into first and last name.
  static List<String> nameParts(String fullName) => fullName.split(" ");

  /// Static function to generate a userName from the full name.
  static String generateuserName(String fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";
    String camelCaseuserName = "$firstName$lastName";
    String userNameWithPrefix = "cwt_$camelCaseuserName";
    return userNameWithPrefix;
  }

  /// Static function to create an empty user model.
  static UserModel empty() => UserModel(
        id: '',
        firstName: '',
        lastName: '',
        userName: '',
        email: '',
        phoneNumber: '',
        profilePicture: '',
        dateOfBirth: null,
        products: [],
        favoriteList: [],
      );

  /// Convert model to JSON structure for storing data.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'FirstName': firstName,
      'LastName': lastName,
      'UserName': userName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
      'DateOfBirth':
          dateOfBirth?.toIso8601String(), // converting DateTime to String
      'FavoriteList': favoriteList,
    };
  }

  /// Factory method to create a UserModel from a JSON object.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      firstName: json['FirstName'] ?? '',
      lastName: json['LastName'] ?? '',
      userName: json['UserName'] ?? '',
      email: json['Email'] ?? '',
      phoneNumber: json['PhoneNumber'] ?? '',
      profilePicture: json['ProfilePicture'] ?? '',
      dateOfBirth:
          (json['DateOfBirth'] != null && json['DateOfBirth'] is String)
              ? DateTime.tryParse(json['DateOfBirth'])
              : null,
      products: [], // Assuming you are not storing products here.
      favoriteList: (json['FavoriteList'] != null)
          ? List<String>.from(json['FavoriteList'] as List)
          : [],
    );
  }

  /// Factory method demonstrating parsing from a Firebase DocumentSnapshot.
  factory UserModel.fromParse(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        userName: data['UserName'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
        dateOfBirth: data['DateOfBirth'] is String
            ? DateTime.tryParse(data['DateOfBirth'])
            : null,
        products: [], // Implement conversion if needed.
        favoriteList: data['FavoriteList'] != null
            ? List<String>.from(data['FavoriteList'] as List)
            : [],
      );
    } else {
      throw Exception("Document data is null");
    }
  }
}
