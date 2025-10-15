import 'package:flutter/material.dart';

class ResponsiveBackground extends StatelessWidget {
  final Widget child;

  const ResponsiveBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1a237e),
            Color(0xFF004d40),
          ],
        ),
      ),
      child: child,
    );
  }
}
