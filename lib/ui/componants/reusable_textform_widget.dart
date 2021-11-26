import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final String? label;
  final TextAlign textAlign;
  final bool showCursor;
  final Function()? onTap;
  final Function(String?)? onChanged;

  CustomTextFormField({
    this.controller,
    this.hint,
    this.label,
    this.onTap,
    this.onChanged,
    this.showCursor = true,
    this.textAlign = TextAlign.start,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      onChanged: onChanged,
      controller: controller,
      textAlign: textAlign,
      showCursor: showCursor,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.0,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.0,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.0,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: hint,
        labelText: label,
        isDense: true,
      ),
    );
  }
}
