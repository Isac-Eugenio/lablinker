import 'package:flutter/material.dart';

class CustomGestureWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;

  const CustomGestureWidget({super.key, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: child,
    );
  }
}
