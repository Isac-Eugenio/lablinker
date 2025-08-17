import 'package:flutter/material.dart';

class ItemHomeWidget extends StatelessWidget {
  final IconData? icon;
  final String title;
  final Color? color;
  final int length;

  const ItemHomeWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    const idealWidthFactor = 0.47;
    const idealHeightDivisor = 3.6;

    final clampedLength = length > 6 ? 6 : length;

    final widthFactor = idealWidthFactor * (6 / clampedLength).clamp(0.5, 1.0);
    final heightDivisor =
        idealHeightDivisor * (clampedLength / 6).clamp(0.5, 1.0);

    final width = size.width * widthFactor;
    final height = size.height / heightDivisor;

    final iconSize = (130 - (clampedLength - 1) * 10).clamp(40, 130);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white70, width: 6),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            color: Colors.transparent,
            elevation: 100,
            shape: const CircleBorder(),
            child: Icon(
              icon,
              size: iconSize.toDouble(),
              color: Colors.white70,
              shadows: const [
                Shadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(2, 4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Material(
            color: Colors.transparent,
            elevation: 100,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}

/*
* const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(4, 4),
          ),
        ],*/
