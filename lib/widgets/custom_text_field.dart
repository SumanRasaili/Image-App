// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final void Function()? onTap;
  final bool readOnly;
  const CustomTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      onTap: onTap,
      decoration: InputDecoration(
          isDense: true,
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          suffixIcon: Icon(
            Icons.search,
            size: 20,
            color: Colors.white.withOpacity(0.8),
          ),
          hintText: "Search $labelText",
          border: const OutlineInputBorder()),
    );
  }
}
