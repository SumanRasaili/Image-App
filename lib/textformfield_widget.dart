// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomTextField extends ConsumerWidget {
  final TextEditingController controller;
  final void Function()? onTap;
  final String labeltext;
  const CustomTextField({
    super.key,
    required this.controller,
    this.onTap,
    required this.labeltext,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      readOnly: true,
      controller: controller,
      onTap: onTap,
      decoration: InputDecoration(
          isDense: true,
          labelText: labeltext,
          contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          suffixIcon: const Icon(Icons.date_range),
          hintText: "Search $labeltext",
          border: const OutlineInputBorder()),
    );
  }
}
