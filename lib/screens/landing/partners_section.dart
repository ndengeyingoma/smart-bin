import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class PartnersSection extends StatelessWidget {
  const PartnersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'Our Trusted Partners',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _buildPartnerCard('Eco Solutions Inc.', Icons.eco, Colors.green),
              _buildPartnerCard(
                'Green Tech Ltd.',
                Icons.engineering,
                Colors.blue,
              ),
              _buildPartnerCard(
                'Urban Waste Mgmt',
                Icons.business,
                Colors.purple,
              ),
              _buildPartnerCard(
                'Smart City Initiative',
                Icons.location_city,
                Colors.orange,
              ),
              _buildPartnerCard(
                'Environmental Agency',
                Icons.public,
                Colors.teal,
              ),
              _buildPartnerCard(
                'Tech Innovations',
                Icons.lightbulb,
                Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPartnerCard(String name, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Container(
        width: 150,
        height: 150,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 30, color: color),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: AutoSizeText(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
