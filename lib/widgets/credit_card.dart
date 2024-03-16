import 'dart:math';

import 'package:credit_card_animations/constants/assets_constants.dart';
import 'package:credit_card_animations/widgets/gesture_detector_with_mouse_hover.dart';
import 'package:flutter/material.dart';

import '../models/credit_card_number_model.dart';

class CreditCard extends StatelessWidget {
  const CreditCard({
    super.key,
    required this.creditCardNumberEnterAnimationController,
    required this.creditCardNumberLeaveAnimationController,
    required this.creditCardFlipAnimationController,
    required this.creditCardNumbers,
    required this.creditCardHolderName,
    required this.creditCardFocusCoverOffset,
    required this.onCreditCardFocusCoverOffsetChanged,
    required this.creditCardFocusCoverSize,
    required this.onCreditCardFocusCoverSizeChanged,
    required this.creditCardNumbersTextFieldFocusNode,
    required this.creditCardHolderNameTextFieldFocusNode,
    required this.allowEmptyCreditCardHolderNameAnimation,
    required this.monthDropdownHasFocus,
    required this.yearDropdownHasFocus,
    required this.creditCardExpirationMonth,
    required this.creditCardExpirationYear,
    required this.expiresTextTapAction,
    required this.monthTextTapAction,
    required this.yearTextTapAction,
    required this.creditCardCvv,
  });

  final AnimationController creditCardNumberEnterAnimationController;
  final AnimationController creditCardNumberLeaveAnimationController;
  final AnimationController creditCardFlipAnimationController;
  final List<CreditCardNumberModel> creditCardNumbers;
  final String creditCardHolderName;
  final Offset creditCardFocusCoverOffset;
  final void Function(Offset offset) onCreditCardFocusCoverOffsetChanged;
  final Size creditCardFocusCoverSize;
  final void Function(Size size) onCreditCardFocusCoverSizeChanged;
  final FocusNode creditCardNumbersTextFieldFocusNode;
  final FocusNode creditCardHolderNameTextFieldFocusNode;
  final bool allowEmptyCreditCardHolderNameAnimation;
  final bool monthDropdownHasFocus;
  final bool yearDropdownHasFocus;
  final String? creditCardExpirationMonth;
  final String? creditCardExpirationYear;
  final VoidCallback expiresTextTapAction;
  final VoidCallback monthTextTapAction;
  final VoidCallback yearTextTapAction;
  final String creditCardCvv;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: creditCardFlipAnimationController,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(
              (creditCardFlipAnimationController.value < 0.5)
                  ? (-pi * creditCardFlipAnimationController.value)
                  : (-pi * (1 + creditCardFlipAnimationController.value)),
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
                    // image: const DecorationImage(
                    //   image: AssetImage(AssetsConstants.creditCardImage),
                    //   fit: BoxFit.cover,
                    // ),
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
                          creditCardFlipAnimationController.value < 0.5
                              ? 0
                              : -pi,
                        ),
                      child: Image.asset(
                        AssetsConstants.creditCardImage,
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
                if (creditCardFlipAnimationController.value < 0.5) ...[
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
                    top: creditCardFocusCoverOffset.dy,
                    left: creditCardFocusCoverOffset.dx,
                    child: SizedBox(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeInOut,
                        height: creditCardFocusCoverSize.height,
                        width: creditCardFocusCoverSize.width,
                        decoration: BoxDecoration(
                          color: const Color(0xFF08142F).withOpacity(
                            (creditCardNumbersTextFieldFocusNode.hasFocus ||
                                    creditCardHolderNameTextFieldFocusNode
                                        .hasFocus ||
                                    monthDropdownHasFocus ||
                                    yearDropdownHasFocus)
                                ? 0.3
                                : 0,
                          ),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color:
                                (creditCardNumbersTextFieldFocusNode.hasFocus ||
                                        creditCardHolderNameTextFieldFocusNode
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
                        creditCardNumbersTextFieldFocusNode.requestFocus();
                      },
                      child: Row(
                        children: [
                          for (int i = 0;
                              i < creditCardNumbers.length;
                              i++) ...[
                            if (creditCardNumbers[i].isNewlyEnteredValue) ...[
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
                                            creditCardNumberLeaveAnimationController,
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
                                              creditCardNumberLeaveAnimationController,
                                          curve: Curves.easeInOut,
                                        ),
                                      ),
                                      child: Text(
                                        creditCardNumbers[i].leaveAnimatedValue,
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
                                        creditCardNumberEnterAnimationController,
                                    child: SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(0.0, 0.3),
                                        end: Offset.zero,
                                      ).animate(
                                        CurvedAnimation(
                                          parent:
                                              creditCardNumberEnterAnimationController,
                                          curve: Curves.easeInOut,
                                        ),
                                      ),
                                      child: Text(
                                        creditCardNumbers[i].value,
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
                                creditCardNumbers[i].value,
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
                        creditCardHolderNameTextFieldFocusNode.requestFocus();
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
                                if (creditCardHolderName.isEmpty) ...[
                                  if (allowEmptyCreditCardHolderNameAnimation) ...[
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
                                if (creditCardHolderName.isNotEmpty) ...[
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
                                        i < creditCardHolderName.length;
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
                                                      creditCardHolderName[i]
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
                                                      creditCardHolderName[i]
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
                                          creditCardExpirationMonth ?? 'MM')) {
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
                                  creditCardExpirationMonth ?? 'MM',
                                  key: ValueKey<String>(
                                      creditCardExpirationMonth ?? 'MM'),
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
                                          creditCardExpirationYear ?? 'YY')) {
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
                                  creditCardExpirationYear?.substring(2) ??
                                      'YY',
                                  key: ValueKey<String>(
                                      creditCardExpirationYear ?? 'YY'),
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
                                      i < creditCardCvv.length;
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
