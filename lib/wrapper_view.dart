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
  late TextEditingController _creditCardNumbersTextEditingController;
  late TextEditingController _creditCardNameTextEditingController;

  late AnimationController _creditCardNumberEnterAnimationController;
  late AnimationController _creditCardNumberLeaveAnimationController;

  final List<CreditCardNumberModel> _creditCardNumbers = List.generate(
    16,
    growable: false,
    (index) => CreditCardNumberModel(
      value: '#',
      isNewlyEnteredValue: false,
    ),
  );

  final List<String> _creditCardName = [];

  int _oldCreditCardNumbersValueLength = 0;
  String _oldCreditCardNumbersValue = '';

  int _oldCreditCardNameValueLength = 0;

  @override
  void initState() {
    super.initState();
    _creditCardNumbersTextEditingController = TextEditingController();
    _creditCardNameTextEditingController = TextEditingController();
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
    _creditCardNumbersTextEditingController.dispose();
    _creditCardNameTextEditingController.dispose();
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
                        creditCardNumbersTextEditingController:
                            _creditCardNumbersTextEditingController,
                        onCreditCardNumbersValueChanged:
                            _onCreditCardNumbersValueChanged,
                        creditCardNameTextEditingController:
                            _creditCardNameTextEditingController,
                        onCreditCardNameValueChanged:
                            _onCreditCardNameValueChanged,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: CreditCard(
                        creditCardNumberEnterAnimationController:
                            _creditCardNumberEnterAnimationController,
                        creditCardNumberLeaveAnimationController:
                            _creditCardNumberLeaveAnimationController,
                        creditCardNumbers: _creditCardNumbers,
                        creditCardName: _creditCardName,
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

  void _onCreditCardNumbersValueChanged(String newValue) {
    var numbersValue = newValue.trim().replaceAll(' ', '');
    var newCreditCardNumbersValueLength = numbersValue.length;
    if (newCreditCardNumbersValueLength > _oldCreditCardNumbersValueLength) {
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
      for (int i = _oldCreditCardNumbersValueLength;
          i < newCreditCardNumbersValueLength;
          i++) {
        _creditCardNumbers[i] = CreditCardNumberModel(
          value: (i >= 4 && i <= 11) ? '*' : numbersValue[i],
          isNewlyEnteredValue: true,
        );
      }
      for (int i = newCreditCardNumbersValueLength;
          i < _creditCardNumbers.length;
          i++) {
        _creditCardNumbers[i] = CreditCardNumberModel(
          value: '#',
          isNewlyEnteredValue: false,
        );
      }
      for (int i = 0; i < _oldCreditCardNumbersValueLength; i++) {
        _creditCardNumbers[i] = CreditCardNumberModel(
          value: (i >= 4 && i <= 11) ? '*' : numbersValue[i],
          isNewlyEnteredValue: false,
        );
      }
    } else {
      for (int i = newCreditCardNumbersValueLength;
          i < _oldCreditCardNumbersValueLength;
          i++) {
        _creditCardNumbers[i] = CreditCardNumberModel(
          value: '#',
          isNewlyEnteredValue: true,
          leaveAnimatedValue: (i >= 4 && i <= 11)
              ? '*'
              : _oldCreditCardNumbersValue.substring(
                  i,
                  i + 1,
                ),
        );
      }
      for (int i = 0; i < numbersValue.length; i++) {
        _creditCardNumbers[i] = CreditCardNumberModel(
          value: (i >= 4 && i <= 11) ? '*' : numbersValue[i],
          isNewlyEnteredValue: false,
        );
      }
      for (int i = _oldCreditCardNumbersValueLength;
          i < _creditCardNumbers.length;
          i++) {
        _creditCardNumbers[i] = CreditCardNumberModel(
          value: '#',
          isNewlyEnteredValue: false,
        );
      }
    }

    _creditCardNumberLeaveAnimationController.reset();
    _creditCardNumberLeaveAnimationController.forward();
    _creditCardNumberEnterAnimationController.reset();
    _creditCardNumberEnterAnimationController.forward();
    _oldCreditCardNumbersValue = numbersValue;
    _oldCreditCardNumbersValueLength = newCreditCardNumbersValueLength;
    setState(() {});
  }

  void _onCreditCardNameValueChanged(String newValue) {
    var nameValue = newValue;
    var newCreditCardNameValueLength = newValue.length;
    var cardNameTextFieldCursorPostion =
        _creditCardNameTextEditingController.selection.base.offset;

    var newlyAddedCharactersLength =
        newCreditCardNameValueLength - _oldCreditCardNameValueLength;

    if (newCreditCardNameValueLength > _oldCreditCardNameValueLength) {
      if ((cardNameTextFieldCursorPostion - newlyAddedCharactersLength) <
          _oldCreditCardNameValueLength) {
        for (int i =
                (cardNameTextFieldCursorPostion - newlyAddedCharactersLength);
            i <
                (newlyAddedCharactersLength +
                    (cardNameTextFieldCursorPostion -
                        newlyAddedCharactersLength));
            i++) {
          _creditCardName.insert(i, nameValue[i]);
        }
      } else {
        for (int i = _oldCreditCardNameValueLength;
            i < newCreditCardNameValueLength;
            i++) {
          _creditCardName.add(nameValue[i]);
        }
      }
    } else {
      var newlyRemovedCharactersLength =
          _oldCreditCardNameValueLength - newCreditCardNameValueLength;

      for (int i =
              ((newlyRemovedCharactersLength + cardNameTextFieldCursorPostion) -
                  1);
          i > (cardNameTextFieldCursorPostion - 1);
          i--) {
        _creditCardName.removeAt(i);
      }
    }
    _oldCreditCardNameValueLength = newCreditCardNameValueLength;
    setState(() {});
  }
}
