import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/image_strings.dart';
import '../../../../core/utils/loaders/shimmer_effect.dart';
import '../../../../core/widgets/images/t_rounded_image.dart';
import '../../../../core/widgets/user/user_controller.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key,
    this.onPressed,
  });

  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return ListTile(
      title: Obx(
        () => CustomShimmerName(
            controller: controller, name: controller.user.value.fullName),
      ),
      subtitle: Obx(
        () => CustomShimmerName(
            controller: controller, name: controller.user.value.email),
      ),
      trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Iconsax.edit,
            color: TColors.white,
          )),
      leading: const TRoundedImage(
          imageWidth: 50,
          imageHeight: 50,
          padding: 0,
          url: TImages.user,
          isNetworkImage: false),
    );
  }
}

class CustomShimmerName extends StatelessWidget {
  const CustomShimmerName({
    super.key,
    required this.controller,
    this.name,
  });

  final UserController controller;
  final String? name;
  @override
  Widget build(BuildContext context) {
    if (controller.profileLoading.value) {
      // Display a shimmer loader while user profile is being loaded
      return TShimmerEffect(width: 80, height: 15);
    } else if (name == ' ') {
      return Text(
        'No Name',
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: TColors.white),
      );
    } else {
      return Text(
        name ?? '',
        style:
            Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.white),
      );
    }
  }
}
