import 'package:credit_card_animations/constants/assets_constants.dart';
import 'package:credit_card_animations/widgets/gesture_detector_with_mouse_hover.dart';
import 'package:flutter/material.dart';

import '../models/credit_card_number_model.dart';

class CreditCard extends StatefulWidget {
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
  final List<String> creditCardHolderName;
  final Offset creditCardFocusCoverOffset;
  final void Function(Offset offset) onCreditCardFocusCoverOffsetChanged;
  final Size creditCardFocusCoverSize;
  final void Function(Size size) onCreditCardFocusCoverSizeChanged;
  final FocusNode creditCardNumbersTextFieldFocusNode;
  final FocusNode creditCardHolderNameTextFieldFocusNode;
  final bool allowEmptyCreditCardHolderNameAnimation;

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  late Animation<Offset> _numberEnterOffsetAnimation;
  late Animation<Offset> _numberLeaveOffsetAnimation;
  late Animation<double> _numberleaveOpacityAnimation;

  @override
  void initState() {
    super.initState();
    _numberEnterOffsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: widget.creditCardNumberEnterAnimationController,
        curve: Curves.easeInOut,
      ),
    );
    final numberLeaveCurvedAnimation = CurvedAnimation(
      parent: widget.creditCardNumberLeaveAnimationController,
      curve: Curves.easeInOut,
    );
    _numberLeaveOffsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, -0.3),
    ).animate(numberLeaveCurvedAnimation);
    _numberleaveOpacityAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(numberLeaveCurvedAnimation);
  }

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
            top: widget.creditCardFocusCoverOffset.dy,
            left: widget.creditCardFocusCoverOffset.dx,
            child: SizedBox(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
                height: widget.creditCardFocusCoverSize.height,
                width: widget.creditCardFocusCoverSize.width,
                decoration: BoxDecoration(
                  color: const Color(0xFF08142F).withOpacity(
                    (widget.creditCardNumbersTextFieldFocusNode.hasFocus ||
                            widget.creditCardHolderNameTextFieldFocusNode
                                .hasFocus)
                        ? 0.3
                        : 0,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color:
                        (widget.creditCardNumbersTextFieldFocusNode.hasFocus ||
                                widget.creditCardHolderNameTextFieldFocusNode
                                    .hasFocus)
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
                widget.creditCardNumbersTextFieldFocusNode.requestFocus();
                widget.onCreditCardFocusCoverOffsetChanged(
                  const Offset(13, 112),
                );
                widget.onCreditCardFocusCoverSizeChanged(
                  const Size(371, 53),
                );
              },
              child: Row(
                children: [
                  for (int i = 0; i < widget.creditCardNumbers.length; i++) ...[
                    if (widget.creditCardNumbers[i].isNewlyEnteredValue) ...[
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          FadeTransition(
                            opacity: _numberleaveOpacityAnimation,
                            child: SlideTransition(
                              position: _numberLeaveOffsetAnimation,
                              child: Text(
                                widget.creditCardNumbers[i].leaveAnimatedValue,
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
                                widget.creditCardNumberEnterAnimationController,
                            child: SlideTransition(
                              position: _numberEnterOffsetAnimation,
                              child: Text(
                                widget.creditCardNumbers[i].value,
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
                        widget.creditCardNumbers[i].value,
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
                widget.creditCardHolderNameTextFieldFocusNode.requestFocus();
                widget.onCreditCardFocusCoverOffsetChanged(
                  const Offset(13, 186),
                );
                widget.onCreditCardFocusCoverSizeChanged(
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
                        if (widget.creditCardHolderName.isEmpty) ...[
                          if (widget
                              .allowEmptyCreditCardHolderNameAnimation) ...[
                            TweenAnimationBuilder(
                              key: const ValueKey(0),
                              tween: Tween<Offset>(
                                begin: const Offset(0.0, 18),
                                end: const Offset(0.0, 0),
                              ),
                              curve: Curves.easeInOut,
                              duration: const Duration(milliseconds: 300),
                              builder: (context, offset, child) {
                                return TweenAnimationBuilder(
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
                        if (widget.creditCardHolderName.isNotEmpty) ...[
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
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.creditCardHolderName.length,
                          itemBuilder: (context, index) {
                            return Text(
                              widget.creditCardHolderName[index].toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1,
                              ),
                            );
                          },
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
