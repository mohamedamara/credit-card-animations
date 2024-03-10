import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/credit_card_numbers_input_formatter.dart';

class CreditCardForm extends StatefulWidget {
  const CreditCardForm({super.key, required this.onChanged});

  final void Function(String newCreditCardNumbersValue)? onChanged;

  @override
  State<CreditCardForm> createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  late TextEditingController _creditCardNumbersTextEditingController;

  @override
  void initState() {
    super.initState();
    _creditCardNumbersTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _creditCardNumbersTextEditingController.dispose();
    super.dispose();
  }

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
          Theme(
            data: Theme.of(context).copyWith(
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: Colors.blue.shade100,
                selectionColor: Colors.blue.shade100,
                selectionHandleColor: Colors.blue.shade100,
              ),
            ),
            child: TextField(
              controller: _creditCardNumbersTextEditingController,
              maxLength: 19,
              enableInteractiveSelection: true,
              style: const TextStyle(
                color: Color(0xFF1a3b5d),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              cursorColor: Colors.black,
              cursorWidth: 1,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                BlankSpaceAfterEvery4charactersInputFormatter(),
              ],
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 17,
                  horizontal: 17,
                ),
                counterText: '',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFFced6e0),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFF3d9cff),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onChanged: widget.onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
