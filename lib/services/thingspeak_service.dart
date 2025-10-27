import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';

class ThingSpeakService {
  final String channelId;
  final String? readApiKey;
  final String? writeApiKey;

  ThingSpeakService({
    String? channelId,
    String? readApiKey,
    String? writeApiKey,
  })  : channelId =
            channelId ?? dotenv.env['THINGSPEAK_CHANNEL_ID'] ?? '1634283',
        readApiKey = readApiKey ?? dotenv.env['THINGSPEAK_READ_KEY'],
        writeApiKey = writeApiKey ?? dotenv.env['THINGSPEAK_WRITE_KEY'];

  /// Fetches recent feeds from the channel
  Future<Map<String, dynamic>> fetchFeeds({int results = 50}) async {
    final uri =
        Uri.https('api.thingspeak.com', '/channels/$channelId/feeds.json', {
      'results': results.toString(),
      if (readApiKey != null && readApiKey!.isNotEmpty) 'api_key': readApiKey!,
    });

    try {
      final res = await http.get(uri).timeout(const Duration(seconds: 10));
      if (res.statusCode != 200) {
        throw Exception('ThingSpeak fetchFeeds failed: ${res.statusCode}');
      }
      return json.decode(res.body) as Map<String, dynamic>;
    } catch (e) {
      debugPrint('fetchFeeds error: $e');
      rethrow;
    }
  }

  /// Fetches a specific field's data
  Future<Map<String, dynamic>> fetchField(int fieldNumber,
      {int results = 50}) async {
    final uri = Uri.https(
        'api.thingspeak.com', '/channels/$channelId/fields/$fieldNumber.json', {
      'results': results.toString(),
    });

    try {
      final res = await http.get(uri).timeout(const Duration(seconds: 10));
      if (res.statusCode != 200) {
        throw Exception('ThingSpeak fetchField failed: ${res.statusCode}');
      }
      return json.decode(res.body) as Map<String, dynamic>;
    } catch (e) {
      debugPrint('fetchField error: $e');
      rethrow;
    }
  }

  /// Fetches channel status
  Future<Map<String, dynamic>> fetchStatus() async {
    final uri =
        Uri.https('api.thingspeak.com', '/channels/$channelId/status.json');

    try {
      final res = await http.get(uri).timeout(const Duration(seconds: 10));
      if (res.statusCode != 200) {
        throw Exception('ThingSpeak fetchStatus failed: ${res.statusCode}');
      }
      return json.decode(res.body) as Map<String, dynamic>;
    } catch (e) {
      debugPrint('fetchStatus error: $e');
      rethrow;
    }
  }

  /// Updates a specific field with a value
  Future<void> updateField(int fieldNumber, Object value) async {
    final key = writeApiKey ?? dotenv.env['THINGSPEAK_WRITE_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception('ThingSpeak write key missing');
    }

    final uri = Uri.parse(
        'https://api.thingspeak.com/update?api_key=$key&field$fieldNumber=${Uri.encodeComponent('$value')}');

    try {
      final res = await http.get(uri).timeout(const Duration(seconds: 10));
      if (res.statusCode != 200 || res.body == '0') {
        throw Exception(
            'ThingSpeak updateField failed: ${res.statusCode} ${res.body}');
      }
    } catch (e) {
      debugPrint('updateField error: $e');
      rethrow;
    }
  }

  /// Fetches the latest value of a field by name (e.g., 'field1')
  Future<String?> fetchLastFieldByName(String fieldName) async {
    try {
      final data = await fetchFeeds(results: 1);
      final feeds = (data['feeds'] as List<dynamic>?) ?? [];
      if (feeds.isEmpty) return null;
      final feed = feeds.first as Map<String, dynamic>;
      final v = feed[fieldName];
      return v != null ? '$v' : null;
    } catch (e) {
      debugPrint('fetchLastFieldByName error: $e');
      return null;
    }
  }

  /// Fetches latest values for multiple fields
  Future<Map<String, String>> fetchLatestFields(List<String> fieldNames) async {
    try {
      final data = await fetchFeeds(results: 1);
      final feed =
          (data['feeds'] as List?)?.first as Map<String, dynamic>? ?? {};
      return {
        for (var name in fieldNames) name: feed[name]?.toString() ?? 'N/A',
      };
    } catch (e) {
      debugPrint('fetchLatestFields error: $e');
      return {for (var name in fieldNames) name: 'Error'};
    }
  }
}
