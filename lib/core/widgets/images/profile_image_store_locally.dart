import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rjs_store/core/utils/constants/texts.dart';

class ProfileImageStoreLocally {
  final ImagePicker _picker = ImagePicker();

  // Pick the image from the gallery.
  Future<XFile?> pickImage() async {
    return await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxWidth: 512,
      maxHeight: 512,
    );
  }

  // Compute a local file path using the device's documents directory.
  Future<String> _localFilePath(String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$fileName';
  }

  // Save the profile image and store its path in GetStorage.
  Future<File?> saveProfileImage(XFile image) async {
    try {
      // Generate a unique filename.
      final String fileName =
          'profile_${DateTime.now().millisecondsSinceEpoch}.png';
      final String newPath = await _localFilePath(fileName);

      // Copy the image file from its temporary location to our new path.
      final File savedImage = await File(image.path).copy(newPath);
      if (kDebugMode) {
        print("Profile image saved to: $newPath");
      }

      // Write the file path to GetStorage.
      final localStorage = GetStorage();
      localStorage.write(TTexts.kProfileImage, savedImage.path);

      return savedImage;
    } catch (e) {
      if (kDebugMode) {
        print("Error saving profile image: $e");
      }
      return null;
    }
  }
}
