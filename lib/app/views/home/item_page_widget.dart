import 'package:flutter/material.dart';

class ItemPageWidget extends StatelessWidget {
  final String title;
  final IconData icon;

  final String? route;

  const ItemPageWidget({
    super.key,
    required this.title,
    required this.icon,
    this.route,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: route == null
          ? null
          : () => Navigator.of(context).pushReplacementNamed(route!),
      child: Card(
        color: Colors.transparent,
        elevation: 3.0,
        shadowColor: Colors.white24,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Colors.white, width: 1.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48.0, color: Colors.white),
              const SizedBox(height: 12.0),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
