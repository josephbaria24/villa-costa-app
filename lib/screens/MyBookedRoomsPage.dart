// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class MyBookedRoomsPage extends StatefulWidget {
  const MyBookedRoomsPage({super.key});

  @override
  State<MyBookedRoomsPage> createState() => _MyBookedRoomsPageState();
}

class BookingInfo {
  final DateTime date;
  final String hotelName;
  final int guests;
  final String hotelId;

  BookingInfo({
    required this.date,
    required this.hotelName,
    required this.guests,
    required this.hotelId,
  });
}

class HotelBookingGroup {
  final String hotelName;
  final String hotelId;
  final int guests;
  final List<DateTime> checkInDates;
  bool isExpanded;

  HotelBookingGroup({
    required this.hotelName,
    required this.hotelId,
    required this.guests,
    required this.checkInDates,
    this.isExpanded = false,
  });
}

class _MyBookedRoomsPageState extends State<MyBookedRoomsPage> {
  List<HotelBookingGroup> hotelGroups = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    setState(() {
      isLoading = true;
    });
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final allKeys = prefs.getKeys();
      
      List<BookingInfo> loadedBookings = [];
      
      // Process all booking keys
      for (String key in allKeys) {
        if (key.startsWith('booking_')) {
          final bookingString = prefs.getString(key);
          final hotelId = key.replaceFirst('booking_', '');
          
          if (bookingString != null) {
            try {
              // Try the more structured approach with better regex
              final datesMatch = RegExp(r"dates:\s*\[(.*?)\]").firstMatch(bookingString);
              final hotelNameMatch = RegExp(r"hotelName:\s*(.*?)(?:,|}|\))").firstMatch(bookingString);
              final guestsMatch = RegExp(r"guests:\s*(\d+)").firstMatch(bookingString);
              
              if (datesMatch != null && hotelNameMatch != null && guestsMatch != null) {
                String datesPart = datesMatch.group(1) ?? "";
                String hotelName = hotelNameMatch.group(1) ?? "Unknown Hotel";
                String guestsStr = guestsMatch.group(1) ?? "1";
                
                // Clean quotes if present around hotel name
                hotelName = hotelName.trim();
                if (hotelName.startsWith('"') && hotelName.endsWith('"')) {
                  hotelName = hotelName.substring(1, hotelName.length - 1);
                }
                
                // Handle dates
                List<String> dateStrings = [];
                if (datesPart.contains(",")) {
                  dateStrings = datesPart.split(",");
                } else {
                  dateStrings = [datesPart];
                }
                
                for (String dateStr in dateStrings) {
                  try {
                    final date = DateTime.parse(dateStr.trim());
                    loadedBookings.add(BookingInfo(
                      date: date,
                      hotelName: hotelName,
                      guests: int.tryParse(guestsStr) ?? 1,
                      hotelId: hotelId,
                    ));
                  } catch (e) {
                    print("Error parsing date: $dateStr - $e");
                  }
                }
              }
            } catch (e) {
              print("Error processing booking: $e");
            }
          }
        }
      }
      
      // Group bookings by hotel name
      Map<String, HotelBookingGroup> groupedBookings = {};
      
      for (var booking in loadedBookings) {
        if (groupedBookings.containsKey(booking.hotelName)) {
          groupedBookings[booking.hotelName]!.checkInDates.add(booking.date);
        } else {
          groupedBookings[booking.hotelName] = HotelBookingGroup(
            hotelName: booking.hotelName,
            hotelId: booking.hotelId,
            guests: booking.guests,
            checkInDates: [booking.date],
          );
        }
      }
      
      // Convert to list and sort each group's dates
      List<HotelBookingGroup> groups = groupedBookings.values.toList();
      for (var group in groups) {
        group.checkInDates.sort(); // Sort dates within each group
      }
      
      // Sort groups by the earliest check-in date
      groups.sort((a, b) {
        if (a.checkInDates.isEmpty) return 1;
        if (b.checkInDates.isEmpty) return -1;
        return a.checkInDates.first.compareTo(b.checkInDates.first);
      });
      
