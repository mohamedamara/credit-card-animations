import 'package:flutter/material.dart';

import '../../../constants/assets_constants.dart';

class PaymentCardLogo extends StatelessWidget {
  const PaymentCardLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 25,
      right: 25,
      child: Image.asset(
        AssetsConstants.visaLogo,
        height: 45,
      ),
    );
  }
}
