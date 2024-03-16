import 'package:flutter/material.dart';

import 'payment_card.dart';
import '../models/payment_card_number_model.dart';
import 'payment_card_form.dart';

class WrapperView extends StatefulWidget {
  const WrapperView({super.key});

  @override
  State<WrapperView> createState() => _WrapperViewState();
}

class _WrapperViewState extends State<WrapperView>
    with TickerProviderStateMixin {
  late TextEditingController _paymentCardNumbersTextEditingController;
  late TextEditingController _paymentCardHolderNameTextEditingController;
  late TextEditingController _paymentCardCvvTextEditingController;
  late FocusNode _paymentCardNumbersTextFieldFocusNode;
  late FocusNode _paymentCardHolderNameTextFieldFocusNode;
  late FocusNode _paymentCardCvvTextFieldFocusNode;

  late AnimationController _paymentCardNumberEnterAnimationController;
  late AnimationController _paymentCardNumberLeaveAnimationController;
  late AnimationController _paymentCardFlipAnimationController;

  final List<PaymentCardNumberModel> _paymentCardNumbers = List.generate(
    16,
    growable: false,
    (index) => PaymentCardNumberModel(
      value: '#',
      isNewlyEnteredValue: false,
    ),
  );

  String _paymentCardHolderName = '';

  String _paymentCardCvv = '';

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

  String? _paymentCardExpirationMonth;
  String? _paymentCardExpirationYear;

  int _oldPaymentCardNumbersValueLength = 0;
  String _oldPaymentCardNumbersValue = '';

  Offset _paymentCardFocusCoverOffset = Offset.zero;
  Size _paymentCardFocusCoverSize = const Size(430, 270);

  bool _allowEmptyPaymentCardHolderNameAnimation = false;

  bool _monthDropdownHasFocus = false;
  bool _yearDropdownHasFocus = false;

  @override
  void initState() {
    super.initState();
    _paymentCardNumbersTextEditingController = TextEditingController();
    _paymentCardHolderNameTextEditingController = TextEditingController();
    _paymentCardCvvTextEditingController = TextEditingController();
    _paymentCardNumbersTextFieldFocusNode = FocusNode();
    _paymentCardHolderNameTextFieldFocusNode = FocusNode();
    _paymentCardCvvTextFieldFocusNode = FocusNode();
    _paymentCardNumbersTextFieldFocusNode.addListener(_onFocusChange);
    _paymentCardHolderNameTextFieldFocusNode.addListener(_onFocusChange);
    _paymentCardCvvTextFieldFocusNode.addListener(_onFocusChange);
    _paymentCardNumberEnterAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _paymentCardNumberLeaveAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _paymentCardFlipAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _paymentCardNumbersTextEditingController.dispose();
    _paymentCardHolderNameTextEditingController.dispose();
    _paymentCardCvvTextEditingController.dispose();
    _paymentCardNumbersTextFieldFocusNode.dispose();
    _paymentCardHolderNameTextFieldFocusNode.dispose();
    _paymentCardCvvTextFieldFocusNode.dispose();
    _paymentCardNumbersTextFieldFocusNode.removeListener(_onFocusChange);
    _paymentCardHolderNameTextFieldFocusNode.removeListener(_onFocusChange);
    _paymentCardCvvTextFieldFocusNode.removeListener(_onFocusChange);
    _paymentCardNumberEnterAnimationController.dispose();
    _paymentCardNumberLeaveAnimationController.dispose();
    _paymentCardFlipAnimationController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (_paymentCardFlipAnimationController.value > 0.0) {
      _paymentCardFlipAnimationController.animateBack(
        0,
        curve: Curves.easeInOut,
      );
    }
    setState(() {
      _monthDropdownHasFocus = false;
      _yearDropdownHasFocus = false;
    });
    if (_paymentCardNumbersTextFieldFocusNode.hasFocus) {
      setState(() {
        _paymentCardFocusCoverOffset = const Offset(13, 112);
        _paymentCardFocusCoverSize = const Size(371, 53);
      });
      return;
    }
    if (_paymentCardHolderNameTextFieldFocusNode.hasFocus) {
      setState(() {
        _paymentCardFocusCoverOffset = const Offset(13, 186);
        _paymentCardFocusCoverSize = const Size(315, 63);
      });
      return;
    }
    if (_paymentCardCvvTextFieldFocusNode.hasFocus) {
      setState(() {
        _paymentCardFocusCoverOffset = Offset.zero;
        _paymentCardFocusCoverSize = const Size(430, 270);
      });
      _paymentCardFlipAnimationController.animateTo(
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
          _paymentCardFocusCoverOffset = Offset.zero;
          _paymentCardFocusCoverSize = const Size(430, 270);
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
                        child: PaymentCardForm(
                          paymentCardNumbersTextEditingController:
                              _paymentCardNumbersTextEditingController,
                          onPaymentCardNumbersValueChanged:
                              _onPaymentCardNumbersValueChanged,
                          paymentCardNumbersTextFieldFocusNode:
                              _paymentCardNumbersTextFieldFocusNode,
                          paymentCardHolderNameTextEditingController:
                              _paymentCardHolderNameTextEditingController,
                          onPaymentCardHolderNameValueChanged:
                              (newPaymentCardHolderNameValue) {
                            setState(() {
                              _paymentCardHolderName =
                                  newPaymentCardHolderNameValue;
                              if (_paymentCardHolderName.length == 1) {
                                _allowEmptyPaymentCardHolderNameAnimation =
                                    true;
                              }
                            });
                          },
                          paymentCardHolderNameTextFieldFocusNode:
                              _paymentCardHolderNameTextFieldFocusNode,
                          paymentCardCvvTextEditingController:
                              _paymentCardCvvTextEditingController,
                          onPaymentCardCvvValueChanged:
                              (newPaymentCardCvvValue) {
                            setState(() {
                              _paymentCardCvv = newPaymentCardCvvValue;
                            });
                          },
                          paymentCardCvvTextFieldFocusNode:
                              _paymentCardCvvTextFieldFocusNode,
                          months: _months,
                          years: _years,
                          monthDropdownHasFocus: _monthDropdownHasFocus,
                          yearDropdownHasFocus: _yearDropdownHasFocus,
                          onMonthDropdownValueChanged: (newValue) {
                            setState(() {
                              _paymentCardExpirationMonth = newValue;
                            });
                          },
                          onYearDropdownValueChanged: (newValue) {
                            setState(() {
                              _paymentCardExpirationYear = newValue;
                            });
                          },
                          onMonthDropdownTapped: () {
                            setState(() {
                              _paymentCardFocusCoverOffset =
                                  const Offset(335, 190);
                              _paymentCardFocusCoverSize = const Size(81, 58);
                              _monthDropdownHasFocus = true;
                              _yearDropdownHasFocus = false;
                            });
                          },
                          onYearDropdownTapped: () {
                            setState(() {
                              _paymentCardFocusCoverOffset =
                                  const Offset(335, 190);
                              _paymentCardFocusCoverSize = const Size(81, 58);
                              _yearDropdownHasFocus = true;
                              _monthDropdownHasFocus = false;
                            });
                          },
                          submitButtonAction: () {
                            setState(() {
                              _paymentCardFocusCoverOffset = Offset.zero;
                              _paymentCardFocusCoverSize = const Size(430, 270);
                              _monthDropdownHasFocus = false;
                              _yearDropdownHasFocus = false;
                            });
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: PaymentCard(
                          paymentCardNumberEnterAnimationController:
                              _paymentCardNumberEnterAnimationController,
                          paymentCardNumberLeaveAnimationController:
                              _paymentCardNumberLeaveAnimationController,
                          paymentCardFlipAnimationController:
                              _paymentCardFlipAnimationController,
                          paymentCardNumbers: _paymentCardNumbers,
                          paymentCardHolderName: _paymentCardHolderName,
                          paymentCardFocusCoverOffset:
                              _paymentCardFocusCoverOffset,
                          onPaymentCardFocusCoverOffsetChanged: (offset) {
                            setState(() {
                              _paymentCardFocusCoverOffset = offset;
                            });
                          },
                          paymentCardFocusCoverSize: _paymentCardFocusCoverSize,
                          onPaymentCardFocusCoverSizeChanged: (size) {
                            setState(() {
                              _paymentCardFocusCoverSize = size;
                            });
                          },
                          paymentCardNumbersTextFieldFocusNode:
                              _paymentCardNumbersTextFieldFocusNode,
                          paymentCardHolderNameTextFieldFocusNode:
                              _paymentCardHolderNameTextFieldFocusNode,
                          allowEmptyPaymentCardHolderNameAnimation:
                              _allowEmptyPaymentCardHolderNameAnimation,
                          paymentCardExpirationMonth:
                              _paymentCardExpirationMonth,
                          paymentCardExpirationYear: _paymentCardExpirationYear,
                          monthDropdownHasFocus: _monthDropdownHasFocus,
                          yearDropdownHasFocus: _yearDropdownHasFocus,
                          expiresTextTapAction: () {
                            setState(() {
                              _paymentCardFocusCoverOffset =
                                  const Offset(335, 190);
                              _paymentCardFocusCoverSize = const Size(81, 58);
                              _monthDropdownHasFocus = true;
                              _yearDropdownHasFocus = false;
                            });
                          },
                          monthTextTapAction: () {
                            setState(() {
                              _paymentCardFocusCoverOffset =
                                  const Offset(335, 190);
                              _paymentCardFocusCoverSize = const Size(81, 58);
                              _monthDropdownHasFocus = true;
                              _yearDropdownHasFocus = false;
                            });
                          },
                          yearTextTapAction: () {
                            setState(() {
                              _paymentCardFocusCoverOffset =
                                  const Offset(335, 190);
                              _paymentCardFocusCoverSize = const Size(81, 58);
                              _yearDropdownHasFocus = true;
                              _monthDropdownHasFocus = false;
                            });
                          },
                          paymentCardCvv: _paymentCardCvv,
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

  void _onPaymentCardNumbersValueChanged(String newValue) {
    var numbersValue = newValue.trim().replaceAll(' ', '');
    var newPaymentCardNumbersValueLength = numbersValue.length;
    if (newPaymentCardNumbersValueLength > _oldPaymentCardNumbersValueLength) {
      for (int i = _oldPaymentCardNumbersValueLength;
          i < newPaymentCardNumbersValueLength;
          i++) {
        _paymentCardNumbers[i] = PaymentCardNumberModel(
          value: (i >= 4 && i <= 11) ? '*' : numbersValue[i],
          isNewlyEnteredValue: true,
        );
      }
      for (int i = newPaymentCardNumbersValueLength;
          i < _paymentCardNumbers.length;
          i++) {
        _paymentCardNumbers[i] = PaymentCardNumberModel(
          value: '#',
          isNewlyEnteredValue: false,
        );
      }
      for (int i = 0; i < _oldPaymentCardNumbersValueLength; i++) {
        _paymentCardNumbers[i] = PaymentCardNumberModel(
          value: (i >= 4 && i <= 11) ? '*' : numbersValue[i],
          isNewlyEnteredValue: false,
        );
      }
    } else {
      for (int i = newPaymentCardNumbersValueLength;
          i < _oldPaymentCardNumbersValueLength;
          i++) {
        _paymentCardNumbers[i] = PaymentCardNumberModel(
          value: '#',
          isNewlyEnteredValue: true,
          leaveAnimatedValue: (i >= 4 && i <= 11)
              ? '*'
              : _oldPaymentCardNumbersValue.substring(
                  i,
                  i + 1,
                ),
        );
      }
      for (int i = 0; i < numbersValue.length; i++) {
        _paymentCardNumbers[i] = PaymentCardNumberModel(
          value: (i >= 4 && i <= 11) ? '*' : numbersValue[i],
          isNewlyEnteredValue: false,
        );
      }
      for (int i = _oldPaymentCardNumbersValueLength;
          i < _paymentCardNumbers.length;
          i++) {
        _paymentCardNumbers[i] = PaymentCardNumberModel(
          value: '#',
          isNewlyEnteredValue: false,
        );
      }
    }
    _paymentCardNumberLeaveAnimationController.reset();
    _paymentCardNumberLeaveAnimationController.forward();
    _paymentCardNumberEnterAnimationController.reset();
    _paymentCardNumberEnterAnimationController.forward();
    _oldPaymentCardNumbersValue = numbersValue;
    _oldPaymentCardNumbersValueLength = newPaymentCardNumbersValueLength;
    setState(() {});
  }
}
