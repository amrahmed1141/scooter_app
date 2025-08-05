import 'package:flutter/material.dart';
import 'package:scooter_app/presentation/widgets/scooter_details.dart';

class ScooterWidget extends StatefulWidget {
  const ScooterWidget({super.key});

  @override
  State<ScooterWidget> createState() => _ScooterWidgetState();
}

class _ScooterWidgetState extends State<ScooterWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/scooter_onboard.png',
                height: 140,
                width: 110,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Electric Scooter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Rent this scooter for your next ride!',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  Text(
                    '\€15/hour',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ScooterDetails(batteryLevel: 80,distanceCovered: 10,speed: '60 km',),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Rent Now',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
