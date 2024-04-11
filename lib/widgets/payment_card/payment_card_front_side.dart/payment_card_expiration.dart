import 'package:flutter/material.dart';

import '../../../themes/custom_text_styles.dart';
import '../../../utils/gesture_detector_with_mouse_hover.dart';

class PaymentCardExpiration extends StatelessWidget {
  const PaymentCardExpiration({
    super.key,
    this.paymentCardExpirationMonth,
    this.paymentCardExpirationYear,
    required this.expiresTextTapAction,
    required this.monthTextTapAction,
    required this.yearTextTapAction,
  });

  final String? paymentCardExpirationMonth;
  final String? paymentCardExpirationYear;
  final VoidCallback expiresTextTapAction;
  final VoidCallback monthTextTapAction;
  final VoidCallback yearTextTapAction;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 196,
      right: 25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetectorWithMouseHover(
            onTap: expiresTextTapAction,
            child: Text(
              'Expires',
              style: CustomTextStyles.paymentCardFrontSideLabelTextStyle,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetectorWithMouseHover(
                onTap: monthTextTapAction,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  reverseDuration: const Duration(milliseconds: 200),
                  switchInCurve: Curves.easeInOut,
                  switchOutCurve: Curves.easeInOut,
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                  ) {
                    if (child.key ==
                        ValueKey(paymentCardExpirationMonth ?? 'MM')) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.0, 0.8),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    } else {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.0, -0.5),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    }
                  },
                  child: Text(
                    paymentCardExpirationMonth ?? 'MM',
                    key: ValueKey<String>(paymentCardExpirationMonth ?? 'MM'),
                    style: CustomTextStyles
                        .paymentCardHolderNameAndExpirationDateTextStyle,
                  ),
                ),
              ),
              Text(
                '/'.toUpperCase(),
                style: CustomTextStyles
                    .paymentCardHolderNameAndExpirationDateTextStyle,
              ),
              GestureDetectorWithMouseHover(
                onTap: yearTextTapAction,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  reverseDuration: const Duration(milliseconds: 200),
                  switchInCurve: Curves.easeInOut,
                  switchOutCurve: Curves.easeInOut,
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                  ) {
                    if (child.key ==
                        ValueKey(paymentCardExpirationYear ?? 'YY')) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.0, 0.8),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    } else {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.0, -0.5),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    }
                  },
                  child: Text(
                    paymentCardExpirationYear?.substring(2) ?? 'YY',
                    key: ValueKey<String>(paymentCardExpirationYear ?? 'YY'),
                    style: CustomTextStyles
                        .paymentCardHolderNameAndExpirationDateTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
