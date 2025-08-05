import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:scooter_app/data/model/scooter_model.dart';

class MapsPage extends StatefulWidget {
  final ScooterModel scooter;
  const MapsPage({super.key, required this.scooter});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Scooter location',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(51.0, -0.09), // 📍 London
              initialZoom: 10,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=iA8VSX507oUvhGC0NJhg",
                userAgentPackageName: 'com.example.scooter_app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                      point: const LatLng(51.5074, -0.1278), // London center
                      width: 40,
                      height: 40,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.asset(widget.scooter.imageUrl,
                            width: 50, height: 50),
                      )),
                  Marker(
                      point: const LatLng(
                          51.509865, -0.118092), // Near Covent Garden
                      width: 40,
                      height: 40,
                      child: Image.asset('assets/images/White Scooter (1).png',
                          width: 40, height: 40)),
                  Marker(
                      point: const LatLng(51.5007, -0.1246), // Westminster
                      width: 40,
                      height: 40,
                      child: Image.asset('assets/images/image 13.png',
                          width: 40, height: 40)),
                ],
              ),
            ],
          ),
          Positioned(left: 0, bottom: 0, right: 0, child: carDetailsWidget()),
        ],
      ),
    );
  }

  Widget carDetailsWidget() {
    return SizedBox(
      height: 350,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.white38, spreadRadius: 0, blurRadius: 10)
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.scooter.name,
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Features',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    featureIcons(),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              )),
          Positioned(
              right: 20,
              top: 20,
              child: Image.asset(
                widget.scooter.imageUrl,
                width: 150,
                height: 150,
              ))
        ],
      ),
    );
  }

  Widget featureIcon(String image, String title, String subtitle) {
    return Container(
      width: 100,
      height: 100,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 1)),
      child: Column(
        children: [
          Image.asset(
            image,
            height: 30,
            width: 30,
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.grey, fontSize: 10),
          )
        ],
      ),
    );
  }

  Widget featureIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        featureIcon('assets/icons/battery.png', 'percentage',
            widget.scooter.batteryLevel.toString()),
        featureIcon('assets/icons/road-with-broken-line.png', 'Acceleration',
            widget.scooter.distanceCovered.toString()),
        featureIcon(
            'assets/icons/speedometer.png', 'Cold', widget.scooter.speed),
      ],
    );
  }
}
