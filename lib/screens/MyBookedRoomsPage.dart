// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, sort_child_properties_last

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:villa_costa/data/room_data.dart';

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
    backgroundColor: Colors.white,
    appBar: AppBar(
      leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 18),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      scrolledUnderElevation: 0,
      title: Text('My Booked Rooms', style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold
      ),),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    body: isLoading
        ? Center(child: CircularProgressIndicator())
        : hotelGroups.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('lib/assets/icons/empty.json', width: 150),
                    SizedBox(height: 16),
                    Text('No bookings yet', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[700])),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _loadBookings,
                      child: Text('Refresh'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 100,)
                  ],
                ),
              )
            : RefreshIndicator(
                onRefresh: _loadBookings,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: hotelGroups.length,
                  itemBuilder: (context, index) {
                    final group = hotelGroups[index];

                    return AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      margin: EdgeInsets.symmetric(
                        horizontal: 16, 
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Material(
                          color: Colors.transparent,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              dividerColor: Colors.transparent,
                            ),
                            child: ExpansionTile(
                              expandedCrossAxisAlignment: CrossAxisAlignment.start,
                              expandedAlignment: Alignment.centerLeft,
                              tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                              childrenPadding: EdgeInsets.zero,
                              leading: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 253, 253, 253),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(Icons.hotel, color: Colors.black),
                              ),
                              title: Text(
                                group.hotelName, 
                                style: TextStyle(fontWeight: FontWeight.bold)
                              ),
                              subtitle: Text(
                                '${group.checkInDates.length} booking(s) · ${group.guests} guest(s)',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              initiallyExpanded: group.isExpanded,
                              onExpansionChanged: (expanded) {
                                setState(() {
                                  // Close all other groups when opening this one
                                  if (expanded) {
                                    for (var otherGroup in hotelGroups) {
                                      if (otherGroup != group) {
                                        otherGroup.isExpanded = false;
                                      }
                                    }
                                  }
                                  group.isExpanded = expanded;
                                });
                              },
                              // Custom trailing animation for the expansion arrow
                              trailing: AnimatedRotation(
                                turns: group.isExpanded ? 0.5 : 0.0,
                                duration: Duration(milliseconds: 300),
                                child: Icon(Icons.keyboard_arrow_down),
                              ),
                              children: [
                                AnimatedSize(
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.easeOutQuart,
                                  child: AnimatedOpacity(
                                    opacity: group.isExpanded ? 1.0 : 0.0,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        // Show check-in dates
                                        ...group.checkInDates.asMap().entries.map((entry) {
                                          final index = entry.key;
                                          final date = entry.value;
                                          final formattedDate = DateFormat('EEEE, MMMM d, y').format(date);
                                          
                                          return AnimatedSlide(
                                            offset: Offset(0, group.isExpanded ? 0 : 0.2),
                                            duration: Duration(milliseconds: 300 + (index * 50)),
                                            curve: Curves.easeOutCubic,
                                            child: AnimatedOpacity(
                                              opacity: group.isExpanded ? 1.0 : 0.0,
                                              duration: Duration(milliseconds: 300 + (index * 50)),
                                              curve: Curves.easeIn,
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    leading: Padding(
                                                      padding: const EdgeInsets.only(left: 16.0),
                                                      child: Icon(Icons.calendar_today, size: 20),
                                                    ),
                                                    title: Text('Check-in: $formattedDate', 
                                                      style: TextStyle(fontSize: 14)),
                                                  ),
                                                  Divider(height: 1, indent: 72),
                                                ],
                                              ),
                                            ),
                                          );
                                        }).toList(),

                                        Divider(thickness: 1),

                                        // Rating and feedback section with staggered animation
                                        AnimatedSlide(
                                          offset: Offset(0, group.isExpanded ? 0 : 0.2),
                                          duration: Duration(milliseconds: 400),
                                          curve: Curves.easeOutCubic,
                                          child: AnimatedOpacity(
                                            opacity: group.isExpanded ? 1.0 : 0.0,
                                            duration: Duration(milliseconds: 400),
                                            curve: Curves.easeIn,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                                              child: StatefulBuilder(
                                                builder: (context, setInnerState) {
                                                  double currentRating = 0;
                                                  TextEditingController feedbackController = TextEditingController();

                                                  return Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('Rate Your Stay:', 
                                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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
                                                          border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(8),
                                                            borderSide: BorderSide(color: Colors.black, width: 2),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 12),
                                                      Align(
                                                        alignment: Alignment.centerRight,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            print('Rating: $currentRating');
                                                            print('Feedback: ${feedbackController.text}');
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              SnackBar(
                                                                behavior: SnackBarBehavior.floating,
                                                                margin: EdgeInsets.all(8),
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(8),
                                                                ),
                                                                content: Text('Thank you for your feedback!'),
                                                              ),
                                                            );
                                                          },
                                                          child: Text('Submit'),
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: Colors.black,
                                                            foregroundColor: Colors.white,
                                                            elevation: 2,
                                                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),

                                        // Actions: View Details and Cancel with staggered animation
                                        AnimatedSlide(
                                          offset: Offset(0, group.isExpanded ? 0 : 0.2),
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.easeOutCubic,
                                          child: AnimatedOpacity(
                                            opacity: group.isExpanded ? 1.0 : 0.0,
                                            duration: Duration(milliseconds: 500),
                                            curve: Curves.easeIn,
                                            child: Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  TextButton.icon(
                                                    icon: Icon(Icons.info_outline, size: 18),
                                                    onPressed: () {
                                                      // TODO: View details logic
                                                    },
                                                    label: Text('View Details'),
                                                    style: TextButton.styleFrom(
                                                      foregroundColor: Colors.black,
                                                    ),
                                                  ),
                                                  TextButton.icon(
                                                    icon: Icon(Icons.cancel_outlined, size: 18),
                                                    onPressed: () async {
                                                      final shouldCancel = await showDialog<bool>(
                                                        context: context,
                                                        barrierDismissible: false,
                                                        builder: (context) => AlertDialog(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(16),
                                                          ),
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

                                                      if (shouldCancel) {
                                                        _deleteAllBookings();
                                                      }
                                                    },
                                                    label: Text('Cancel'),
                                                    style: TextButton.styleFrom(
                                                      foregroundColor: Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
  );
}





// Future<void> _cancelBooking(int index) async {
//   try {
//     setState(() {
//       isLoading = true;
//     });

//     // Clear all locally saved booking data
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('bookings');     // if you stored full bookings
//     await prefs.remove('bookingIds');   // if you also store booking IDs

//     // Clear UI list
//     hotelGroups.clear();

//     // Show feedback
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('All bookings cancelled successfully'),
//         backgroundColor: Colors.green,
//       ),
//     );
//   } catch (e) {
//     print('Error cancelling bookings: $e');
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Failed to cancel bookings.'),
//         backgroundColor: Colors.red,
//       ),
//     );
//   } finally {
//     setState(() {
//       isLoading = false;
//     });
//   }
// }




/// Deletes a booking from SharedPreferences by hotel ID
Future<bool> _deleteBooking(String hotelId) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    
    // Check if the booking exists
    final bookingKey = 'booking_$hotelId';
    final exists = prefs.containsKey(bookingKey);
    
    if (!exists) {
      print('Booking for hotel ID $hotelId not found');
      return false;
    }
    
    // Optional: Get the booking data for logging before deletion
    final bookingData = prefs.getString(bookingKey);
    
    // Delete the booking data
    final result = await prefs.remove(bookingKey);
    
    if (result) {
      print('Successfully deleted booking for hotel ID $hotelId: $bookingData');
    } else {
      print('Failed to delete booking for hotel ID $hotelId');
    }
    
    return result;
  } catch (e) {
    print('Error deleting booking: $e');
    return false;
  }
}

/// Delete all bookings for a specific hotel
Future<void> _deleteAllBookingsForHotel(String hotelId) async {
  final result = await _deleteBooking(hotelId);
  if (result) {
    // You might want to update UI or notify the user here
    setState(() {
      // Refresh the hotel groups if you're maintaining them in state
      _loadBookings(); // Assuming you have this method to reload bookings
    });
  }
}

/// Delete a specific booking from a hotel on a specific date
Future<bool> _deleteSpecificBooking(String hotelId, DateTime bookingDate) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final bookingKey = 'booking_$hotelId';
    
    if (!prefs.containsKey(bookingKey)) {
      return false;
    }
    
    // Get the current booking data
    final bookingString = prefs.getString(bookingKey);
    if (bookingString == null) {
      return false;
    }
    
    // Extract the date strings from the stored format
    // This is a basic parser for the format used in _saveBookedDates
    final datePattern = RegExp(r'dates: \[(.*?)\]');
    final datesMatch = datePattern.firstMatch(bookingString);
    
    if (datesMatch == null || datesMatch.groupCount < 1) {
      return false;
    }
    
    // Extract other booking information
    final guestPattern = RegExp(r'guests: (\d+)');
    final hotelNamePattern = RegExp(r'hotelName: (.*?)(?:}|$)');
    
    final guestsMatch = guestPattern.firstMatch(bookingString);
    final hotelNameMatch = hotelNamePattern.firstMatch(bookingString);
    
    final int guestCount = guestsMatch != null ? int.parse(guestsMatch.group(1) ?? '0') : 0;
    final String hotelName = hotelNameMatch != null ? hotelNameMatch.group(1) ?? '' : '';
    
    // Parse the dates
    final dateStrings = datesMatch.group(1)?.split(', ') ?? [];
    final dates = dateStrings.map((dateStr) => DateTime.parse(dateStr.trim())).toList();
    
    // Remove the specific date
    final dateToRemoveString = bookingDate.toIso8601String();
    dates.removeWhere((date) => date.toIso8601String() == dateToRemoveString);
    
    // If there are no more dates, delete the entire booking
    if (dates.isEmpty) {
      return await _deleteBooking(hotelId);
    }
    
    // Otherwise, save the updated dates list
    final updatedDateStrings = dates.map((date) => date.toIso8601String()).toList();
    final updatedBookingString = '{dates: [${updatedDateStrings.join(", ")}], guests: $guestCount, hotelName: $hotelName}';
    
    await prefs.setString(bookingKey, updatedBookingString);
    print('Updated booking after removing date $bookingDate: $updatedBookingString');
    
    return true;
  } catch (e) {
    print('Error deleting specific booking: $e');
    return false;
  }
}

/// Delete all bookings from SharedPreferences
Future<void> _deleteAllBookings() async {
  try {
    final prefs = await SharedPreferences.getInstance();

    // Get all keys that start with 'booking_'
    final allKeys = prefs.getKeys();
    final bookingKeys = allKeys.where((key) => key.startsWith('booking_')).toList();

    if (bookingKeys.isEmpty) {
      print('No bookings found to delete');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No bookings to delete')),
      );
      return;
    }

    // Delete each booking
    bool allDeleted = true;
    for (final key in bookingKeys) {
      final result = await prefs.remove(key);
      if (!result) {
        allDeleted = false;
        print('Failed to delete booking with key: $key');
      }
    }

    print('Deleted ${bookingKeys.length} bookings. All successful: $allDeleted');

    // Auto refresh bookings list
    await _loadBookings();

    // Show result message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(allDeleted
            ? 'All bookings canceled successfully'
            : 'Some bookings could not be deleted'),
        backgroundColor: allDeleted ? Colors.green : Colors.orange,
      ),
    );
  } catch (e) {
    print('Error deleting all bookings: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error deleting bookings'),
        backgroundColor: Colors.red,
      ),
    );
  }
}



}