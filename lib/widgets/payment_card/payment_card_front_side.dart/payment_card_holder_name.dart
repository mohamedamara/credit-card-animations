import 'package:flutter/material.dart';

import '../../../themes/custom_text_styles.dart';
import '../../../utils/gesture_detector_with_mouse_hover.dart';

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
                      TweenAnimationBuilder(
                        tween: Tween<Offset>(
                          begin: const Offset(0.0, 18),
                          end: const Offset(0.0, 0),
                        ),
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 300),
                        builder: (context, offset, child) {
                          return TweenAnimationBuilder(
                            key: const ValueKey(0),
                            tween: Tween<double>(
                              begin: 0,
                              end: 1,
                            ),
                            curve: Curves.easeInOut,
                            duration: const Duration(milliseconds: 300),
                            builder: (context, opacity, child) {
                              return Opacity(
                                opacity: opacity,
                                child: Transform.translate(
                                  offset: offset,
                                  child: Text(
                                    'full name'.toUpperCase(),
                                    style: CustomTextStyles
                                        .paymentCardHolderNameAndExpirationDateTextStyle,
                                  ),
                                ),
                              );
                            },
                          );
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
                    TweenAnimationBuilder(
                      key: const ValueKey(1),
                      tween: Tween<Offset>(
                        begin: const Offset(0.0, 0.0),
                        end: const Offset(0.0, -18),
                      ),
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 300),
                      builder: (context, offset, child) {
                        return TweenAnimationBuilder(
                          tween: Tween<double>(
                            begin: 1,
                            end: 0,
                          ),
                          curve: Curves.easeInOut,
                          duration: const Duration(milliseconds: 300),
                          builder: (context, opacity, child) {
                            return Opacity(
                              opacity: opacity,
                              child: Transform.translate(
                                offset: offset,
                                child: Text(
                                  'full name'.toUpperCase(),
                                  style: CustomTextStyles
                                      .paymentCardHolderNameAndExpirationDateTextStyle,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                  Row(
                    children: [
                      for (int i = 0;
                          i < paymentCardHolderName.length;
                          i++) ...[
                        if (i == 0) ...[
                          TweenAnimationBuilder(
                            key: ValueKey(i),
                            tween: Tween<Offset>(
                              begin: const Offset(0.0, 18.0),
                              end: const Offset(0.0, 0.0),
                            ),
                            curve: Curves.easeInOut,
                            duration: const Duration(milliseconds: 300),
                            builder: (context, offset, child) {
                              return TweenAnimationBuilder(
                                key: ValueKey(i),
                                tween: Tween<double>(
                                  begin: 0,
                                  end: 1,
                                ),
                                curve: Curves.easeInOut,
                                duration: const Duration(milliseconds: 300),
                                builder: (context, opacity, child) {
                                  return Opacity(
                                    opacity: opacity,
                                    child: Transform.translate(
                                      offset: offset,
                                      child: Text(
                                        paymentCardHolderName[i].toUpperCase(),
                                        style: CustomTextStyles
                                            .paymentCardHolderNameAndExpirationDateTextStyle,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ] else ...[
                          TweenAnimationBuilder(
                            key: ValueKey(i),
                            tween: Tween<Offset>(
                              begin: const Offset(18.0, 0.0),
                              end: const Offset(0.0, 0.0),
                            ),
                            curve: Curves.easeInOut,
                            duration: const Duration(milliseconds: 300),
                            builder: (context, offset, child) {
                              return TweenAnimationBuilder(
                                key: ValueKey(i),
                                tween: Tween<double>(
                                  begin: 0,
                                  end: 1,
                                ),
                                curve: Curves.easeInOut,
                                duration: const Duration(milliseconds: 300),
                                builder: (context, opacity, child) {
                                  return Opacity(
                                    opacity: opacity,
                                    child: Transform.translate(
                                      offset: offset,
                                      child: Text(
                                        paymentCardHolderName[i].toUpperCase(),
                                        overflow: TextOverflow.ellipsis,
                                        style: CustomTextStyles
                                            .paymentCardHolderNameAndExpirationDateTextStyle,
                                      ),
                                    ),
                                  );
                                },
                              );
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
