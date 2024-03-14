import 'package:flutter/material.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  const CustomDropdownButton({
    super.key,
    required this.items,
    required this.hintText,
    required this.onChanged,
    required this.onTap,
    required this.hasFocus,
  });

  final List<T> items;
  final String hintText;
  final bool hasFocus;
  final void Function(T?) onChanged;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: hasFocus ? const Color(0xFF3d9cff) : const Color(0xFFced6e0),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
        boxShadow: hasFocus
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
      child: DropdownButtonFormField<T>(
        padding: const EdgeInsets.only(left: 17, right: 10),
        icon: const Icon(Icons.expand_more),
        iconEnabledColor: const Color(0xFF1A3B5D),
        iconSize: 28,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Color(0xFF1a3b5d),
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        hint: Text(
          hintText,
          style: const TextStyle(
            color: Color(0xFF1a3b5d),
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        dropdownColor: Colors.white,
        style: const TextStyle(
          color: Color(0xFF1a3b5d),
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        items: items
            .map(
              (item) => DropdownMenuItem<T>(
                value: item,
                child: Text(
                  item.toString(),
                ),
              ),
            )
            .toList(),
        menuMaxHeight: 300,
        onChanged: onChanged,
        onTap: onTap,
      ),
    );
  }
}
