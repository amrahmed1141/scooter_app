import 'dart:ui';

class ScooterModel {
  final String id;
  final String name;
  final String imageUrl;
  final Color color;
  final double pricePerHour;
  final double batteryLevel;
  final double distanceCovered;
  final String speed;

  ScooterModel( {
    required this.color,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.pricePerHour,
    required this.batteryLevel,
    required this.distanceCovered,
    required this.speed,
  });
}
