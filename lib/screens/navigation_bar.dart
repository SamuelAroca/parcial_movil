import 'package:flutter/material.dart';
import 'package:parcial_movil/screens/degrees.dart';
import 'package:parcial_movil/screens/physical_magnitude.dart';

class NavigationLineBar extends StatefulWidget {
  const NavigationLineBar({super.key});

  @override
  State<StatefulWidget> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationLineBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MID-TERM EXAM'),
        backgroundColor: Colors.lightBlue,
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.thermostat),
            icon: Icon(Icons.thermostat),
            label: 'Degrees',
          ),
          NavigationDestination(
            icon: Icon(Icons.rule),
            label: 'Magnitude',
          ),
        ],
      ),
      body: <Widget>[
        const Degrees(),
        const PressureConverter(),
      ][currentPageIndex],
    );
  }
}
