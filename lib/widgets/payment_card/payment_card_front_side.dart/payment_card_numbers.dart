import 'package:flutter/material.dart';

import '../../../models/payment_card_number_model.dart';
import '../../../themes/custom_text_styles.dart';
import '../../../utils/gesture_detector_with_mouse_hover.dart';

class PaymentCardNumbers extends StatelessWidget {
  const PaymentCardNumbers({
    super.key,
    required this.paymentCardNumbersTextFieldFocusNode,
    required this.paymentCardNumbers,
    required this.paymentCardNumberEnterAnimationController,
    required this.paymentCardNumberLeaveAnimationController,
  });

  final FocusNode paymentCardNumbersTextFieldFocusNode;
  final List<PaymentCardNumberModel> paymentCardNumbers;
  final AnimationController paymentCardNumberEnterAnimationController;
  final AnimationController paymentCardNumberLeaveAnimationController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 122,
      left: 25,
      child: GestureDetectorWithMouseHover(
        onTap: () {
          paymentCardNumbersTextFieldFocusNode.requestFocus();
        },
        child: Row(
          children: [
            for (int i = 0; i < paymentCardNumbers.length; i++) ...[
              if (paymentCardNumbers[i].isNewlyEnteredValue) ...[
                Stack(
                  alignment: Alignment.center,
                  children: [
                    FadeTransition(
                      opacity: Tween<double>(
                        begin: 1,
                        end: 0,
                      ).animate(
                        CurvedAnimation(
                          parent: paymentCardNumberLeaveAnimationController,
                          curve: Curves.easeInOut,
                        ),
                      ),
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.0, 0.0),
                          end: const Offset(0.0, -0.3),
                        ).animate(
                          CurvedAnimation(
                            parent: paymentCardNumberLeaveAnimationController,
                            curve: Curves.easeInOut,
                          ),
                        ),
                        child: Text(
                          paymentCardNumbers[i].leaveAnimatedValue,
                          style: CustomTextStyles.paymentCardNumbersTextStyle,
                        ),
                      ),
                    ),
                    FadeTransition(
                      opacity: paymentCardNumberEnterAnimationController,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.0, 0.3),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: paymentCardNumberEnterAnimationController,
                            curve: Curves.easeInOut,
                          ),
                        ),
                        child: Text(
                          paymentCardNumbers[i].value,
                          style: CustomTextStyles.paymentCardNumbersTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                Text(
                  paymentCardNumbers[i].value,
                  style: CustomTextStyles.paymentCardNumbersTextStyle,
                )
              ],
              if ((i + 1) % 4 == 0 && (i != 15)) ...[
                const SizedBox(width: 20),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