      setState(() {
        hotelGroups = groups;
        isLoading = false;
      });
    } catch (e) {
      print("Error loading bookings: $e");
      setState(() {
        isLoading = false;
      });
    }
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('My Booked Rooms'),
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    body: isLoading
        ? Center(child: CircularProgressIndicator())
        : hotelGroups.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.hotel_outlined, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text('No bookings yet', style: TextStyle(fontSize: 18, color: Colors.grey[700])),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _loadBookings,
                      child: Text('Refresh'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            : RefreshIndicator(
                onRefresh: _loadBookings,
                child: ListView.builder(
                  itemCount: hotelGroups.length,
                  itemBuilder: (context, index) {
                    final group = hotelGroups[index];

                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ExpansionTile(
                        leading: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.hotel, color: Colors.black),
                        ),
                        title: Text(group.hotelName, style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          '${group.checkInDates.length} booking(s) · ${group.guests} guest(s)',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        initiallyExpanded: group.isExpanded,
                        onExpansionChanged: (expanded) {
                          setState(() {
                            group.isExpanded = expanded;
                          });
                        },
                        children: [
                          // Show check-in dates
                          ...group.checkInDates.map((date) {
                            final formattedDate = DateFormat('EEEE, MMMM d, y').format(date);
                            return Column(
                              children: [
                                ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Icon(Icons.calendar_today, size: 20),
                                  ),
                                  title: Text('Check-in: $formattedDate', style: TextStyle(fontSize: 14)),
                                ),
                                Divider(height: 1, indent: 72),
                              ],
                            );
                          }).toList(),

                          Divider(thickness: 1),

                          // Rating and feedback section
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                            child: StatefulBuilder(
                              builder: (context, setInnerState) {
                                double currentRating = 0;
                                TextEditingController feedbackController = TextEditingController();

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Rate Your Stay:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                    SizedBox(height: 8),
                                    RatingBar.builder(
                                      initialRating: currentRating,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 30,
                                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
                                      onRatingUpdate: (rating) {
                                        setInnerState(() {
                                          currentRating = rating;
                                        });
                                      },
                                    ),
                                    SizedBox(height: 16),
                                    TextField(
                                      controller: feedbackController,
                                      maxLines: 3,
                                      decoration: InputDecoration(
                                        labelText: 'Suggestions or Recommendations',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Handle feedback submission
                                          print('Rating: $currentRating');
                                          print('Feedback: ${feedbackController.text}');
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('Thank you for your feedback!')),
                                          );
                                        },
                                        child: Text('Submit'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          foregroundColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),

                          // Actions: View Details and Cancel
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // TODO: View details logic
                                  },
                                  child: Text('View Details'),
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.black,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    // Show confirmation dialog
                                    final shouldCancel = await showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Cancel Booking'),
                                        content: Text('Are you sure you want to cancel this booking?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, false),
                                            child: Text('No'),
                                            style: TextButton.styleFrom(foregroundColor: Colors.black),
                                          ),
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, true),
                                            child: Text('Yes'),
                                            style: TextButton.styleFrom(foregroundColor: Colors.red),
                                          ),
                                        ],
                                      ),
                                    ) ?? false;

                                    // If confirmed, delete the booking
                                    if (shouldCancel) {
                                      _cancelBooking(index);
                                    }
                                  },
                                  child: Text('Cancel'),
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
  );
}

Future<void> _cancelBooking(int index) async {
  try {
    setState(() {
      isLoading = true;
    });

    // Clear all locally saved booking data
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('bookings');     // if you stored full bookings
    await prefs.remove('bookingIds');   // if you also store booking IDs

    // Clear UI list
    hotelGroups.clear();

    // Show feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('All bookings cancelled successfully'),
        backgroundColor: Colors.green,
      ),
    );
  } catch (e) {
    print('Error cancelling bookings: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to cancel bookings.'),
        backgroundColor: Colors.red,
      ),
    );
  } finally {
    setState(() {
      isLoading = false;
    });
  }
}
}