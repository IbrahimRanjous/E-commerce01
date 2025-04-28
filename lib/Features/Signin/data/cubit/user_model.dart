import 'package:rjs_store/core/utils/formatters/formatters.dart';

/// Model class representing user data
class UserModel {
  // keep thos values final which you do not want ot update
  final String id;
  String firstName;
  String lastName;
  final String userName;
  final String email;
  String phoneNumber;
  String profilePicture;

  /// Constructor for UserModel.
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  /// Helper function to get the full name.
  String get fullName => '$firstName $lastName';

  /// Helper function to format phone number.
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  /// Static function to split full name into first and last name .
  static List<String> nameParts(fullName) => fullName.split(" ");

  /// Static function to generate a uername from the full name.
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[0].toLowerCase() : "";
    String camelCaseUsername =
        "$firstName$lastName"; // Combine first and last name
    String usernameWithPrefix = 'cwt_$camelCaseUsername'; // Add "cwt_" prefix
    return usernameWithPrefix;
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
      );

  /// Convert model to Json structure for storing data in Firebase .
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'UserName': userName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }

  /// Factory method to create a UserModel from a Firebase document snapshot.
  // factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document)
  //  {
  //   final data = document.data();
  //   if (data != null) {
  //     return UserModel(
  //       id: document.id,
  //       firstName: data['FirstName'] ?? '',
  //       lastName: data['LastName'] ?? '',
  //       userName: data['Username'] ?? '',
  //       email: data['Email'] ?? '',
  //       phoneNumber: data['PhoneNumber'] ?? '',
  //       profilePicture: data['ProfilePicture'] ?? '',
  //     );
  //   } else {
  //     // If the document contains no data, you may want to throw an error
  //     // or return a default instance.
  //     throw Exception("No data found for document ID: ${document.id}");
  //   }
  // }
}
