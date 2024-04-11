import 'package:flutter/material.dart';
import 'package:payment_card_animations/widgets/payment_card/payment_card_front_side.dart/payment_card_expiration.dart';
import 'package:payment_card_animations/widgets/payment_card/payment_card_front_side.dart/payment_card_holder_name.dart';
import 'package:payment_card_animations/widgets/payment_card/payment_card_front_side.dart/payment_card_numbers.dart';

import '../../../models/payment_card_number_model.dart';
import 'payment_card_chip.dart';
import 'payment_card_focus_overlay.dart';
import 'payment_card_logo.dart';

class PaymentCardFrontSide extends StatelessWidget {
  const PaymentCardFrontSide({
    super.key,
    required this.paymentCardFocusOverlayOffset,
    required this.paymentCardFocusOverlaySize,
    required this.paymentCardNumbersTextFieldFocusNode,
    required this.paymentCardHolderNameTextFieldFocusNode,
    required this.monthDropdownHasFocus,
    required this.yearDropdownHasFocus,
    required this.paymentCardNumbers,
    required this.paymentCardNumberEnterAnimationController,
    required this.paymentCardNumberLeaveAnimationController,
    required this.paymentCardHolderName,
    required this.allowEmptyPaymentCardHolderNameAnimation,
    this.paymentCardExpirationMonth,
    this.paymentCardExpirationYear,
    required this.expiresTextTapAction,
    required this.monthTextTapAction,
    required this.yearTextTapAction,
    required this.isVisible,
  });

  final Offset paymentCardFocusOverlayOffset;
  final Size paymentCardFocusOverlaySize;
  final FocusNode paymentCardNumbersTextFieldFocusNode;
  final FocusNode paymentCardHolderNameTextFieldFocusNode;
  final bool monthDropdownHasFocus;
  final bool yearDropdownHasFocus;
  final List<PaymentCardNumberModel> paymentCardNumbers;
  final AnimationController paymentCardNumberEnterAnimationController;
  final AnimationController paymentCardNumberLeaveAnimationController;
  final String paymentCardHolderName;
  final bool allowEmptyPaymentCardHolderNameAnimation;
  final String? paymentCardExpirationMonth;
  final String? paymentCardExpirationYear;
  final VoidCallback expiresTextTapAction;
  final VoidCallback monthTextTapAction;
  final VoidCallback yearTextTapAction;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      maintainSize: true,
      maintainState: true,
      maintainAnimation: true,
      maintainInteractivity: false,
      maintainSemantics: false,
      child: Stack(
        children: [
          const PaymentCardChip(),
          const PaymentCardLogo(),
          PaymentCardfocusOverlay(
            paymentCardFocusOverlayOffset: paymentCardFocusOverlayOffset,
            paymentCardFocusOverlaySize: paymentCardFocusOverlaySize,
            paymentCardNumbersTextFieldFocusNode:
                paymentCardNumbersTextFieldFocusNode,
            paymentCardHolderNameTextFieldFocusNode:
                paymentCardHolderNameTextFieldFocusNode,
            monthDropdownHasFocus: monthDropdownHasFocus,
            yearDropdownHasFocus: yearDropdownHasFocus,
          ),
          PaymentCardNumbers(
            paymentCardNumbersTextFieldFocusNode:
                paymentCardNumbersTextFieldFocusNode,
            paymentCardNumbers: paymentCardNumbers,
            paymentCardNumberEnterAnimationController:
                paymentCardNumberEnterAnimationController,
            paymentCardNumberLeaveAnimationController:
                paymentCardNumberLeaveAnimationController,
          ),
          PaymentCardHolderName(
            paymentCardHolderNameTextFieldFocusNode:
                paymentCardHolderNameTextFieldFocusNode,
            paymentCardHolderName: paymentCardHolderName,
            allowEmptyPaymentCardHolderNameAnimation:
                allowEmptyPaymentCardHolderNameAnimation,
          ),
          PaymentCardExpiration(
            paymentCardExpirationMonth: paymentCardExpirationMonth,
            paymentCardExpirationYear: paymentCardExpirationYear,
            expiresTextTapAction: expiresTextTapAction,
            monthTextTapAction: monthTextTapAction,
            yearTextTapAction: yearTextTapAction,
          ),
        ],
      ),
    );
  }
}
