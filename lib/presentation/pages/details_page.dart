import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scooter_app/application/cubit/scooters_cubit.dart';
import 'package:scooter_app/application/cubit/scooters_state.dart';
import 'package:scooter_app/data/model/scooter_model.dart';
import 'package:scooter_app/data/model/time.dart';
import 'package:scooter_app/presentation/pages/maps_page.dart';
import 'package:scooter_app/presentation/widgets/scooter_details.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _animation = Tween<double>(begin: 1.5, end: 1.0).animate(_controller!)
      ..addListener(() {
        setState(() {});
      });
    _controller!.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScooterCubit, ScootersState>(
      builder: (context, state) {
        if (state is SelectScooter) {
          final scooter = state.scooter;

          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              leading: IconButton(
                onPressed: () {
                  context
                      .read<ScooterCubit>()
                      .resetScooterList(); // ✅ restore state
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline, color: Colors.white),
                  SizedBox(width: 10),
                  Text('Information', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  _scooterWidget(scooter),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     const Text('Scooter Location',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: () {},
                        child: const Text('view',
                            style: TextStyle(
                                color: Colors.white38,
                                fontSize: 18,
                                fontWeight: FontWeight.w400)),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  _mapWidget(context, scooter),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Pick a Time',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _timeList(),
                  const SizedBox(height: 50),
                  _rentNowButton(),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _scooterWidget(ScooterModel scooter) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: scooter.color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Hero(
                tag: 'scooter_image_${scooter.id}',
                flightShuttleBuilder: (
                  BuildContext flightContext,
                  Animation<double> animation,
                  HeroFlightDirection flightDirection,
                  BuildContext fromHeroContext,
                  BuildContext toHeroContext,
                ) {
                  return Image.asset(
                    scooter.imageUrl,
                    height: 140,
                    width: 110,
                  );
                },
                child: Image.asset(
                  scooter.imageUrl,
                  height: 140,
                  width: 110,
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    scooter.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Rent this scooter for your next ride!',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  Text(
                    '€${scooter.pricePerHour}',
                    style: const TextStyle(
                        color: Colors.yellow,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          ScooterDetails(
            batteryLevel: scooter.batteryLevel,
            distanceCovered: scooter.distanceCovered,
            speed: scooter.speed,
          ),
        ],
      ),
    );
  }

  Widget _mapWidget(BuildContext context, ScooterModel scooter) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MapsPage(scooter: scooter)),
        );
      },
      child: Container(
        width: double.infinity,
        height: 172,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: Colors.white38,
                blurRadius: 5,
                spreadRadius: 3,
                blurStyle: BlurStyle.solid)
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Transform.scale(
            scale: _animation!.value,
            alignment: Alignment.center,
            child: Image.asset('assets/images/maps.png', fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  Widget _timeList() {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: time.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                width: 90,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    time[index].time,
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _rentNowButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: MaterialButton(
          elevation: 2,
          color: Colors.yellow,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: showSuccessDialog,
          child: const Text(
            'Rent Now',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 48),
            const SizedBox(height: 16),
            const Text(
              'Rent has been successfully made!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('OK'),
            )
          ],
        ),
      ),
    );
  }
}
