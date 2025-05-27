import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rjs_store/core/widgets/user/user_controller.dart';

class DisplayLocalProfileImage extends StatelessWidget {
  const DisplayLocalProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtain the controller (make sure it has been initialized by binding it earlier in your app).
    final UserController controller = Get.find<UserController>();

    // Use Obx to re-render when the profileImagePath changes.
    return Obx(() {
      final String imagePath = controller.profileImagePath.value;
      if (imagePath.isEmpty) {
        return const Text("No image selected");
      }
      return Image.file(
        File(imagePath),
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 100,
          width: 100,
          color: Colors.grey.shade300,
          child: const Icon(Icons.broken_image, size: 48),
        ),
      );
    });
  }
}
