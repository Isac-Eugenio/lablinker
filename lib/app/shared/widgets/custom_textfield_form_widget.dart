import 'package:flutter/material.dart';

class CustomTextFieldFormWidget extends StatelessWidget {
  final String label;
  final int maxLength;
  final ValueChanged<String> onChanged;

  const CustomTextFieldFormWidget({
    super.key,
    required this.label,
    required this.maxLength,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        maxLength: maxLength,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: Theme.of(context).textTheme.titleSmall,
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          counterText: '',
        ),
        onChanged: onChanged,
      ),
    );
  }
}
