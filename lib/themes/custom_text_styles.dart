import 'package:flutter/material.dart';
import 'package:payment_card_animations/themes/custom_colors.dart';

class CustomTextStyles {
  static const TextStyle inputTextStyle = TextStyle(
    color: CustomColors.darkBlueColor,
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle inputLabelTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: CustomColors.darkBlueColor,
  );
  static const TextStyle paymentCardNumbersTextStyle = TextStyle(
    fontSize: 30,
    color: Colors.white,
    letterSpacing: 0,
    height: 1,
  );
  static TextStyle paymentCardFrontSideLabelTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: Colors.white.withOpacity(0.7),
  );
  static const TextStyle paymentCardBackSideLabelTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle paymentCardHolderNameAndExpirationDateTextStyle =
      TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    letterSpacing: 1,
  );
  static const TextStyle paymentCardCvvTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: CustomColors.darkBlueColor,
  );
  static const TextStyle submitButtonTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 22,
    fontWeight: FontWeight.w500,
  );
}
