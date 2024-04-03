import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payment_card_animations/themes/custom_colors.dart';
import 'package:payment_card_animations/themes/custom_text_styles.dart';

import '../utils/blank_space_after_every_4_characters_input_formatter.dart';
import 'custom_dropdown_button.dart';
import 'custom_text_field.dart';
import 'submit_button.dart';

class PaymentCardForm extends StatelessWidget {
  const PaymentCardForm({
    super.key,
    required this.paymentCardNumbersTextEditingController,
    required this.onPaymentCardNumbersValueChanged,
    required this.paymentCardNumbersTextFieldFocusNode,
    required this.paymentCardHolderNameTextEditingController,
    required this.onPaymentCardHolderNameValueChanged,
    required this.paymentCardHolderNameTextFieldFocusNode,
    required this.paymentCardCvvTextEditingController,
    required this.onPaymentCardCvvValueChanged,
    required this.paymentCardCvvTextFieldFocusNode,
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

  final TextEditingController paymentCardNumbersTextEditingController;
  final void Function(String newPaymentCardNumbersValue)?
      onPaymentCardNumbersValueChanged;
  final FocusNode paymentCardNumbersTextFieldFocusNode;
  final TextEditingController paymentCardHolderNameTextEditingController;
  final void Function(String newPaymentCardHolderNameValue)?
      onPaymentCardHolderNameValueChanged;
  final FocusNode paymentCardHolderNameTextFieldFocusNode;
  final TextEditingController paymentCardCvvTextEditingController;
  final void Function(String newPaymentCardCvvValue)?
      onPaymentCardCvvValueChanged;
  final FocusNode paymentCardCvvTextFieldFocusNode;
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
            color: CustomColors.paymentCardformShadowColor,
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
              style: CustomTextStyles.inputLabelTextStyle,
            ),
          ),
          const SizedBox(height: 5),
          CustomTextField(
            controller: paymentCardNumbersTextEditingController,
            focusNode: paymentCardNumbersTextFieldFocusNode,
            keyboardType: TextInputType.number,
            maxLength: 19,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              BlankSpaceAfterEvery4charactersInputFormatter(),
            ],
            onChanged: onPaymentCardNumbersValueChanged,
          ),
          const SizedBox(height: 16),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Card Holder',
              style: CustomTextStyles.inputLabelTextStyle,
            ),
          ),
          const SizedBox(height: 5),
          CustomTextField(
            controller: paymentCardHolderNameTextEditingController,
            focusNode: paymentCardHolderNameTextFieldFocusNode,
            keyboardType: TextInputType.name,
            maxLength: 20,
            onChanged: onPaymentCardHolderNameValueChanged,
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
                        style: CustomTextStyles.inputLabelTextStyle,
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
                      style: CustomTextStyles.inputLabelTextStyle,
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
                    controller: paymentCardCvvTextEditingController,
                    focusNode: paymentCardCvvTextFieldFocusNode,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    maxLength: 4,
                    onChanged: onPaymentCardCvvValueChanged,
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
