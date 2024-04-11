import 'package:flutter/material.dart';

import '../../constants/assets_constants.dart';
import '../../themes/custom_colors.dart';
import '../../themes/custom_text_styles.dart';

class PaymentCardBackSide extends StatelessWidget {
  const PaymentCardBackSide({
    super.key,
    required this.paymentCardCvv,
    required this.isVisible,
  });

  final String paymentCardCvv;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      maintainSize: true,
      maintainState: true,
      maintainAnimation: true,
      maintainInteractivity: false,
      maintainSemantics: false,
      child: Stack(
        children: [
          Positioned(
            top: 30,
            child: Container(
              height: 50,
              width: 430,
              color: CustomColors.paymentCardMagneticStripeColor,
            ),
          ),
          Positioned(
            top: 93,
            child: Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      'CVV',
                      style: CustomTextStyles.paymentCardBackSideLabelTextStyle,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Container(
                    height: 50,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                        right: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          for (int i = 0; i < paymentCardCvv.length; i++) ...[
                            const Text(
                              '*',
                              style: CustomTextStyles.paymentCardCvvTextStyle,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Opacity(
                    opacity: 0.7,
                    child: Image.asset(
                      AssetsConstants.visaLogo,
                      height: 45,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
