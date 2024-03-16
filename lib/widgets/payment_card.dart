import 'dart:math';

import '../constants/assets_constants.dart';
import '/widgets/gesture_detector_with_mouse_hover.dart';
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
    required this.paymentCardFocusCoverOffset,
    required this.onPaymentCardFocusCoverOffsetChanged,
    required this.paymentCardFocusCoverSize,
    required this.onPaymentCardFocusCoverSizeChanged,
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
  final Offset paymentCardFocusCoverOffset;
  final void Function(Offset offset) onPaymentCardFocusCoverOffsetChanged;
  final Size paymentCardFocusCoverSize;
  final void Function(Size size) onPaymentCardFocusCoverSizeChanged;
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
                        color: Color.fromRGBO(14, 42, 90, 0.55),
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
                    color: const Color.fromRGBO(6, 2, 29, 0.45),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                if (paymentCardFlipAnimationController.value < 0.5) ...[
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
                    top: paymentCardFocusCoverOffset.dy,
                    left: paymentCardFocusCoverOffset.dx,
                    child: SizedBox(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeInOut,
                        height: paymentCardFocusCoverSize.height,
                        width: paymentCardFocusCoverSize.width,
                        decoration: BoxDecoration(
                          color: const Color(0xFF08142F).withOpacity(
                            (paymentCardNumbersTextFieldFocusNode.hasFocus ||
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
                                        style: const TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                          letterSpacing: 0,
                                          height: 1,
                                        ),
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
                                        style: const TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                          letterSpacing: 0,
                                          height: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ] else ...[
                              Text(
                                paymentCardNumbers[i].value,
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  letterSpacing: 0,
                                  height: 1,
                                ),
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
                        paymentCardHolderNameTextFieldFocusNode.requestFocus();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Card Holder',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.7),
                            ),
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
                                          duration:
                                              const Duration(milliseconds: 300),
                                          builder: (context, opacity, child) {
                                            return Opacity(
                                              opacity: opacity,
                                              child: Transform.translate(
                                                offset: offset,
                                                child: Text(
                                                  'full name'.toUpperCase(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 1,
                                                  ),
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
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1,
                                      ),
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
                                        duration:
                                            const Duration(milliseconds: 300),
                                        builder: (context, opacity, child) {
                                          return Opacity(
                                            opacity: opacity,
                                            child: Transform.translate(
                                              offset: offset,
                                              child: Text(
                                                'full name'.toUpperCase(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 1,
                                                ),
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
                                          duration:
                                              const Duration(milliseconds: 300),
                                          builder: (context, offset, child) {
                                            return TweenAnimationBuilder(
                                              key: ValueKey(i),
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
                                                      paymentCardHolderName[i]
                                                          .toUpperCase(),
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        letterSpacing: 1,
                                                      ),
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
                                          duration:
                                              const Duration(milliseconds: 300),
                                          builder: (context, offset, child) {
                                            return TweenAnimationBuilder(
                                              key: ValueKey(i),
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
                                                      paymentCardHolderName[i]
                                                          .toUpperCase(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        letterSpacing: 1,
                                                      ),
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
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.7),
                            ),
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
                                      ValueKey(
                                          paymentCardExpirationMonth ?? 'MM')) {
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
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              '/'.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1,
                              ),
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
                                      ValueKey(
                                          paymentCardExpirationYear ?? 'YY')) {
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
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  Positioned(
                    top: 30,
                    child: Container(
                      height: 50,
                      width: 430,
                      color: const Color.fromRGBO(0, 0, 19, 0.8),
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
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
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
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF1A3B5D),
                                      ),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
