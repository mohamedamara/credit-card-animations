import 'dart:math';

import 'package:flutter/material.dart';

import '../../constants/assets_constants.dart';
import '../../themes/custom_colors.dart';

class PaymentCardCover extends StatelessWidget {
  const PaymentCardCover({
    super.key,
    required this.paymentCardFlipAnimationController,
  });

  final AnimationController paymentCardFlipAnimationController;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  paymentCardFlipAnimationController.value < 0.5 ? 0 : -pi,
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
      ],
    );
  }
}
