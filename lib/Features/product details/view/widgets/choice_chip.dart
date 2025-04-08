import 'package:flutter/material.dart';
import 'package:rjs_store/core/widgets/text/my_text.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../../../home/views/widgets/circular_container.dart';

class TChoiceChip extends StatelessWidget {
  const TChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });
  final String text;
  final bool selected;
  final void Function(bool)? onSelected;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final Color? mycolor = THelperFunctions.getColor(text);
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        avatar: mycolor != null
            ? TCircularContainer(
                width: 50,
                height: 50,
                color: mycolor,
              )
            : null,
        selected: selected,
        onSelected: onSelected,
        shape: mycolor != null ? const CircleBorder() : null,
        labelStyle: TextStyle(color: selected ? TColors.white : null),
        label: mycolor != null
            ? const SizedBox()
            : MyText(
                text: text,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: dark ? TColors.light : TColors.black,
              ),
        labelPadding: mycolor != null ? const EdgeInsets.all(0) : null,
        padding: mycolor != null ? const EdgeInsets.all(0) : null,
        backgroundColor: mycolor ?? TColors.buttonSecondary,
        selectedColor: TColors.buttonPrimary,
      ),
    );
  }
}
