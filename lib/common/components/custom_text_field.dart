// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:vritapp/config/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Widget? suffix;
  final String hintText;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final bool readOnly;
  const CustomTextField({
    super.key,
    required this.labelText,
    this.suffix,
    this.suffixIcon,
    required this.hintText,
    this.onFieldSubmitted,
    this.focusNode,
    this.onChanged,
    required this.controller,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      focusNode: focusNode,
      controller: controller,
      style: Theme.of(context)
          .textTheme
          .titleSmall
          ?.copyWith(color: AppColors.whiteColor),
      onTap: onTap,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
          suffix: suffix,
          isDense: true,
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          suffixIcon: suffixIcon ??
              Icon(
                Icons.search,
                size: 20,
                color: Colors.white.withOpacity(0.8),
              ),
          hintText: "Search $labelText",
          border: const OutlineInputBorder()),
    );
  }
}
