import 'package:flutter/material.dart';
import 'package:smart_bin1/screens/auth/login_page.dart';
import 'package:smart_bin1/screens/landing/contacts_section.dart';
import 'package:smart_bin1/screens/landing/home_section.dart';
import 'package:smart_bin1/screens/landing/services_section.dart';
import 'package:smart_bin1/widgets/custom_navigation_bar.dart';
import 'package:smart_bin1/widgets/footer_widget.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController _pageController = PageController();
  bool _isAuthenticated = false; // This should be managed by an auth service

  void _onLoginPressed() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  void _onLogoutPressed() {
    // TODO: Implement logout functionality
    setState(() {
      _isAuthenticated = false;
    });
  }

  void _navigateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavigationBar(
        title: 'Smart Bin',
        isAuthenticated: _isAuthenticated,
        onLoginPressed: _onLoginPressed,
        onLogoutPressed: _onLogoutPressed,
        onHomePressed: () => _navigateToPage(0),
        onServicesPressed: () => _navigateToPage(1),
        onContactUsPressed: () => _navigateToPage(2),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: const [
                HomeSection(),
                ServicesSection(),
                ContactsSection(),
              ],
            ),
          ),
          const FooterWidget(),
        ],
      ),
    );
  }
}
