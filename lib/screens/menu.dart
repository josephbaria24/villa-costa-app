// lib/components/app_drawer.dart
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback onToggleDarkMode;
  final bool isDarkMode;

  const AppDrawer({
    Key? key,
    required this.onToggleDarkMode,
    required this.isDarkMode,
  }) : super(key: key);

 @override
Widget build(BuildContext context) {
  return Drawer(
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Color(0xFFFFE0B2), // peach
            Color(0xFFFFF176), // yellow
          ],
          stops: [0.7, 1, 1.0], // make it subtle and biased to bottom right
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 70),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: SvgPicture.asset('lib/assets/icons/person.svg', color: Colors.black, width: 24),
              title: Text('Profile', style: TextStyle(fontWeight: FontWeight.w600)),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: SvgPicture.asset('lib/assets/icons/settings.svg', color: Colors.black),
              title: Text('Settings', style: TextStyle(fontWeight: FontWeight.w600)),
              onTap: () => Navigator.pop(context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.dark_mode_outlined, color: Colors.black),
                      SizedBox(width: 16),
                      Text('Dark Mode', style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  FlutterSwitch(
                    width: 50.0,
                    height: 28.0,
                    toggleSize: 24.0,
                    value: isDarkMode,
                    borderRadius: 30.0,
                    padding: 4.0,
                    activeColor: const Color.fromARGB(255, 5, 208, 223),
                    inactiveColor: Colors.grey.shade300,
                    onToggle: (val) => onToggleDarkMode(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}
