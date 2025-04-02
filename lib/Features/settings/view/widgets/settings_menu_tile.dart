import 'package:flutter/material.dart';
import 'package:rjs_store/core/utils/constants/colors.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';

class TSettingsMenuTile extends StatelessWidget {
  const TSettingsMenuTile(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.icon,
      this.trailing,
      this.onTap});

  final String title, subTitle;
  final IconData icon;
  final Widget? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: TSizes.xs),
      child: ListTile(
        splashColor: TColors.primary,
        tileColor: TColors.darkContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        leading: Icon(
          icon,
          size: 28,
          color: TColors.primary,
        ),
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle:
            Text(subTitle, style: Theme.of(context).textTheme.labelMedium),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
