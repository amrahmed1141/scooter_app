import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:scooter_app/data/model/scooter_model.dart';

class ScootersLocalData {
  List<ScooterModel> getScooters() {
    return [
      ScooterModel(
    batteryLevel: 80.0,
    distanceCovered: 16.0,
    speed: '25 km/h',
    id: 's_1',
    name: 'City Cruiser',
    imageUrl: 'assets/images/image 4.png',
    pricePerHour: 5.0, color:Colors.cyan),

  ScooterModel(
     batteryLevel: 95.0,
    distanceCovered: 10.0,
    speed: '60 km/h',
    id: 's_2',
    name: 'Speedster',
    imageUrl: 'assets/images/White Scooter (1).png',
    pricePerHour: 6.5, color: Colors.red),

  ScooterModel(
     batteryLevel: 65.0,
    distanceCovered: 10.0,
    speed: '80 km/h',
    id: 's_3',
    name: 'Eco Ride',
    imageUrl: 'assets/images/Rectangle 4.png',
    pricePerHour: 4.0, color: Colors.yellow,
  ),
  ScooterModel(
     batteryLevel: 75.0,
    distanceCovered: 5.0,
    speed: '40 km/h',
    id: 's_4',
    name: 'Urban Glide',
    imageUrl: 'assets/images/scooter_onboard.png',
    pricePerHour: 7.0, color: Colors.green,
  ),
  ScooterModel(
     batteryLevel: 70.0,
    distanceCovered: 13.0,
    speed: '50 km/h',
    id: 's_5',
    name: 'Night Rider',
    imageUrl: 'assets/images/image 7.png',
    pricePerHour: 8.0, color: Colors.purple,
  ),
  ScooterModel(
     batteryLevel: 97.0,
    distanceCovered: 12.0,
    speed: '100 km/h',
    id: 's_6',
    name: 'Adventure Pro',
    imageUrl: 'assets/images/Bike.png',
    pricePerHour: 9.0, color: Colors.orange,
  ),
    ];
  }
}
