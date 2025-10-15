import 'package:flutter/material.dart';
import 'package:smart_bin1/screens/landing/partners_section.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
            color: Colors.blue.shade50,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome to Smart Bin',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'The future of waste management is here. Our smart bins optimize collection, reduce costs, and create a cleaner environment.',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                // ElevatedButton(
                //   onPressed: () {},
                //   child: const Text('Learn More'),
                // ),
              ],
            ),
          ),

          // About Us Section
          Container(
            padding: const EdgeInsets.all(40),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About Us',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'We are a team of innovators dedicated to solving the challenges of urban waste management. Our mission is to create sustainable solutions that benefit both communities and the environment.',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 40),
                Icon(
                  Icons.recycling,
                  size: 150,
                  color: Colors.green,
                ),
              ],
            ),
          ),

          // Partners Section
          const PartnersSection(),
        ],
      ),
    );
  }
}
