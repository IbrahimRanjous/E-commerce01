import 'package:flutter/material.dart';
import 'package:rjs_store/core/utils/constants/colors.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/utils/helpers/helper_functions.dart';

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton({
    super.key,
    required this.itemsList,
    this.onChanged,
  });

  final List<String> itemsList;
  final void Function(String?)? onChanged;

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  String? hint = 'Sort By';

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: dark ? TColors.dark : TColors.light,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: TColors.primary)),
      child: DropdownButton(
          isExpanded: true,
          hint: Text(hint!),
          underline: Container(),
          items: widget.itemsList.map((name) {
            return DropdownMenuItem(
              value: name,
              child: Text(name),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              hint = value;
            });
          }),
    );
  }
}
