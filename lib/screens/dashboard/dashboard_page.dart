import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../services/thingspeak_service.dart';
import 'map_view.dart';

class DashboardPage extends StatefulWidget {
  final String userName;
  final String email;
  const DashboardPage({super.key, required this.userName, required this.email});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final ThingSpeakService _ts = ThingSpeakService();
  late Future<List<Map<String, dynamic>>> _binsFuture;

  @override
  void initState() {
    super.initState();
    _binsFuture = _loadBinsFromThingSpeak();
  }

  Future<void> _refresh() async {
    setState(() {
      _binsFuture = _loadBinsFromThingSpeak();
    });
  }

  Future<List<Map<String, dynamic>>> _loadBinsFromThingSpeak() async {
    final data = await _ts.fetchFeeds(results: 300);
    final feeds = (data['feeds'] as List<dynamic>?) ?? [];
    final Map<String, Map<String, dynamic>> bins = {};

    for (final raw in feeds) {
      final Map<String, dynamic> f = Map<String, dynamic>.from(raw as Map);
      final binId = (f['field1'] ?? '').toString().trim();
      if (binId.isEmpty) continue;

      final level = double.tryParse('${f['field2'] ?? ''}') ?? 0.0;
      final collected = double.tryParse('${f['field3'] ?? ''}') ?? 0.0;
      final lat = double.tryParse('${f['field4'] ?? ''}') ?? 0.0;
      final lng = double.tryParse('${f['field5'] ?? ''}') ?? 0.0;
      final time = f['created_at'] ?? f['entry_id']?.toString() ?? '';

      final bin = bins.putIfAbsent(
          binId,
          () => {
                'binId': binId,
                'level': level,
                'collected': 0.0,
                'lat': lat,
                'lng': lng,
                'lastUpdated': time,
              });

      bin['collected'] = (bin['collected'] as double) + collected;
      bin['level'] = level;
      if (lat != 0.0 && lng != 0.0) {
        bin['lat'] = lat;
        bin['lng'] = lng;
      }
      bin['lastUpdated'] = time;
    }

    return bins.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    final greeting = widget.email == 'admin@smartbin.com'
        ? 'Welcome back, Admin!'
        : 'Good morning, ${widget.userName}!';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(onPressed: _refresh, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _binsFuture,
          builder: (context, snap) {
            if (snap.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snap.hasError) {
              return Center(child: Text('Error: ${snap.error}'));
            }

            final bins = snap.data ?? [];
            final totalCollected = bins.fold<double>(
                0.0, (s, b) => s + (b['collected'] as double));

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(greeting,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Total Bins',
                                    style: TextStyle(color: Colors.grey[600])),
                                const SizedBox(height: 6),
                                Text('${bins.length}',
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold)),
                              ]),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('Total Collected',
                                    style: TextStyle(color: Colors.grey[600])),
                                const SizedBox(height: 6),
                                Text(totalCollected.toStringAsFixed(2),
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold)),
                              ]),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('All Bins',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  ...bins.map((b) {
                    final lat = (b['lat'] as double?) ?? 0.0;
                    final lng = (b['lng'] as double?) ?? 0.0;
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                            child:
                                Text((b['binId'] as String).split('-').last)),
                        title: Text(b['binId'] as String),
                        subtitle: Text(
                            'Level: ${(b['level'] as double).toStringAsFixed(1)} • Collected: ${(b['collected'] as double).toStringAsFixed(2)}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.map),
                          onPressed: () {
                            if (lat == 0.0 && lng == 0.0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('No location available')));
                              return;
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => MapViewPage(
                                        initialLocation: LatLng(lat, lng),
                                        title: b['binId'] as String)));
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
