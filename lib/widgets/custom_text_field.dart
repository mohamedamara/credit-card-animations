import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.keyboardType,
    this.maxLength,
    this.inputFormatters,
    required this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType? keyboardType;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.blue.shade100,
          selectionColor: Colors.blue.shade100,
          selectionHandleColor: Colors.blue.shade100,
        ),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        maxLength: maxLength,
        enableInteractiveSelection: true,
        keyboardType: keyboardType,
        style: const TextStyle(
          color: Color(0xFF1a3b5d),
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        cursorColor: Colors.black,
        cursorWidth: 1,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 17,
            horizontal: 17,
          ),
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFFced6e0),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFF3d9cff),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
