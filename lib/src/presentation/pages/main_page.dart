import 'package:flutter/material.dart';
import 'package:smartcast/src/config/localization/app_localizations.dart';
import 'package:smartcast/src/core/constants/app_colors.dart';
import 'package:smartcast/src/presentation/pages/home_page.dart';
import 'package:smartcast/src/presentation/pages/sensors_page.dart';
import 'package:smartcast/src/presentation/pages/profile_page.dart';
import 'package:smartcast/src/presentation/pages/alerts_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const SensorsPage(),
    const AlertsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: loc.navHome,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.sensors),
            label: loc.navSensors,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.notifications_active_outlined),
            activeIcon: const Icon(Icons.notifications_active),
            label: loc.navAlerts,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
            label: loc.navProfile,
          ),
        ],
      ),
    );
  }
}
