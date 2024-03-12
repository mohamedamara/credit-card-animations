import 'package:credit_card_animations/constants/assets_constants.dart';
import 'package:flutter/material.dart';

import '../models/credit_card_number_model.dart';

class CreditCard extends StatefulWidget {
  const CreditCard({
    super.key,
    required this.creditCardNumberEnterAnimationController,
    required this.creditCardNumberLeaveAnimationController,
    required this.creditCardNumbers,
    required this.creditCardName,
  });

  final AnimationController creditCardNumberEnterAnimationController;
  final AnimationController creditCardNumberLeaveAnimationController;
  final List<CreditCardNumberModel> creditCardNumbers;
  final List<String> creditCardName;

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
                  if ((i + 1) % 4 == 0) ...[
                    const SizedBox(width: 20),
                  ],
                ],
              ],
            ),
          ),
          Positioned(
            top: 180,
            left: 25,
            child: SizedBox(
              height: 100,
              width: 350,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.creditCardName.length,
                itemBuilder: (context, index) {
                  return Text(
                    widget.creditCardName[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
