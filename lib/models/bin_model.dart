import 'package:cloud_firestore/cloud_firestore.dart';

class BinModel {
  final String id;
  final GeoPoint location;
  final String status;
  final Timestamp lastUpdated;

  BinModel({
    required this.id,
    required this.location,
    required this.status,
    required this.lastUpdated,
  });

  // Factory constructor to create a BinModel from a map
  factory BinModel.fromMap(Map<String, dynamic> data, String documentId) {
    return BinModel(
      id: documentId,
      location: data['location'] ?? GeoPoint(0, 0),
      status: data['status'] ?? 'unknown',
      lastUpdated: data['lastUpdated'] ?? Timestamp.now(),
    );
  }

  // Method to convert a BinModel to a map
  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'status': status,
      'lastUpdated': lastUpdated,
    };
  }
}
