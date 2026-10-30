import 'package:flutter/material.dart';

class CustomerAvatar extends StatelessWidget {
  final String name;
  final double radius;

  const CustomerAvatar({super.key, required this.name, this.radius = 24});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return CircleAvatar(
      radius: radius,
      backgroundColor: colors.primaryContainer,
      child: Text(
        name.isEmpty ? '?' : name[0].toUpperCase(),
        style: TextStyle(
          color: colors.onPrimaryContainer,
          fontSize: radius * 0.8,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
