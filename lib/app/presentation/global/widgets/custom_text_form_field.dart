import 'package:flutter/material.dart';

import '../../../data/utils/constants/themes.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.validator,
    required this.label,
    required this.hintText,
    this.focusNode,
    this.nextFocusNode,
    this.suffix,
    this.maxLines,
    this.inputType = TextInputType.text,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? Function(String?) validator;
  final FocusNode? nextFocusNode;
  final String label;
  final String hintText;
  final String? suffix;
  final int? maxLines;
  final TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintMaxLines: maxLines,
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: const TextStyle(
          color: kTextColor,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: kTextColor,
          ),
        ),
        errorStyle: const TextStyle(
          color: kError,
        ),
        alignLabelWithHint: true,
        hintText: hintText,
        prefixText: suffix,
        hintStyle: const TextStyle(
          color: kLightTextColor,
        ),
      ),
      style: const TextStyle(
        color: kTextColor,
      ),
      validator: validator,
      focusNode: focusNode,
      textInputAction: TextInputAction.next,
      keyboardType: inputType,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(nextFocusNode);
      },
    );
  }
}
