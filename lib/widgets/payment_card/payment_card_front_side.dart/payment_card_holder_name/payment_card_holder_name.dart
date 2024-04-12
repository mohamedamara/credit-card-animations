import 'package:flutter/material.dart';
import 'package:payment_card_animations/widgets/payment_card/payment_card_front_side.dart/payment_card_holder_name/animated_card_holder_name_first_character.dart';
import 'package:payment_card_animations/widgets/payment_card/payment_card_front_side.dart/payment_card_holder_name/animated_card_holder_name_hint.dart';

import '../../../../themes/custom_text_styles.dart';
import '../../../../utils/gesture_detector_with_mouse_hover.dart';
import 'animated_card_holder_name_character.dart';

class PaymentCardHolderName extends StatelessWidget {
  const PaymentCardHolderName({
    super.key,
    required this.paymentCardHolderNameTextFieldFocusNode,
    required this.paymentCardHolderName,
    required this.allowEmptyPaymentCardHolderNameAnimation,
  });

  final FocusNode paymentCardHolderNameTextFieldFocusNode;
  final String paymentCardHolderName;
  final bool allowEmptyPaymentCardHolderNameAnimation;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 196,
      left: 25,
      child: GestureDetectorWithMouseHover(
        onTap: () {
          paymentCardHolderNameTextFieldFocusNode.requestFocus();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Card Holder',
              style: CustomTextStyles.paymentCardFrontSideLabelTextStyle,
            ),
            SizedBox(
              height: 35,
              width: 300,
              child: Stack(
                children: [
                  if (paymentCardHolderName.isEmpty) ...[
                    if (allowEmptyPaymentCardHolderNameAnimation) ...[
                      AnimatedCardHolderNameHint(
                        key: const ValueKey(true),
                        isCardHolderNameEmpty: true,
                        onAnimationControllerReady: (animationController) {
                          animationController.forward();
                        },
                      ),
                    ] else ...[
                      Text(
                        'full name'.toUpperCase(),
                        style: CustomTextStyles
                            .paymentCardHolderNameAndExpirationDateTextStyle,
                      ),
                    ],
                  ],
                  if (paymentCardHolderName.isNotEmpty) ...[
                    AnimatedCardHolderNameHint(
                      key: const ValueKey(false),
                      isCardHolderNameEmpty: false,
                      onAnimationControllerReady: (animationController) {
                        animationController.forward();
                      },
                    ),
                  ],
                  Row(
                    children: [
                      for (int i = 0;
                          i < paymentCardHolderName.length;
                          i++) ...[
                        if (i == 0) ...[
                          AnimatedCardHolderNameFirstCharacter(
                            value: paymentCardHolderName[i],
                            onAnimationControllerReady: (animationController) {
                              animationController.forward();
                            },
                          ),
                        ] else ...[
                          AnimatedCardHolderNameCharacter(
                            value: paymentCardHolderName[i],
                            onAnimationControllerReady: (animationController) {
                              animationController.forward();
                            },
                          ),
                        ],
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
