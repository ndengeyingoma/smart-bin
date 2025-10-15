import 'package:flutter/material.dart';
import '../../models/bin_model.dart';
import '../../widgets/responsive_background.dart';

class BinDetailsPage extends StatelessWidget {
  const BinDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Bin> bins = [
      Bin(name: 'Bin 1', location: 'Location 1', fillLevel: 75),
      Bin(name: 'Bin 2', location: 'Location 2', fillLevel: 50),
      Bin(name: 'Bin 3', location: 'Location 3', fillLevel: 90),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bin Details'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ResponsiveBackground(
        child: BinListSection(bins: bins),
      ),
    );
  }
}

class BinListSection extends StatelessWidget {
  final List<Bin> bins;

  const BinListSection({super.key, required this.bins});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Available Bins',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: bins.length,
            itemBuilder: (context, index) {
              final bin = bins[index];
              return Card(
                color: Colors.white.withOpacity(0.8),
                child: ListTile(
                  title: Text(bin.name),
                  subtitle: Text('${bin.fillLevel}% full • ${bin.location}'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
