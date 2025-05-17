import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class MyBookedRoomsPage extends StatefulWidget {
  const MyBookedRoomsPage({super.key});

  @override
  State<MyBookedRoomsPage> createState() => _MyBookedRoomsPageState();
}

class _MyBookedRoomsPageState extends State<MyBookedRoomsPage> {
  List<DateTime> bookedDates = [];

  @override
  void initState() {
    super.initState();
    _loadBookedDates();
  }

  Future<void> _loadBookedDates() async {
    final prefs = await SharedPreferences.getInstance();
    final storedDates = prefs.getStringList('booked_dates') ?? [];
    final parsedDates = storedDates.map((dateStr) => DateTime.parse(dateStr)).toList();
    parsedDates.sort(); // Optional: sort chronologically

    setState(() {
      bookedDates = parsedDates;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Booked Rooms'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: bookedDates.isEmpty
          ? Center(child: Text('No bookings yet.'))
          : ListView.builder(
              itemCount: bookedDates.length,
              itemBuilder: (context, index) {
                final date = bookedDates[index];
                final formatted = DateFormat('EEEE, MMMM d, y').format(date);
                return ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text(formatted),
                  subtitle: Text('Check-in date'),
                );
              },
            ),
    );
  }
}
