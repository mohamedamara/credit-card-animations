import 'package:flutter/material.dart';

import '../../../constants/assets_constants.dart';

class PaymentCardChip extends StatelessWidget {
  const PaymentCardChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 25,
      left: 25,
      child: Image.asset(
        AssetsConstants.chipImage,
        width: 60,
      ),
    );
  }
}
