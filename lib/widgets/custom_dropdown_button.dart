import 'package:flutter/material.dart';
import 'package:payment_card_animations/themes/custom_colors.dart';
import 'package:payment_card_animations/themes/custom_text_styles.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  const CustomDropdownButton({
    super.key,
    required this.items,
    required this.hintText,
    required this.onChanged,
    required this.onTap,
    required this.hasFocus,
  });

  final List<T> items;
  final String hintText;
  final bool hasFocus;
  final void Function(T?) onChanged;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: hasFocus
              ? CustomColors.inputFocusedBorderColor
              : CustomColors.inputUnfocusedBorderColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
        boxShadow: hasFocus
            ? [
                const BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 20,
                  spreadRadius: -13,
                  color: CustomColors.inputFocusedShadowColor,
                ),
              ]
            : null,
      ),
      child: DropdownButtonFormField<T>(
        padding: const EdgeInsets.only(left: 17, right: 10),
        icon: const Icon(Icons.expand_more),
        iconEnabledColor: CustomColors.darkBlueColor,
        iconSize: 28,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintStyle: CustomTextStyles.inputTextStyle,
        ),
        hint: Text(
          hintText,
          style: CustomTextStyles.inputTextStyle,
        ),
        dropdownColor: Colors.white,
        style: CustomTextStyles.inputTextStyle,
        items: items
            .map(
              (item) => DropdownMenuItem<T>(
                value: item,
                child: Text(
                  item.toString(),
                ),
              ),
            )
            .toList(),
        menuMaxHeight: 300,
        onChanged: onChanged,
        onTap: onTap,
      ),
    );
  }
}
