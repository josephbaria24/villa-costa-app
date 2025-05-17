// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dashboard.dart'; // for HotelModel

class DatePreferencesPage extends StatefulWidget {
  final HotelModel hotel;
  final int nightCount;

  const DatePreferencesPage({
    super.key,
    required this.hotel,
    required this.nightCount,
  });

  @override
  State<DatePreferencesPage> createState() => _DatePreferencesPageState();
}


class _DatePreferencesPageState extends State<DatePreferencesPage> {


  @override
void initState() {
  super.initState();
  _loadBookedDates();
}


Future<void> _loadBookedDates() async {
  final prefs = await SharedPreferences.getInstance();
  final storedDates = prefs.getStringList('booked_dates') ?? [];

  setState(() {
    bookedDates = storedDates.map((dateStr) => DateTime.parse(dateStr)).toSet();
  });
}

Future<void> _saveBookedDates() async {
  final prefs = await SharedPreferences.getInstance();
  final dateStrings = bookedDates.map((date) => date.toIso8601String()).toList();
  await prefs.setStringList('booked_dates', dateStrings);
}



  DateTime selectedDate = DateTime.now();
  String selectedTime = '10:00 AM';
  int guestCount = 1;

  final List<String> timeSlots = [
    '9:00 AM', '10:00 AM', '11:00 AM', '12:00 PM',
    '1:00 PM', '2:00 PM', '3:00 PM', '4:00 PM'
  ];
  Set<DateTime> bookedDates = {}; // 👈 Holds booked dates


  @override
  Widget build(BuildContext context) {
    final totalPrice = widget.hotel.price * widget.nightCount;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
  final formattedDate = DateFormat('MMMM d, y').format(selectedDate);

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(Icons.check_circle, color: Colors.green, size: 48),
              ),
              SizedBox(height: 16),
              Center(
                child: Text(
                  'Confirm Booking',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.hotel, size: 20),
                  SizedBox(width: 8),
                  Expanded(child: Text('Hotel: ${widget.hotel.name}')),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 20),
                  SizedBox(width: 8),
                  Text('Date: $formattedDate'),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.access_time, size: 20),
                  SizedBox(width: 8),
                  Text('Time: $selectedTime'),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.person, size: 20),
                  SizedBox(width: 8),
                  Text('Guests: $guestCount'),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.nights_stay, size: 20),
                  SizedBox(width: 8),
                  Text('Nights: ${widget.nightCount}'),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.attach_money, size: 20),
                  SizedBox(width: 8),
                  Text('Total: ₱${NumberFormat('#,##0').format(widget.hotel.price * widget.nightCount)}'),
                ],
              ),

              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        final List<DateTime> bookedRange = List.generate(
                          widget.nightCount,
                          (i) => selectedDate.add(Duration(days: i)),
                        );

                        // Check if any date in the range is already booked
                        bool isAlreadyBooked = bookedRange.any((date) =>
                          bookedDates.any((bookedDate) => isSameDay(bookedDate, date)),
                        );

                        if (isAlreadyBooked) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Selected date range is already booked!'),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        // Proceed with booking
                        setState(() {
                          bookedDates.addAll(bookedRange);
                        });

                        _saveBookedDates();

                        Navigator.pop(context); // ✅ Dismiss the confirmation dialog

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Booking confirmed!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Text('Confirm'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                    ),

                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },

        label: Text('Book Now - ₱${NumberFormat('#,##0').format(totalPrice)}'),
        icon: Icon(Icons.check),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Custom Back Button
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.arrow_back_ios_new_outlined, size: 17),
                      ),
                    ),
                    SizedBox(width: 60,),

                    Text("Date & Preferences", style: 
                    TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),)
                  ],
                ),
                SizedBox(height: 20),

                Text('Nights: ${widget.nightCount}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),

                // 📅 Inline Calendar Picker
                Text('Select Date:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:  Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TableCalendar(
        focusedDay: selectedDate,
        firstDay: DateTime.now(),
        lastDay: DateTime.now().add(Duration(days: 365)),
        selectedDayPredicate: (day) => isSameDay(day, selectedDate),
        onDaySelected: (day, _) {
          setState(() {
            selectedDate = day;
          });
        },
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            final isBooked = bookedDates.any((d) => isSameDay(d, day));
            return Container(
              margin: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isBooked ? Colors.red[300] : null,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                '${day.day}',
                style: TextStyle(
                  color: isBooked ? Colors.white : Colors.black,
                ),
              ),
            );
          },
        ),
      ),
    ),
                ),
                SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: timeSlots.map((time) {
                      final isSelected = time == selectedTime;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTime = time;
                          });
                        },
                        child: Container(
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.black : Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? Colors.transparent : Colors.grey, // Add grey border when not selected
                                width: 0.5,
                              ),
                            ),
                            child: Text(
                              time,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),

                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 16),

                // 👥 Number of Guests
                Text('Number of Guests:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(20, (index) {
                      final count = index + 1;
                      final isSelected = guestCount == count;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            guestCount = count;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.black : Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '$count',
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
