import 'package:credit_card_animations/widgets/custom_dropdown_button.dart';
import 'package:credit_card_animations/widgets/custom_text_field.dart';
import 'package:credit_card_animations/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/blank_space_after_every_4_characters_input_formatter.dart';

class CreditCardForm extends StatelessWidget {
  const CreditCardForm({
    super.key,
    required this.creditCardNumbersTextEditingController,
    required this.onCreditCardNumbersValueChanged,
    required this.creditCardNumbersTextFieldFocusNode,
    required this.creditCardHolderNameTextEditingController,
    required this.onCreditCardHolderNameValueChanged,
    required this.creditCardHolderNameTextFieldFocusNode,
    required this.creditCardCvvTextEditingController,
    required this.onCreditCardCvvValueChanged,
    required this.creditCardCvvTextFieldFocusNode,
    required this.months,
    required this.years,
    required this.monthDropdownHasFocus,
    required this.yearDropdownHasFocus,
    required this.onMonthDropdownValueChanged,
    required this.onYearDropdownValueChanged,
    required this.onMonthDropdownTapped,
    required this.onYearDropdownTapped,
    required this.submitButtonAction,
  });

  final TextEditingController creditCardNumbersTextEditingController;
  final void Function(String newCreditCardNumbersValue)?
      onCreditCardNumbersValueChanged;
  final FocusNode creditCardNumbersTextFieldFocusNode;
  final TextEditingController creditCardHolderNameTextEditingController;
  final void Function(String newCreditCardHolderNameValue)?
      onCreditCardHolderNameValueChanged;
  final FocusNode creditCardHolderNameTextFieldFocusNode;
  final TextEditingController creditCardCvvTextEditingController;
  final void Function(String newCreditCardCvvValue)?
      onCreditCardCvvValueChanged;
  final FocusNode creditCardCvvTextFieldFocusNode;
  final List<String> months;
  final List<String> years;
  final bool monthDropdownHasFocus;
  final bool yearDropdownHasFocus;
  final void Function(String?) onMonthDropdownValueChanged;
  final void Function(String?) onYearDropdownValueChanged;
  final void Function() onMonthDropdownTapped;
  final void Function() onYearDropdownTapped;
  final VoidCallback submitButtonAction;

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
          const SizedBox(height: 180),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Card Number',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1A3B5D),
              ),
            ),
          ),
          const SizedBox(height: 5),
          CustomTextField(
            controller: creditCardNumbersTextEditingController,
            focusNode: creditCardNumbersTextFieldFocusNode,
            keyboardType: TextInputType.number,
            maxLength: 19,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              BlankSpaceAfterEvery4charactersInputFormatter(),
            ],
            onChanged: onCreditCardNumbersValueChanged,
          ),
          const SizedBox(height: 16),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Card Holder',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1A3B5D),
              ),
            ),
          ),
          const SizedBox(height: 5),
          CustomTextField(
            controller: creditCardHolderNameTextEditingController,
            focusNode: creditCardHolderNameTextFieldFocusNode,
            keyboardType: TextInputType.name,
            maxLength: 20,
            onChanged: onCreditCardHolderNameValueChanged,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Expiration Date',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1A3B5D),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    CustomDropdownButton<String>(
                      items: months,
                      hintText: 'Month',
                      hasFocus: monthDropdownHasFocus,
                      onChanged: onMonthDropdownValueChanged,
                      onTap: onMonthDropdownTapped,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomDropdownButton<String>(
                  items: years,
                  hintText: 'Year',
                  hasFocus: yearDropdownHasFocus,
                  onChanged: onYearDropdownValueChanged,
                  onTap: onYearDropdownTapped,
                ),
              ),
              const SizedBox(width: 35),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'CVV',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1A3B5D),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  CustomTextField(
                    width: 150,
                    contentPadding: const EdgeInsets.only(
                      left: 14,
                      right: 14,
                      top: 14,
                      bottom: 17,
                    ),
                    controller: creditCardCvvTextEditingController,
                    focusNode: creditCardCvvTextFieldFocusNode,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    onChanged: onCreditCardCvvValueChanged,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 38),
          SubmitButton(
            opTap: submitButtonAction,
          ),
        ],
      ),
    );
  }
}
