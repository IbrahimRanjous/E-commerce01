import 'package:flutter/material.dart';
import 'package:rjs_store/core/widgets/user/user_controller.dart';
import 'display_x_file_image.dart';

class TProfilePicture extends StatelessWidget {
  const TProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController controller = UserController.instance;

    // Function to change the profile picture.
    void changeProfilePicture() async {
      await controller.updateLocalProfileImage();
    }

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const DisplayLocalProfileImage(),
          TextButton(
            onPressed: changeProfilePicture,
            child: const Text('Change Profile Picture'),
          ),
        ],
      ),
    );
  }
}
