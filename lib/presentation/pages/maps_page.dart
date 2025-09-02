import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:scooter_app/data/model/scooter_model.dart';

class MapsPage extends StatefulWidget {
  final ScooterModel scooter;
  const MapsPage({super.key, required this.scooter});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late GoogleMapController _controller;
  LocationData? currentLocation;
  final Location location = Location();

  final LatLng scooterPosition = const LatLng(51.5074, -0.1278); // London
  List<LatLng> polylineCoordinates = [];
  final Set<Polyline> _polylines = {};
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    currentLocation = await location.getLocation();

    setState(() {
      _markers.add(Marker(
        markerId: const MarkerId('scooter'),
        position: scooterPosition,
        infoWindow: InfoWindow(title: widget.scooter.name),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ));

      _markers.add(Marker(
        markerId: const MarkerId('user'),
        position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ));
    });
  }

  void getDirections() async {
    if (currentLocation == null) return;

    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "your api key", // 🟡 Replace with your actual API key
      PointLatLng(currentLocation!.latitude!, currentLocation!.longitude!),
      PointLatLng(scooterPosition.latitude, scooterPosition.longitude),
    );

    if (result.points.isNotEmpty) {
      polylineCoordinates.clear();
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      _polylines.clear();
      _polylines.add(Polyline(
        polylineId: const PolylineId("route"),
        points: polylineCoordinates,
        color: Colors.blue,
        width: 5,
      ));

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentLocation == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Scooter Location", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
              zoom: 14,
            ),
            onMapCreated: (controller) => _controller = controller,
            markers: _markers,
            polylines: _polylines,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: carDetailsWidget(),
          ),
            Positioned(
            right: 20,
            bottom: 188,
            child: Image.asset(
              widget.scooter.imageUrl,
              width: 150,
              height: 130,
            ),
          ),
        ],
      ),
    );
  }

  Widget carDetailsWidget() {
    return SizedBox(
      height: 260,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(widget.scooter.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                featureIcons(),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: getDirections,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    child: const Text("Start Navigation",
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                  ),
                ),
              ],
            ),
          ),
        
        ],
      ),
    );
  }

  Widget featureIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        featureIcon('assets/icons/battery.png', 'Battery', '${widget.scooter.batteryLevel}%'),
        featureIcon('assets/icons/road-with-broken-line.png', 'Distance', '${widget.scooter.distanceCovered}km'),
        featureIcon('assets/icons/speedometer.png', 'Speed', widget.scooter.speed),
      ],
    );
  }

  Widget featureIcon(String icon, String title, String value) {
    return Column(
      children: [
        Image.asset(icon, width: 30, height: 30),
        const SizedBox(height: 5),
        Text(title, style: const TextStyle(color: Colors.white)),
        Text(value, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}

