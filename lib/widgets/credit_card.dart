import 'package:credit_card_animations/constants/assets_constants.dart';
import 'package:credit_card_animations/widgets/gesture_detector_with_mouse_hover.dart';
import 'package:flutter/material.dart';

import '../models/credit_card_number_model.dart';

class CreditCard extends StatelessWidget {
  const CreditCard({
    super.key,
    required this.creditCardNumberEnterAnimationController,
    required this.creditCardNumberLeaveAnimationController,
    required this.creditCardNumbers,
    required this.creditCardHolderName,
    required this.creditCardFocusCoverOffset,
    required this.onCreditCardFocusCoverOffsetChanged,
    required this.creditCardFocusCoverSize,
    required this.onCreditCardFocusCoverSizeChanged,
    required this.creditCardNumbersTextFieldFocusNode,
    required this.creditCardHolderNameTextFieldFocusNode,
    required this.allowEmptyCreditCardHolderNameAnimation,
  });

  final AnimationController creditCardNumberEnterAnimationController;
  final AnimationController creditCardNumberLeaveAnimationController;
  final List<CreditCardNumberModel> creditCardNumbers;
  final String creditCardHolderName;
  final Offset creditCardFocusCoverOffset;
  final void Function(Offset offset) onCreditCardFocusCoverOffsetChanged;
  final Size creditCardFocusCoverSize;
  final void Function(Size size) onCreditCardFocusCoverSizeChanged;
  final FocusNode creditCardNumbersTextFieldFocusNode;
  final FocusNode creditCardHolderNameTextFieldFocusNode;
  final bool allowEmptyCreditCardHolderNameAnimation;

  @override
  Widget build(BuildContext context) {
    const double creditCardBorderRadius = 15;
    return SizedBox(
      height: 270,
      width: 430,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(creditCardBorderRadius),
              image: const DecorationImage(
                image: AssetImage(AssetsConstants.creditCardImage),
                fit: BoxFit.cover,
              ),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 20),
                  blurRadius: 60,
                  spreadRadius: 0,
                  color: Color.fromRGBO(14, 42, 90, 0.55),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(6, 2, 29, 0.45),
              borderRadius: BorderRadius.circular(creditCardBorderRadius),
            ),
          ),
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
                            creditCardHolderNameTextFieldFocusNode.hasFocus)
                        ? 0.3
                        : 0,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: (creditCardNumbersTextFieldFocusNode.hasFocus ||
                            creditCardHolderNameTextFieldFocusNode.hasFocus)
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
                onCreditCardFocusCoverOffsetChanged(
                  const Offset(13, 112),
                );
                onCreditCardFocusCoverSizeChanged(
                  const Size(371, 53),
                );
              },
              child: Row(
                children: [
                  for (int i = 0; i < creditCardNumbers.length; i++) ...[
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
                            opacity: creditCardNumberEnterAnimationController,
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
                onCreditCardFocusCoverOffsetChanged(
                  const Offset(13, 186),
                );
                onCreditCardFocusCoverSizeChanged(
                  const Size(315, 63),
                );
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
                            )
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
                                duration: const Duration(milliseconds: 300),
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
                                  duration: const Duration(milliseconds: 300),
                                  builder: (context, offset, child) {
                                    return TweenAnimationBuilder(
                                      key: ValueKey(i),
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
                                              creditCardHolderName[i]
                                                  .toUpperCase(),
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
                                      duration:
                                          const Duration(milliseconds: 300),
                                      builder: (context, opacity, child) {
                                        return Opacity(
                                          opacity: opacity,
                                          child: Transform.translate(
                                            offset: offset,
                                            child: Text(
                                              creditCardHolderName[i]
                                                  .toUpperCase(),
                                              overflow: TextOverflow.ellipsis,
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
        ],
      ),
    );
  }
}
