import 'package:credit_card_animations/widgets/credit_card_form.dart';
import 'package:flutter/material.dart';

import 'widgets/credit_card.dart';
import 'models/credit_card_number_model.dart';

class WrapperView extends StatefulWidget {
  const WrapperView({super.key});

  @override
  State<WrapperView> createState() => _WrapperViewState();
}

class _WrapperViewState extends State<WrapperView>
    with TickerProviderStateMixin {
  late AnimationController _creditCardNumberEnterAnimationController;
  late AnimationController _creditCardNumberLeaveAnimationController;

  final List<CreditCardNumberModel> _creditCardNumbers = List.generate(
    16,
    (index) => CreditCardNumberModel(
      value: '#',
      isNewlyEnteredValue: false,
    ),
  );

  int _lastCreditCardNumberValueTypedIndex = 0;
  int _newlyCreditCardNumberValueTypedIndex = 0;
  String _lastCreditCardNumberValueTyped = '';
  String _newlyCreditCardNumberValueTyped = '';

  @override
  void initState() {
    super.initState();
    _creditCardNumberEnterAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _creditCardNumberLeaveAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
  }

  @override
  void dispose() {
    _creditCardNumberEnterAnimationController.dispose();
    _creditCardNumberLeaveAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDEEFC),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              SizedBox(
                height: 710,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CreditCardForm(
                        onChanged: _creditCardNumbersTextFieldOnValueChanged,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _creditCardNumberLeaveAnimationController.reset();
                        _creditCardNumberLeaveAnimationController.forward();
                        _creditCardNumberEnterAnimationController.reset();
                        _creditCardNumberEnterAnimationController.forward();
                      },
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: CreditCard(
                          creditCardNumberEnterAnimationController:
                              _creditCardNumberEnterAnimationController,
                          creditCardNumberLeaveAnimationController:
                              _creditCardNumberLeaveAnimationController,
                          creditCardNumbers: _creditCardNumbers,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  void _creditCardNumbersTextFieldOnValueChanged(newValue) {
    var str = newValue.trim().replaceAll(' ', '');
    _newlyCreditCardNumberValueTypedIndex = str.length;
    _newlyCreditCardNumberValueTyped = str;
    if (_newlyCreditCardNumberValueTypedIndex >
        _lastCreditCardNumberValueTypedIndex) {
      // for (int i = 0;
      //     i < creditCardNumbers.length;
      //     i++) {
      //   if (i >= lastEnteredValueIndex &&
      //       i < newIndex) {
      //     creditCardNumbers[i] = CreditCardNumberModel(
      //       value: str[i],
      //       isNewValue: true,
      //       fadeText: '#',
      //     );
      //   } else if (i >= newIndex) {
      //     creditCardNumbers[i] = CreditCardNumberModel(
      //       value: '#',
      //       isNewValue: false,
      //       fadeText: '#',
      //     );
      //   } else {
      //     creditCardNumbers[i] = CreditCardNumberModel(
      //       value: str[i],
      //       isNewValue: false,
      //       fadeText: '#',
      //     );
      //   }
      // }
      for (int i = _lastCreditCardNumberValueTypedIndex;
          i < _newlyCreditCardNumberValueTypedIndex;
          i++) {
        _creditCardNumbers[i] = CreditCardNumberModel(
          value: (i >= 4 && i <= 11) ? '*' : str[i],
          isNewlyEnteredValue: true,
        );
      }
      for (int i = _newlyCreditCardNumberValueTypedIndex;
          i < _creditCardNumbers.length;
          i++) {
        _creditCardNumbers[i] = CreditCardNumberModel(
          value: '#',
          isNewlyEnteredValue: false,
        );
      }
      for (int i = 0; i < _lastCreditCardNumberValueTypedIndex; i++) {
        _creditCardNumbers[i] = CreditCardNumberModel(
          value: (i >= 4 && i <= 11) ? '*' : str[i],
          isNewlyEnteredValue: false,
        );
      }
    } else {
      for (int i = _newlyCreditCardNumberValueTypedIndex;
          i < _lastCreditCardNumberValueTypedIndex;
          i++) {
        _creditCardNumbers[i] = CreditCardNumberModel(
          value: '#',
          isNewlyEnteredValue: true,
          leaveAnimatedValue: (i >= 4 && i <= 11)
              ? '*'
              : _lastCreditCardNumberValueTyped.substring(
                  i,
                  i + 1,
                ),
        );
      }
      for (int i = 0; i < str.length; i++) {
        _creditCardNumbers[i] = CreditCardNumberModel(
          value: (i >= 4 && i <= 11) ? '*' : str[i],
          isNewlyEnteredValue: false,
        );
      }
      for (int i = _lastCreditCardNumberValueTypedIndex;
          i < _creditCardNumbers.length;
          i++) {
        _creditCardNumbers[i] = CreditCardNumberModel(
          value: '#',
          isNewlyEnteredValue: false,
        );
      }
    }

    setState(() {});
    _creditCardNumberLeaveAnimationController.reset();
    _creditCardNumberLeaveAnimationController.forward();
    _creditCardNumberEnterAnimationController.reset();
    _creditCardNumberEnterAnimationController.forward();
    _lastCreditCardNumberValueTypedIndex =
        _newlyCreditCardNumberValueTypedIndex;
    _lastCreditCardNumberValueTyped = _newlyCreditCardNumberValueTyped;
  }
}
