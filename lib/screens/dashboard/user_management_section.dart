import 'package:flutter/material.dart';

class UserManagementSection extends StatelessWidget {
  const UserManagementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'User Management',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text('Manage users, roles, and permissions here.'),
      ],
    );
  }
}
