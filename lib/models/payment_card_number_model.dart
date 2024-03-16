class PaymentCardNumberModel {
  PaymentCardNumberModel({
    required this.value,
    required this.isNewlyEnteredValue,
    this.leaveAnimatedValue = '#',
  });

  final String value;
  final bool isNewlyEnteredValue;
  final String leaveAnimatedValue;

  @override
  String toString() {
    return 'Value: $value, isNewlyEnteredValue: $isNewlyEnteredValue, leave animation value: $leaveAnimatedValue';
  }
}
