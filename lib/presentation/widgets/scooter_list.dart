import 'package:flutter/material.dart';
import 'package:scooter_app/application/cubit/scooters_cubit.dart';
import 'package:scooter_app/data/model/scooter_model.dart';
import 'package:scooter_app/presentation/pages/details_page.dart';
import 'package:scooter_app/presentation/widgets/scooter_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScooterList extends StatefulWidget {
  final List <ScooterModel> scooter;
  const ScooterList({super.key, required this.scooter});

  @override
  State<ScooterList> createState() => _ScooterListState();
}

class _ScooterListState extends State<ScooterList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
            itemCount: widget.scooter.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(6),
                child: GestureDetector(
                  onTap: () {
                    context.read<ScooterCubit>().selectScooter(widget.scooter[index]);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                               const DetailScreen()));
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: widget.scooter[index].color,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Hero(
                              tag: 'scooter_image_${widget.scooter[index].id}',
                              flightShuttleBuilder: (
                                BuildContext flightContext,
                                Animation<double> animation,
                                HeroFlightDirection flightDirection,
                                BuildContext fromHeroContext,
                                BuildContext toHeroContext,
                              ) {
                                return Image.asset(
                                  widget.scooter[index].imageUrl,
                                  height: 140,
                                  width: 110,
                                  fit: BoxFit.contain,
                                );
                              },
                              child: Image.asset(
                                widget.scooter[index].imageUrl,
                                height: 140,
                                width: 110,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  widget.scooter[index].name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'Rent this scooter for your next ride!',
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 14),
                                ),
                                Text(
                                  '\€${widget.scooter[index].pricePerHour}/hour',
                                  style: const TextStyle(
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
                            ScooterDetails(
                              batteryLevel: widget.scooter[index].batteryLevel,
                              distanceCovered: widget.scooter[index].distanceCovered,
                              speed: widget.scooter[index].speed,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
  }
}
