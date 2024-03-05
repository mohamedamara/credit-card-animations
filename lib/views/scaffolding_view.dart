import 'package:flutter/material.dart';

import '../widgets/credit_card.dart';

class ScaffoldingView extends StatelessWidget {
  const ScaffoldingView({super.key});

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
                ),
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: CreditCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
