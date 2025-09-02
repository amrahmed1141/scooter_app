import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:scooter_app/presentation/pages/home_screen.dart';
import 'package:scooter_app/presentation/pages/profile_page.dart';
import 'package:scooter_app/presentation/pages/rents_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  late List<Widget> _pages;
  late HomeScreen homeScreen;
  late RentsPage rentsPage;
  late ProfilePage profilePage;
  
  @override
  void initState() {
    homeScreen = const HomeScreen();
    rentsPage = const RentsPage();
    profilePage = const ProfilePage();
    _pages = [homeScreen, rentsPage, profilePage];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        items: const [
          Icon(Icons.home_outlined, size: 30, color: Colors.white),
          Icon(Icons.pedal_bike_outlined, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        backgroundColor: Colors.transparent,
        color: Colors.black,
        animationDuration: const Duration(milliseconds: 400),
        height: 60,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
      body: _pages[_selectedIndex],
    );
  }
}
