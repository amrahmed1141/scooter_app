import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scooter_app/application/cubit/scooters_cubit.dart';
import 'package:scooter_app/application/cubit/scooters_state.dart';
import 'package:scooter_app/presentation/widgets/scooter_list.dart';
import 'package:scooter_app/presentation/widgets/searchbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ScooterCubit>().fetchScooters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<ScooterCubit, ScootersState>(
            builder: (context, state) {
              if (state is ScootersLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ScootersLoaded) {
                return Column(
                  children: [
                    const SizedBox(height: 70),
                    const MySearchBar(),
                    const SizedBox(height: 30),
                    Expanded(
                      child: ScooterList(scooter: state.scooters),
                    ),
                  ],
                );
              } else if (state is ScootersError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red, fontSize: 18),
                  ),
                );
              }

              // 🟡 Handle SelectScooter in case of stale state
              else if (state is SelectScooter) {
                // Just display the list again
                return Column(
                  children: [
                    const SizedBox(height: 70),
                    const MySearchBar(),
                    const SizedBox(height: 30),
                    Expanded(
                      child: ScooterList(
                          scooter: context.read<ScooterCubit>().scooters),
                    ),
                  ],
                );
              }

              return const Center(
                child: Text(
                  'No scooters available',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            },
          )),
    );
  }
}
