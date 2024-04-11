import 'package:flutter/material.dart';

import '../../../themes/custom_colors.dart';

class PaymentCardfocusOverlay extends StatelessWidget {
  const PaymentCardfocusOverlay({
    super.key,
    required this.paymentCardFocusOverlayOffset,
    required this.paymentCardFocusOverlaySize,
    required this.paymentCardNumbersTextFieldFocusNode,
    required this.paymentCardHolderNameTextFieldFocusNode,
    required this.monthDropdownHasFocus,
    required this.yearDropdownHasFocus,
  });

  final Offset paymentCardFocusOverlayOffset;
  final Size paymentCardFocusOverlaySize;
  final FocusNode paymentCardNumbersTextFieldFocusNode;
  final FocusNode paymentCardHolderNameTextFieldFocusNode;
  final bool monthDropdownHasFocus;
  final bool yearDropdownHasFocus;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      top: paymentCardFocusOverlayOffset.dy,
      left: paymentCardFocusOverlayOffset.dx,
      child: SizedBox(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
          height: paymentCardFocusOverlaySize.height,
          width: paymentCardFocusOverlaySize.width,
          decoration: BoxDecoration(
            color: CustomColors.paymentCardFocusOverlayColor.withOpacity(
              (paymentCardNumbersTextFieldFocusNode.hasFocus ||
                      paymentCardHolderNameTextFieldFocusNode.hasFocus ||
                      monthDropdownHasFocus ||
                      yearDropdownHasFocus)
                  ? 0.3
                  : 0,
            ),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: (paymentCardNumbersTextFieldFocusNode.hasFocus ||
                      paymentCardHolderNameTextFieldFocusNode.hasFocus ||
                      monthDropdownHasFocus ||
                      yearDropdownHasFocus)
                  ? Colors.white.withOpacity(0.65)
                  : Colors.transparent,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
