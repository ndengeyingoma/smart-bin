import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final VoidCallback onLoginPressed;
  final bool isAuthenticated;
  final VoidCallback onLogoutPressed;
  final VoidCallback onHomePressed;
  final VoidCallback onServicesPressed;
  final VoidCallback onContactUsPressed;

  const CustomNavigationBar({
    required this.title,
    required this.onLoginPressed,
    required this.isAuthenticated,
    required this.onLogoutPressed,
    required this.onHomePressed,
    required this.onServicesPressed,
    required this.onContactUsPressed,
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;

    return AppBar(
      title: Text(title),
      actions: [
        TextButton(
          onPressed: onHomePressed,
          child: const Text('Home', style: TextStyle(color: Colors.white)),
        ),
        TextButton(
          onPressed: onServicesPressed,
          child: const Text('Services', style: TextStyle(color: Colors.white)),
        ),
        TextButton(
          onPressed: onContactUsPressed,
          child: const Text('Contact Us', style: TextStyle(color: Colors.white)),
        ),
        if (!isAuthenticated)
          isWide
              ? TextButton.icon(
                  onPressed: onLoginPressed,
                  icon: const Icon(Icons.login, color: Colors.white),
                  label: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : IconButton(
                  icon: const Icon(Icons.login),
                  onPressed: onLoginPressed,
                  tooltip: 'Login',
                )
        else
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: onLogoutPressed,
            tooltip: 'Logout',
          ),
      ],
    );
  }
}