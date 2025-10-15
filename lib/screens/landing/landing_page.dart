import 'package:flutter/material.dart';
import '../auth/login_page.dart';
import '../../widgets/responsive_background.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResponsiveBackground(child: LoginPage()), // Only shows login screen
    );
  }
}
