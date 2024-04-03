import 'dart:math';

import 'package:payment_card_animations/themes/custom_colors.dart';
import 'package:payment_card_animations/themes/custom_text_styles.dart';

import '../constants/assets_constants.dart';
import '../utils/gesture_detector_with_mouse_hover.dart';
import 'package:flutter/material.dart';

import '../models/payment_card_number_model.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    super.key,
    required this.paymentCardNumberEnterAnimationController,
    required this.paymentCardNumberLeaveAnimationController,
    required this.paymentCardFlipAnimationController,
    required this.paymentCardNumbers,
    required this.paymentCardHolderName,
    required this.paymentCardFocusOverlayOffset,
    required this.onPaymentCardFocusOverlayOffsetChanged,
    required this.paymentCardFocusOverlaySize,
    required this.onPaymentCardFocusOverlaySizeChanged,
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
  final void Function(Offset offset) onPaymentCardFocusOverlayOffsetChanged;
  final Size paymentCardFocusOverlaySize;
  final void Function(Size size) onPaymentCardFocusOverlaySizeChanged;
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
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 20),
                        blurRadius: 60,
                        spreadRadius: 0,
                        color: CustomColors.paymentCardShadowColor,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..rotateY(
                          paymentCardFlipAnimationController.value < 0.5
                              ? 0
                              : -pi,
                        ),
                      child: Image.asset(
                        AssetsConstants.paymentCardCoverImage,
                        fit: BoxFit.cover,
                        height: 270,
                        width: 430,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: CustomColors.paymentCardOverlayColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                Visibility(
                  visible: paymentCardFlipAnimationController.value < 0.5,
                  maintainSize: true,
                  maintainState: true,
                  maintainAnimation: true,
                  maintainInteractivity: false,
                  maintainSemantics: false,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 25,
                        left: 25,
                        child: Image.asset(
                          AssetsConstants.chipImage,
                          width: 60,
                        ),
                      ),
                      Positioned(
                        top: 25,
                        right: 25,
                        child: Image.asset(
                          AssetsConstants.visaLogo,
                          height: 45,
                        ),
                      ),
                      AnimatedPositioned(
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
                              color: CustomColors.paymentCardFocusOverlayColor
                                  .withOpacity(
                                (paymentCardNumbersTextFieldFocusNode
                                            .hasFocus ||
                                        paymentCardHolderNameTextFieldFocusNode
                                            .hasFocus ||
                                        monthDropdownHasFocus ||
                                        yearDropdownHasFocus)
                                    ? 0.3
                                    : 0,
                              ),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: (paymentCardNumbersTextFieldFocusNode
                                            .hasFocus ||
                                        paymentCardHolderNameTextFieldFocusNode
                                            .hasFocus ||
                                        monthDropdownHasFocus ||
                                        yearDropdownHasFocus)
                                    ? Colors.white.withOpacity(0.65)
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 122,
                        left: 25,
                        child: GestureDetectorWithMouseHover(
                          onTap: () {
                            paymentCardNumbersTextFieldFocusNode.requestFocus();
                          },
                          child: Row(
                            children: [
                              for (int i = 0;
                                  i < paymentCardNumbers.length;
                                  i++) ...[
                                if (paymentCardNumbers[i]
                                    .isNewlyEnteredValue) ...[
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      FadeTransition(
                                        opacity: Tween<double>(
                                          begin: 1,
                                          end: 0,
                                        ).animate(
                                          CurvedAnimation(
                                            parent:
                                                paymentCardNumberLeaveAnimationController,
                                            curve: Curves.easeInOut,
                                          ),
                                        ),
                                        child: SlideTransition(
                                          position: Tween<Offset>(
                                            begin: const Offset(0.0, 0.0),
                                            end: const Offset(0.0, -0.3),
                                          ).animate(
                                            CurvedAnimation(
                                              parent:
                                                  paymentCardNumberLeaveAnimationController,
                                              curve: Curves.easeInOut,
                                            ),
                                          ),
                                          child: Text(
                                            paymentCardNumbers[i]
                                                .leaveAnimatedValue,
                                            style: CustomTextStyles
                                                .paymentCardNumbersTextStyle,
                                          ),
                                        ),
                                      ),
                                      FadeTransition(
                                        opacity:
                                            paymentCardNumberEnterAnimationController,
                                        child: SlideTransition(
                                          position: Tween<Offset>(
                                            begin: const Offset(0.0, 0.3),
                                            end: Offset.zero,
                                          ).animate(
                                            CurvedAnimation(
                                              parent:
                                                  paymentCardNumberEnterAnimationController,
                                              curve: Curves.easeInOut,
                                            ),
                                          ),
                                          child: Text(
                                            paymentCardNumbers[i].value,
                                            style: CustomTextStyles
                                                .paymentCardNumbersTextStyle,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ] else ...[
                                  Text(
                                    paymentCardNumbers[i].value,
                                    style: CustomTextStyles
                                        .paymentCardNumbersTextStyle,
                                  )
                                ],
                                if ((i + 1) % 4 == 0 && (i != 15)) ...[
                                  const SizedBox(width: 20),
                                ],
                              ],
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 196,
                        left: 25,
                        child: GestureDetectorWithMouseHover(
                          onTap: () {
                            paymentCardHolderNameTextFieldFocusNode
                                .requestFocus();
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Card Holder',
                                style: CustomTextStyles
                                    .paymentCardFrontSideLabelTextStyle,
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
                                          duration:
                                              const Duration(milliseconds: 300),
                                          builder: (context, offset, child) {
                                            return TweenAnimationBuilder(
                                              key: const ValueKey(0),
                                              tween: Tween<double>(
                                                begin: 0,
                                                end: 1,
                                              ),
                                              curve: Curves.easeInOut,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              builder:
                                                  (context, opacity, child) {
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
                                        duration:
                                            const Duration(milliseconds: 300),
                                        builder: (context, offset, child) {
                                          return TweenAnimationBuilder(
                                            tween: Tween<double>(
                                              begin: 1,
                                              end: 0,
                                            ),
                                            curve: Curves.easeInOut,
                                            duration: const Duration(
                                                milliseconds: 300),
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
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              builder:
                                                  (context, offset, child) {
                                                return TweenAnimationBuilder(
                                                  key: ValueKey(i),
                                                  tween: Tween<double>(
                                                    begin: 0,
                                                    end: 1,
                                                  ),
                                                  curve: Curves.easeInOut,
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  builder: (context, opacity,
                                                      child) {
                                                    return Opacity(
                                                      opacity: opacity,
                                                      child:
                                                          Transform.translate(
                                                        offset: offset,
                                                        child: Text(
                                                          paymentCardHolderName[
                                                                  i]
                                                              .toUpperCase(),
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
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              builder:
                                                  (context, offset, child) {
                                                return TweenAnimationBuilder(
                                                  key: ValueKey(i),
                                                  tween: Tween<double>(
                                                    begin: 0,
                                                    end: 1,
                                                  ),
                                                  curve: Curves.easeInOut,
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  builder: (context, opacity,
                                                      child) {
                                                    return Opacity(
                                                      opacity: opacity,
                                                      child:
                                                          Transform.translate(
                                                        offset: offset,
                                                        child: Text(
                                                          paymentCardHolderName[
                                                                  i]
                                                              .toUpperCase(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
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
                      ),
                      Positioned(
                        top: 196,
                        right: 25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetectorWithMouseHover(
                              onTap: expiresTextTapAction,
                              child: Text(
                                'Expires',
                                style: CustomTextStyles
                                    .paymentCardFrontSideLabelTextStyle,
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
                                    reverseDuration:
                                        const Duration(milliseconds: 200),
                                    switchInCurve: Curves.easeInOut,
                                    switchOutCurve: Curves.easeInOut,
                                    transitionBuilder: (
                                      Widget child,
                                      Animation<double> animation,
                                    ) {
                                      if (child.key ==
                                          ValueKey(paymentCardExpirationMonth ??
                                              'MM')) {
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
                                      key: ValueKey<String>(
                                          paymentCardExpirationMonth ?? 'MM'),
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
                                    reverseDuration:
                                        const Duration(milliseconds: 200),
                                    switchInCurve: Curves.easeInOut,
                                    switchOutCurve: Curves.easeInOut,
                                    transitionBuilder: (
                                      Widget child,
                                      Animation<double> animation,
                                    ) {
                                      if (child.key ==
                                          ValueKey(paymentCardExpirationYear ??
                                              'YY')) {
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
                                      paymentCardExpirationYear?.substring(2) ??
                                          'YY',
                                      key: ValueKey<String>(
                                          paymentCardExpirationYear ?? 'YY'),
                                      style: CustomTextStyles
                                          .paymentCardHolderNameAndExpirationDateTextStyle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: paymentCardFlipAnimationController.value >= 0.5,
                  maintainSize: true,
                  maintainState: true,
                  maintainAnimation: true,
                  maintainInteractivity: false,
                  maintainSemantics: false,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 30,
                        child: Container(
                          height: 50,
                          width: 430,
                          color: CustomColors.paymentCardMagneticStripeColor,
                        ),
                      ),
                      Positioned(
                        top: 93,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15, left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Text(
                                  'CVV',
                                  style: CustomTextStyles
                                      .paymentCardBackSideLabelTextStyle,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Container(
                                height: 50,
                                width: 400,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 10,
                                    right: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      for (int i = 0;
                                          i < paymentCardCvv.length;
                                          i++) ...[
                                        const Text(
                                          '*',
                                          style: CustomTextStyles
                                              .paymentCardCvvTextStyle,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Opacity(
                                opacity: 0.7,
                                child: Image.asset(
                                  AssetsConstants.visaLogo,
                                  height: 45,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
