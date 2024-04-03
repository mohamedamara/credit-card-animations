import 'package:flutter/material.dart';
import 'package:payment_card_animations/themes/custom_colors.dart';
import 'package:payment_card_animations/themes/custom_text_styles.dart';

import '../../utils/gesture_detector_with_mouse_hover.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.opTap,
  });

  final VoidCallback opTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetectorWithMouseHover(
      onTap: opTap,
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          color: CustomColors.submitButtonBackgroundColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              offset: Offset(3, 10),
              blurRadius: 20,
              spreadRadius: 0,
              color: CustomColors.submitButtonShadowColor,
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Submit',
            style: CustomTextStyles.submitButtonTextStyle,
          ),
        ),
      ),
    );
  }
}
