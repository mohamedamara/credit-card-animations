import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/credit_card.dart';

class ScaffoldingView extends StatefulWidget {
  const ScaffoldingView({super.key});

  @override
  State<ScaffoldingView> createState() => _ScaffoldingViewState();
}

class _ScaffoldingViewState extends State<ScaffoldingView>
    with TickerProviderStateMixin {
  late TextEditingController _creditCardNumberTextEditingController;

  late AnimationController enterAnimationController;
  late AnimationController leaveAnimationController;

  List<CreditCardNumberModel> creditCardNumbers = List.generate(
    16,
    (index) => CreditCardNumberModel(
      value: '#',
      isNewValue: false,
      fadeText: '#',
    ),
  );

  int lastEnteredValueIndex = 0;
  String lastValueTyped = '';
  String newValueTyped = '';

  @override
  void initState() {
    super.initState();
    _creditCardNumberTextEditingController = TextEditingController();
    enterAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    leaveAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
  }

  @override
  void dispose() {
    _creditCardNumberTextEditingController.dispose();
    enterAnimationController.dispose();
    leaveAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDEEFC),
      body: Center(
        child: SizedBox(
          height: 705,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 570,
                  width: 557,
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
                      const SizedBox(height: 200),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: TextField(
                          controller: _creditCardNumberTextEditingController,
                          maxLength: 19,
                          enableInteractiveSelection: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CustomInputFormatter()
                          ],
                          onChanged: (value) {
                            var str = value.trim().replaceAll(' ', '');

                            var newIndex = str.length;

                            newValueTyped = str;
                            if (newIndex > lastEnteredValueIndex) {
                              for (int i = lastEnteredValueIndex;
                                  i < newIndex;
                                  i++) {
                                creditCardNumbers[i] = CreditCardNumberModel(
                                  value: (i >= 4 && i <= 11) ? '*' : str[i],
                                  isNewValue: true,
                                  fadeText: '#',
                                );
                              }
                              for (int i = newIndex;
                                  i < creditCardNumbers.length;
                                  i++) {
                                creditCardNumbers[i] = CreditCardNumberModel(
                                  value: '#',
                                  isNewValue: false,
                                  fadeText: '#',
                                );
                              }
                              for (int i = 0; i < lastEnteredValueIndex; i++) {
                                creditCardNumbers[i] = CreditCardNumberModel(
                                  value: (i >= 4 && i <= 11) ? '*' : str[i],
                                  isNewValue: false,
                                  fadeText: '#',
                                );
                              }
                            } else {
                              for (int i = newIndex;
                                  i < lastEnteredValueIndex;
                                  i++) {
                                creditCardNumbers[i] = CreditCardNumberModel(
                                  value: '#',
                                  isNewValue: true,
                                  fadeText: (i >= 4 && i <= 11)
                                      ? '*'
                                      : lastValueTyped.substring(
                                          i,
                                          i + 1,
                                        ),
                                );
                              }
                              for (int i = 0; i < str.length; i++) {
                                creditCardNumbers[i] = CreditCardNumberModel(
                                  value: (i >= 4 && i <= 11) ? '*' : str[i],
                                  isNewValue: false,
                                  fadeText: '#',
                                );
                              }
                              for (int i = lastEnteredValueIndex;
                                  i < creditCardNumbers.length;
                                  i++) {
                                creditCardNumbers[i] = CreditCardNumberModel(
                                  value: '#',
                                  isNewValue: false,
                                  fadeText: '#',
                                );
                              }
                            }

                            setState(() {});
                            leaveAnimationController.reset();
                            leaveAnimationController.forward();
                            enterAnimationController.reset();
                            enterAnimationController.forward();
                            lastEnteredValueIndex = newIndex;
                            lastValueTyped = newValueTyped;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: CreditCard(
                  enterAnimationController: enterAnimationController,
                  leaveAnimationController: leaveAnimationController,
                  creditCardNumbers: creditCardNumbers,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' ');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

class CreditCardNumberModel {
  final String value;
  final bool isNewValue;
  final String fadeText;

  CreditCardNumberModel({
    required this.value,
    required this.isNewValue,
    required this.fadeText,
  });

  @override
  String toString() {
    return '$value $isNewValue $fadeText';
  }
}
