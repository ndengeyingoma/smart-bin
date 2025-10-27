import 'package:flutter/material.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.purple[50]!, Colors.blue[50]!],
        ),
      ),
      child: Column(
        children: [
          Text(
            'Our Services',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.purple[800],
            ),
          ),
          const SizedBox(height: 30),
          _buildServiceItem(
            'Bin Level Monitoring',
            'Real-time tracking of waste levels',
            Icons.visibility,
            Colors.blue,
          ),
          _buildServiceItem(
            'Route Optimization',
            'Smart collection route planning',
            Icons.map,
            Colors.green,
          ),
          _buildServiceItem(
            'Maintenance Alerts',
            'Proactive maintenance notifications',
            Icons.warning,
            Colors.orange.withAlpha((0.06 * 255).round()),
          ),
          _buildServiceItem(
            'Reporting & Analytics',
            'Detailed waste management reports',
            Icons.analytics,
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 3,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ),
        subtitle: Text(description),
        trailing: Icon(Icons.arrow_forward_ios, color: color),
      ),
    );
  }
}
