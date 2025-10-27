class BinStatusModel {
  final double? fillLevel;
  final double? temperature;
  final double? latitude;
  final double? longitude;

  BinStatusModel({
    this.fillLevel,
    this.temperature,
    this.latitude,
    this.longitude,
  });

  factory BinStatusModel.fromFeed(Map<String, dynamic> feed) {
    return BinStatusModel(
      fillLevel: double.tryParse(feed['field1'] ?? ''),
      temperature: double.tryParse(feed['field2'] ?? ''),
      latitude: double.tryParse(feed['field3'] ?? ''),
      longitude: double.tryParse(feed['field4'] ?? ''),
    );
  }
}
