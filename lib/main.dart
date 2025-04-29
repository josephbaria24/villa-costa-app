// ignore_for_file: prefer_const_constructors

import 'package:fitness_tracker/components/add_note_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/dashboard.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('notesBox');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Binx Note',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'MyFont', // <- this sets the global font
        ),
      home: const Dashboard(),
      routes: {
        '/addNote': (context) => const AddNotePage(),
      }
    );
  }
}
