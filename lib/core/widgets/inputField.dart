import 'package:flutter/material.dart';
import 'package:mob_final/core/theme/colors.dart';
import 'package:mob_final/core/theme/spacing.dart';

class InputField extends StatefulWidget {
  final List<String? Function(String?)> validationFuncs;
  final String? label;
  final IconData? icon;
  final TextEditingController? controller;
  final String? helper;
  final int maxLines;
  final int minLines;
  final bool isPassword;
  final void Function(String?)? onSaved;

  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;

  const InputField({
    super.key,
    required this.validationFuncs,
    this.label,
    this.icon,
    this.onSaved,
    this.helper,
    this.maxLines = 1,
    this.minLines = 1,
    this.isPassword = false,
    this.controller,
    this.focusNode,
    this.onFieldSubmitted,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool obscure = true;

  String? _validate(String? value) {
    for (final validator in widget.validationFuncs) {
      final result = validator(value);
      if (result != null) return result;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.s),
      child: TextFormField(
        obscureText: widget.isPassword ? obscure : false,
        controller: widget.controller,
        focusNode: widget.focusNode,
        validator: _validate,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        onSaved: widget.onSaved,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          labelText: widget.label,
          helperText: widget.helper,
          border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.s),
                ),
          prefixIcon:
              widget.icon != null ? Icon(widget.icon) : null,
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                  icon: Icon(
                    obscure
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}