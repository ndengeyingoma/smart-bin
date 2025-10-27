import 'package:flutter/material.dart';
import '../services/thingspeak_service.dart';
import '../models/bin_status_model.dart';

class BinStatusWidget extends StatefulWidget {
  const BinStatusWidget({super.key});

  @override
  State<BinStatusWidget> createState() => _BinStatusWidgetState();
}

class _BinStatusWidgetState extends State<BinStatusWidget> {
  final ThingSpeakService _service = ThingSpeakService();
  BinStatusModel? _status;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadStatus();
  }

  Future<void> _loadStatus() async {
    try {
      final data = await _service.fetchFeeds(results: 1);
      final feed =
          (data['feeds'] as List?)?.first as Map<String, dynamic>? ?? {};
      setState(() {
        _status = BinStatusModel.fromFeed(feed);
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load bin data';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const CircularProgressIndicator();
    if (_error != null)
      return Text(_error!, style: const TextStyle(color: Colors.red));

    final fill = _status?.fillLevel ?? 0;
    final temp = _status?.temperature ?? 0;
    final lat = _status?.latitude;
    final lng = _status?.longitude;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('🟢 Fill Level: ${fill.toStringAsFixed(1)}%',
            style: const TextStyle(fontSize: 16)),
        LinearProgressIndicator(value: fill / 100, minHeight: 10),
        const SizedBox(height: 12),
        Text(
          '🌡️ Temperature: ${temp.toStringAsFixed(1)}°C',
          style: TextStyle(
            fontSize: 16,
            color: temp > 40 ? Colors.red : Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        if (lat != null && lng != null)
          Text('📍 Location: ($lat, $lng)',
              style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
