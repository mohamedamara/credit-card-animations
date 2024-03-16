import 'package:credit_card_animations/widgets/credit_card_form.dart';
import 'package:flutter/material.dart';

import 'credit_card.dart';
import '../models/credit_card_number_model.dart';

class WrapperView extends StatefulWidget {
  const WrapperView({super.key});

  @override
  State<WrapperView> createState() => _WrapperViewState();
}

class _WrapperViewState extends State<WrapperView>
    with TickerProviderStateMixin {
  late TextEditingController _creditCardNumbersTextEditingController;
  late TextEditingController _creditCardHolderNameTextEditingController;
  late TextEditingController _creditCardCvvTextEditingController;
  late FocusNode _creditCardNumbersTextFieldFocusNode;
  late FocusNode _creditCardHolderNameTextFieldFocusNode;
  late FocusNode _creditCardCvvTextFieldFocusNode;

  late AnimationController _creditCardNumberEnterAnimationController;
  late AnimationController _creditCardNumberLeaveAnimationController;
  late AnimationController _creditCardFlipAnimationController;

  final List<CreditCardNumberModel> _creditCardNumbers = List.generate(
    16,
    growable: false,
    (index) => CreditCardNumberModel(
      value: '#',
      isNewlyEnteredValue: false,
    ),
  );

  String _creditCardHolderName = '';

  String _creditCardCvv = '';

  final List<String> _months = List.generate(
    12,
    growable: false,
    (index) => (index + 1).toString().padLeft(2, '0'),
  );

  final List<String> _years = List.generate(
    12,
    growable: false,
    (index) => (index + DateTime.now().year).toString(),
  );

  String? _creditCardExpirationMonth;
  String? _creditCardExpirationYear;

  int _oldCreditCardNumbersValueLength = 0;
  String _oldCreditCardNumbersValue = '';

  Offset _creditCardFocusCoverOffset = Offset.zero;
  Size _creditCardFocusCoverSize = const Size(430, 270);

  bool _allowEmptyCreditCardHolderNameAnimation = false;

  bool _monthDropdownHasFocus = false;
  bool _yearDropdownHasFocus = false;

  @override
  void initState() {
    super.initState();
    _creditCardNumbersTextEditingController = TextEditingController();
    _creditCardHolderNameTextEditingController = TextEditingController();
    _creditCardCvvTextEditingController = TextEditingController();
    _creditCardNumbersTextFieldFocusNode = FocusNode();
    _creditCardHolderNameTextFieldFocusNode = FocusNode();
    _creditCardCvvTextFieldFocusNode = FocusNode();
    _creditCardNumbersTextFieldFocusNode.addListener(_onFocusChange);
    _creditCardHolderNameTextFieldFocusNode.addListener(_onFocusChange);
    _creditCardCvvTextFieldFocusNode.addListener(_onFocusChange);
    _creditCardNumberEnterAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _creditCardNumberLeaveAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _creditCardFlipAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _creditCardNumbersTextEditingController.dispose();
    _creditCardHolderNameTextEditingController.dispose();
    _creditCardCvvTextEditingController.dispose();
    _creditCardNumbersTextFieldFocusNode.dispose();
    _creditCardHolderNameTextFieldFocusNode.dispose();
    _creditCardCvvTextFieldFocusNode.dispose();
    _creditCardNumbersTextFieldFocusNode.removeListener(_onFocusChange);
    _creditCardHolderNameTextFieldFocusNode.removeListener(_onFocusChange);
    _creditCardCvvTextFieldFocusNode.removeListener(_onFocusChange);
    _creditCardNumberEnterAnimationController.dispose();
    _creditCardNumberLeaveAnimationController.dispose();
    _creditCardFlipAnimationController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (_creditCardFlipAnimationController.value > 0.0) {
      _creditCardFlipAnimationController.animateBack(
        0,
        curve: Curves.easeInOut,
      );
    }
    setState(() {
      _monthDropdownHasFocus = false;
      _yearDropdownHasFocus = false;
    });
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
    if (_creditCardCvvTextFieldFocusNode.hasFocus) {
      setState(() {
        _creditCardFocusCoverOffset = Offset.zero;
        _creditCardFocusCoverSize = const Size(430, 270);
      });
      _creditCardFlipAnimationController.animateTo(
        1,
        curve: Curves.easeInOut,
      );
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
          _monthDropdownHasFocus = false;
          _yearDropdownHasFocus = false;
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
                              (newCreditCardHolderNameValue) {
                            setState(() {
                              _creditCardHolderName =
                                  newCreditCardHolderNameValue;
                              if (_creditCardHolderName.length == 1) {
                                _allowEmptyCreditCardHolderNameAnimation = true;
                              }
                            });
                          },
                          creditCardHolderNameTextFieldFocusNode:
                              _creditCardHolderNameTextFieldFocusNode,
                          creditCardCvvTextEditingController:
                              _creditCardCvvTextEditingController,
                          onCreditCardCvvValueChanged: (newCreditCardCvvValue) {
                            setState(() {
                              _creditCardCvv = newCreditCardCvvValue;
                            });
                          },
                          creditCardCvvTextFieldFocusNode:
                              _creditCardCvvTextFieldFocusNode,
                          months: _months,
                          years: _years,
                          monthDropdownHasFocus: _monthDropdownHasFocus,
                          yearDropdownHasFocus: _yearDropdownHasFocus,
                          onMonthDropdownValueChanged: (newValue) {
                            setState(() {
                              _creditCardExpirationMonth = newValue;
                            });
                          },
                          onYearDropdownValueChanged: (newValue) {
                            setState(() {
                              _creditCardExpirationYear = newValue;
                            });
                          },
                          onMonthDropdownTapped: () {
                            setState(() {
                              _creditCardFocusCoverOffset =
                                  const Offset(335, 190);
                              _creditCardFocusCoverSize = const Size(81, 58);
                              _monthDropdownHasFocus = true;
                              _yearDropdownHasFocus = false;
                            });
                          },
                          onYearDropdownTapped: () {
                            setState(() {
                              _creditCardFocusCoverOffset =
                                  const Offset(335, 190);
                              _creditCardFocusCoverSize = const Size(81, 58);
                              _yearDropdownHasFocus = true;
                              _monthDropdownHasFocus = false;
                            });
                          },
                          submitButtonAction: () {
                            setState(() {
                              _creditCardFocusCoverOffset = Offset.zero;
                              _creditCardFocusCoverSize = const Size(430, 270);
                              _monthDropdownHasFocus = false;
                              _yearDropdownHasFocus = false;
                            });
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: CreditCard(
                          creditCardNumberEnterAnimationController:
                              _creditCardNumberEnterAnimationController,
                          creditCardNumberLeaveAnimationController:
                              _creditCardNumberLeaveAnimationController,
                          creditCardFlipAnimationController:
                              _creditCardFlipAnimationController,
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
                          creditCardExpirationMonth: _creditCardExpirationMonth,
                          creditCardExpirationYear: _creditCardExpirationYear,
                          monthDropdownHasFocus: _monthDropdownHasFocus,
                          yearDropdownHasFocus: _yearDropdownHasFocus,
                          expiresTextTapAction: () {
                            setState(() {
                              _creditCardFocusCoverOffset =
                                  const Offset(335, 190);
                              _creditCardFocusCoverSize = const Size(81, 58);
                              _monthDropdownHasFocus = true;
                              _yearDropdownHasFocus = false;
                            });
                          },
                          monthTextTapAction: () {
                            setState(() {
                              _creditCardFocusCoverOffset =
                                  const Offset(335, 190);
                              _creditCardFocusCoverSize = const Size(81, 58);
                              _monthDropdownHasFocus = true;
                              _yearDropdownHasFocus = false;
                            });
                          },
                          yearTextTapAction: () {
                            setState(() {
                              _creditCardFocusCoverOffset =
                                  const Offset(335, 190);
                              _creditCardFocusCoverSize = const Size(81, 58);
                              _yearDropdownHasFocus = true;
                              _monthDropdownHasFocus = false;
                            });
                          },
                          creditCardCvv: _creditCardCvv,
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
}
