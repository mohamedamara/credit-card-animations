import 'package:flutter/material.dart';

import 'gesture_detector_with_mouse_hover.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetectorWithMouseHover(
      onTap: () {},
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF2364D2),
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              offset: Offset(3, 10),
              blurRadius: 20,
              spreadRadius: 0,
              color: Color.fromRGBO(35, 100, 210, 0.3),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Submit',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
