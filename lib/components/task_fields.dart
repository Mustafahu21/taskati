import 'package:flutter/material.dart';

class TaskFields extends StatelessWidget {
  const TaskFields({
    super.key,
    required this.hint,
    required this.controller,
    this.maxLines,
    this.onTap,
    this.suffixIcon,
    this.prefixIcon,
    this.readonly,
  });

  final String hint;
  final TextEditingController controller;
  final int? maxLines;
  final Function()? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? readonly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
      controller: controller,
      maxLines: maxLines ?? 1,
      onTap: onTap,
      readOnly: readonly ?? false,
    );
  }
}
