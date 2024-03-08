import 'package:agriamuse/Screens/RentTools/Rent_tools.dart';
import 'package:agriamuse/Screens/SmartConnect/smart_connect.dart';
import 'package:agriamuse/Screens/home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Flutter code sample for [NavigationBar].

void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NavigationExample());
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.green[800],
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(FontAwesomeIcons.toolbox),
            label: 'Rent Tools',
          ),
          NavigationDestination(
            selectedIcon: Icon(FontAwesomeIcons.tree),
            icon: Icon(Icons.school_outlined),
            label: 'Sell Crops',
          ),
        ],
      ),
      body: <Widget>[
        Container(
          color: Colors.red,
          alignment: Alignment.center,
          child: MyHomePage(),
        ),
        Container(
          color: Colors.green,
          alignment: Alignment.center,
          child: RentTools(),
        ),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: Crops(),
        ),
      ][currentPageIndex],
    );
  }
}
