import 'package:credit_card_animations/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/blank_space_after_every_4_characters_input_formatter.dart';

class CreditCardForm extends StatelessWidget {
  const CreditCardForm({
    super.key,
    required this.creditCardNumbersTextEditingController,
    required this.onCreditCardNumbersValueChanged,
    required this.creditCardNameTextEditingController,
    required this.onCreditCardNameValueChanged,
  });

  final TextEditingController creditCardNumbersTextEditingController;
  final void Function(String newCreditCardNumbersValue)?
      onCreditCardNumbersValueChanged;
  final TextEditingController creditCardNameTextEditingController;
  final void Function(String newCreditCardNameValue)?
      onCreditCardNameValueChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 570,
      width: 585,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 30),
            blurRadius: 60,
            spreadRadius: 0,
            color: Color.fromRGBO(90, 116, 148, 0.4),
          )
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 185),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Card Number',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1A3B5B),
              ),
            ),
          ),
          const SizedBox(height: 5),
          CustomTextField(
            controller: creditCardNumbersTextEditingController,
            keyboardType: TextInputType.number,
            maxLength: 19,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              BlankSpaceAfterEvery4charactersInputFormatter(),
            ],
            onChanged: onCreditCardNumbersValueChanged,
          ),
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Card Name',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1A3B5B),
              ),
            ),
          ),
          const SizedBox(height: 5),
          CustomTextField(
            controller: creditCardNameTextEditingController,
            keyboardType: TextInputType.name,
            maxLength: 20,
            onChanged: onCreditCardNameValueChanged,
          ),
        ],
      ),
    );
  }
}
