import 'package:flutter/material.dart';
import 'package:scooter_app/bottom_navigation.dart';
import 'package:scooter_app/data/model/scooter_model.dart';
import 'package:scooter_app/main.dart';
import 'package:scooter_app/presentation/pages/home_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          SizedBox(
            height: 60,
          ),
          Center(
              child: Image.asset(
            'assets/icons/Logo (1).png',
            height: 50,
          )),
          const SizedBox(
            height: 20,
          ),
          Center(child: Image.asset('assets/images/scooter_onboard.png')),
          const SizedBox(
            height: 30,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Rent an ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Electric Scooter',
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: 200, // decreased width
            height: 70, // optional: adjust height as needed
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const BottomNav()  ));
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: Colors.yellow,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 20, // optional: reduce icon size to fit better
                    ),
                  ),
                  const SizedBox(width: 8), // smaller spacing
                  const Text(
                    'Start',
                    style: TextStyle(color: Colors.black, fontSize: 21),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
