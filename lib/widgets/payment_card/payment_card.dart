import 'dart:math';

import 'package:payment_card_animations/widgets/payment_card/payment_card_back_side.dart';
import 'package:payment_card_animations/widgets/payment_card/payment_card_cover.dart';
import 'package:payment_card_animations/widgets/payment_card/payment_card_front_side.dart/payment_card_front_side.dart';

import 'package:flutter/material.dart';

import '../../models/payment_card_number_model.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    super.key,
    required this.paymentCardNumberEnterAnimationController,
    required this.paymentCardNumberLeaveAnimationController,
    required this.paymentCardFlipAnimationController,
    required this.paymentCardNumbers,
    required this.paymentCardHolderName,
    required this.paymentCardFocusOverlayOffset,
    required this.paymentCardFocusOverlaySize,
    required this.paymentCardNumbersTextFieldFocusNode,
    required this.paymentCardHolderNameTextFieldFocusNode,
    required this.allowEmptyPaymentCardHolderNameAnimation,
    required this.monthDropdownHasFocus,
    required this.yearDropdownHasFocus,
    required this.paymentCardExpirationMonth,
    required this.paymentCardExpirationYear,
    required this.expiresTextTapAction,
    required this.monthTextTapAction,
    required this.yearTextTapAction,
    required this.paymentCardCvv,
  });

  final AnimationController paymentCardNumberEnterAnimationController;
  final AnimationController paymentCardNumberLeaveAnimationController;
  final AnimationController paymentCardFlipAnimationController;
  final List<PaymentCardNumberModel> paymentCardNumbers;
  final String paymentCardHolderName;
  final Offset paymentCardFocusOverlayOffset;
  final Size paymentCardFocusOverlaySize;
  final FocusNode paymentCardNumbersTextFieldFocusNode;
  final FocusNode paymentCardHolderNameTextFieldFocusNode;
  final bool allowEmptyPaymentCardHolderNameAnimation;
  final bool monthDropdownHasFocus;
  final bool yearDropdownHasFocus;
  final String? paymentCardExpirationMonth;
  final String? paymentCardExpirationYear;
  final VoidCallback expiresTextTapAction;
  final VoidCallback monthTextTapAction;
  final VoidCallback yearTextTapAction;
  final String paymentCardCvv;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: paymentCardFlipAnimationController,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(
              (paymentCardFlipAnimationController.value < 0.5)
                  ? (-pi * paymentCardFlipAnimationController.value)
                  : (-pi * (1 + paymentCardFlipAnimationController.value)),
            ),
          child: SizedBox(
            height: 270,
            width: 430,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PaymentCardCover(
                  paymentCardFlipAnimationController:
                      paymentCardFlipAnimationController,
                ),
                PaymentCardFrontSide(
                  isVisible: paymentCardFlipAnimationController.value < 0.5,
                  paymentCardFocusOverlayOffset: paymentCardFocusOverlayOffset,
                  paymentCardFocusOverlaySize: paymentCardFocusOverlaySize,
                  paymentCardNumbersTextFieldFocusNode:
                      paymentCardNumbersTextFieldFocusNode,
                  paymentCardHolderNameTextFieldFocusNode:
                      paymentCardHolderNameTextFieldFocusNode,
                  monthDropdownHasFocus: monthDropdownHasFocus,
                  yearDropdownHasFocus: yearDropdownHasFocus,
                  paymentCardNumbers: paymentCardNumbers,
                  paymentCardNumberEnterAnimationController:
                      paymentCardNumberEnterAnimationController,
                  paymentCardNumberLeaveAnimationController:
                      paymentCardNumberLeaveAnimationController,
                  paymentCardHolderName: paymentCardHolderName,
                  allowEmptyPaymentCardHolderNameAnimation:
                      allowEmptyPaymentCardHolderNameAnimation,
                  paymentCardExpirationMonth: paymentCardExpirationMonth,
                  paymentCardExpirationYear: paymentCardExpirationYear,
                  expiresTextTapAction: expiresTextTapAction,
                  monthTextTapAction: monthTextTapAction,
                  yearTextTapAction: yearTextTapAction,
                ),
                PaymentCardBackSide(
                  paymentCardCvv: paymentCardCvv,
                  isVisible: paymentCardFlipAnimationController.value >= 0.5,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
