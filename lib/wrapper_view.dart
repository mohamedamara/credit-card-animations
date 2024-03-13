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
  late TextEditingController _creditCardHolderNameTextEditingController;
  late FocusNode _creditCardNumbersTextFieldFocusNode;
  late FocusNode _creditCardHolderNameTextFieldFocusNode;

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

  final List<String> _creditCardHolderName = [];

  int _oldCreditCardNumbersValueLength = 0;
  String _oldCreditCardNumbersValue = '';

  int _oldCreditCardHolderNameValueLength = 0;

  Offset _creditCardFocusCoverOffset = Offset.zero;
  Size _creditCardFocusCoverSize = const Size(430, 270);

  bool _allowEmptyCreditCardHolderNameAnimation = false;

  @override
  void initState() {
    super.initState();
    _creditCardNumbersTextEditingController = TextEditingController();
    _creditCardHolderNameTextEditingController = TextEditingController();
    _creditCardNumbersTextFieldFocusNode = FocusNode();
    _creditCardHolderNameTextFieldFocusNode = FocusNode();
    _creditCardNumbersTextFieldFocusNode.addListener(_onFocusChange);
    _creditCardHolderNameTextFieldFocusNode.addListener(_onFocusChange);
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
    _creditCardHolderNameTextEditingController.dispose();
    _creditCardNumbersTextFieldFocusNode.dispose();
    _creditCardHolderNameTextFieldFocusNode.dispose();
    _creditCardNumbersTextFieldFocusNode.removeListener(_onFocusChange);
    _creditCardHolderNameTextFieldFocusNode.removeListener(_onFocusChange);
    _creditCardNumberEnterAnimationController.dispose();
    _creditCardNumberLeaveAnimationController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (_creditCardNumbersTextFieldFocusNode.hasFocus) {
      setState(() {
        _creditCardFocusCoverOffset = const Offset(13, 112);
        _creditCardFocusCoverSize = const Size(371, 53);
      });
      return;
    }
    if (_creditCardHolderNameTextFieldFocusNode.hasFocus) {
      setState(() {
        _creditCardFocusCoverOffset = const Offset(13, 186);
        _creditCardFocusCoverSize = const Size(315, 63);
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _creditCardFocusCoverOffset = Offset.zero;
          _creditCardFocusCoverSize = const Size(430, 270);
        });
      },
      child: Scaffold(
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
                          creditCardNumbersTextFieldFocusNode:
                              _creditCardNumbersTextFieldFocusNode,
                          creditCardHolderNameTextEditingController:
                              _creditCardHolderNameTextEditingController,
                          onCreditCardHolderNameValueChanged:
                              _onCreditCardHolderNameValueChanged,
                          creditCardHolderNameTextFieldFocusNode:
                              _creditCardHolderNameTextFieldFocusNode,
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
                          creditCardHolderName: _creditCardHolderName,
                          creditCardFocusCoverOffset:
                              _creditCardFocusCoverOffset,
                          onCreditCardFocusCoverOffsetChanged: (offset) {
                            setState(() {
                              _creditCardFocusCoverOffset = offset;
                            });
                          },
                          creditCardFocusCoverSize: _creditCardFocusCoverSize,
                          onCreditCardFocusCoverSizeChanged: (size) {
                            setState(() {
                              _creditCardFocusCoverSize = size;
                            });
                          },
                          creditCardNumbersTextFieldFocusNode:
                              _creditCardNumbersTextFieldFocusNode,
                          creditCardHolderNameTextFieldFocusNode:
                              _creditCardHolderNameTextFieldFocusNode,
                          allowEmptyCreditCardHolderNameAnimation:
                              _allowEmptyCreditCardHolderNameAnimation,
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
      ),
    );
  }

  void _onCreditCardNumbersValueChanged(String newValue) {
    var numbersValue = newValue.trim().replaceAll(' ', '');
    var newCreditCardNumbersValueLength = numbersValue.length;
    if (newCreditCardNumbersValueLength > _oldCreditCardNumbersValueLength) {
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

  void _onCreditCardHolderNameValueChanged(String newValue) {
    var nameValue = newValue;
    var newCreditCardNameValueLength = newValue.length;
    var cardNameTextFieldCursorPostion =
        _creditCardHolderNameTextEditingController.selection.base.offset;

    var newlyAddedCharactersLength =
        newCreditCardNameValueLength - _oldCreditCardHolderNameValueLength;

    if (newCreditCardNameValueLength > _oldCreditCardHolderNameValueLength) {
      if ((cardNameTextFieldCursorPostion - newlyAddedCharactersLength) <
          _oldCreditCardHolderNameValueLength) {
        for (int i =
                (cardNameTextFieldCursorPostion - newlyAddedCharactersLength);
            i <
                (newlyAddedCharactersLength +
                    (cardNameTextFieldCursorPostion -
                        newlyAddedCharactersLength));
            i++) {
          _creditCardHolderName.insert(i, nameValue[i]);
        }
      } else {
        for (int i = _oldCreditCardHolderNameValueLength;
            i < newCreditCardNameValueLength;
            i++) {
          _creditCardHolderName.add(nameValue[i]);
        }
      }
      if (_creditCardHolderName.length == 1) {
        setState(() {
          _allowEmptyCreditCardHolderNameAnimation = true;
        });
      }
    } else {
      var newlyRemovedCharactersLength =
          _oldCreditCardHolderNameValueLength - newCreditCardNameValueLength;

      for (int i =
              ((newlyRemovedCharactersLength + cardNameTextFieldCursorPostion) -
                  1);
          i > (cardNameTextFieldCursorPostion - 1);
          i--) {
        _creditCardHolderName.removeAt(i);
      }
    }
    _oldCreditCardHolderNameValueLength = newCreditCardNameValueLength;
    setState(() {});
  }
}
