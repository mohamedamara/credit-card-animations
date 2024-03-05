import 'package:credit_card_animations/constants/assets_constants.dart';
import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
  const CreditCard({super.key});

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
        ],
      ),
    );
  }
}
