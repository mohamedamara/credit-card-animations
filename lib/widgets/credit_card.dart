import 'package:credit_card_animations/constants/assets_constants.dart';
import 'package:flutter/material.dart';

import '../models/credit_card_number_model.dart';

class CreditCard extends StatefulWidget {
  const CreditCard({
    super.key,
    required this.creditCardNumberEnterAnimationController,
    required this.creditCardNumberLeaveAnimationController,
    required this.creditCardNumbers,
  });

  final AnimationController creditCardNumberEnterAnimationController;
  final AnimationController creditCardNumberLeaveAnimationController;
  final List<CreditCardNumberModel> creditCardNumbers;

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  late Animation<Offset> _offsetAnimation;
  late Animation<Offset> _leaveOffsetAnimation;
  late Animation<double> _leaveOpacityAnimation;

  @override
  void initState() {
    super.initState();

    final curve = CurvedAnimation(
      parent: widget.creditCardNumberEnterAnimationController,
      curve: Curves.easeInOut,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(curve);

    final leaveCurve = CurvedAnimation(
      parent: widget.creditCardNumberLeaveAnimationController,
      curve: Curves.easeInOut,
    );
    _leaveOffsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, -0.3),
    ).animate(leaveCurve);
    _leaveOpacityAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(leaveCurve);
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
          Positioned(
            top: 122,
            left: 25,
            child: Row(
              children: [
                for (int i = 0; i < widget.creditCardNumbers.length; i++) ...[
                  if (widget.creditCardNumbers[i].isNewlyEnteredValue) ...[
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        FadeTransition(
                          opacity: _leaveOpacityAnimation,
                          child: SlideTransition(
                            position: _leaveOffsetAnimation,
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
                            position: _offsetAnimation,
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
                  if ((i + 1) % 4 == 0) ...[
                    const SizedBox(width: 20),
                  ],
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
