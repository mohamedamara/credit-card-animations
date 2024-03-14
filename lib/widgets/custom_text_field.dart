import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.height = 50,
    this.width = double.infinity,
    this.readOnly = false,
    this.hintText,
    required this.keyboardType,
    this.maxLength,
    this.inputFormatters,
    this.contentPadding = const EdgeInsets.only(
      left: 17,
      right: 14,
      top: 14,
      bottom: 17,
    ),
    required this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final double height;
  final double width;
  final bool readOnly;
  final String? hintText;
  final TextInputType? keyboardType;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry contentPadding;
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
      child: AnimatedContainer(
        height: height,
        width: width,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: focusNode.hasFocus
              ? [
                  const BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 20,
                    spreadRadius: -13,
                    color: Color.fromRGBO(32, 56, 117, 0.35),
                  ),
                ]
              : null,
        ),
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          readOnly: readOnly,
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
            hintText: hintText,
            contentPadding: contentPadding,
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
      ),
    );
  }
}
