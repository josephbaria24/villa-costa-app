// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:shared_preferences/shared_preferences.dart';
import 'package:villa_costa/model/facilities_model.dart';
import 'package:villa_costa/model/room_model.dart';
import 'package:villa_costa/screens/AboutUs.dart';
import 'package:villa_costa/screens/ContactUsPage.dart';
import 'package:villa_costa/screens/MyBookedRoomsPage.dart';
import 'package:villa_costa/screens/facilities_card.dart';
import 'package:villa_costa/screens/login_signup_page.dart';
import 'package:villa_costa/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:villa_costa/data/room_data.dart';
import 'package:villa_costa/screens/promos_offer_page.dart';

class HotelDashboard extends ConsumerStatefulWidget {
  const HotelDashboard({Key? key}) : super(key: key);

  @override
  _HotelDashboardState createState() => _HotelDashboardState();
}

class _HotelDashboardState extends ConsumerState<HotelDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

bool _showMessageInput = false;
final TextEditingController _messageController = TextEditingController();
final selectedFilterProvider = StateProvider<String>((ref) => 'Accommodations');

ScrollController _scrollController = ScrollController();
bool _showStickySearch = false;
@override
void initState() {
  super.initState();
  _loadUserMessages();
  _scrollController.addListener(() {
  if (_scrollController.offset > 100 && !_showStickySearch) {
    setState(() {
      _showStickySearch = true;
    });
  } else if (_scrollController.offset <= 100 && _showStickySearch) {
    setState(() {
      _showStickySearch = false;
    });
  }
});

}



void _loadUserMessages() async {
  final prefs = await SharedPreferences.getInstance();
  final savedMessages = prefs.getStringList('userMessages') ?? [];
  setState(() {
    _userMessages = savedMessages;
  });
}

void _deleteUserMessages() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('userMessages');
  setState(() {
    _userMessages.clear();
  });

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Your messages have been deleted.'),
      duration: Duration(seconds: 2),
    ),
  );
}
void _sendMessage() async {
  final message = _messageController.text.trim();
  if (message.isNotEmpty) {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userMessages.add(message);
      _messageController.clear();
    });
    prefs.setStringList('userMessages', _userMessages);

    // Optional: scroll to bottom after a short delay
    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController2.animateTo(
        _scrollController2.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }
}

List<String> _userMessages = [];
final ScrollController _scrollController2 = ScrollController();


final List<String> amenities = [
  'Parking',
  'Mobile keys',
  'Free wifi',
  'Room service',
  '24hrs Guest Reception',
  'Complimentary toilestries',
  'Breakfast',
  'Mini Bar',
  'Transportation information/Transportation Arrangements',
  'Hotel Bar',
  'Laundry services',
  'Spa & Wellness Amenities',
  'Exercise Facilities',
  'Pet Friendly Rooms',
  'Smart Televisions',
  'Dinning experience',
];

final Map<String, IconData> amenityIcons = {
  'Parking': Icons.local_parking,
  'Mobile keys': Icons.vpn_key,
  'Free wifi': Icons.wifi,
  'Room service': Icons.room_service,
  '24hrs Guest Reception': Icons.room,
  'Complimentary toilestries': Icons.soap,
  'Breakfast': Icons.free_breakfast,
  'Mini Bar': Icons.local_drink,
  'Transportation information/Transportation Arrangements': Icons.directions_bus,
  'Hotel Bar': Icons.wine_bar,
  'Laundry services': Icons.local_laundry_service,
  'Spa & Wellness Amenities': Icons.spa,
  'Exercise Facilities': Icons.fitness_center,
  'Pet Friendly Rooms': Icons.pets,
  'Smart Televisions': Icons.tv,
  'Dinning experience': Icons.restaurant,
};




@override
Widget build(BuildContext context) {
  final selectedFilter = ref.watch(selectedFilterProvider);

  return Scaffold(
    key: _scaffoldKey,
    drawer: AppDrawer(
      isDarkMode: false,
      onToggleDarkMode: () {},
    ),
    backgroundColor: Colors.white,
    floatingActionButton: FloatingActionButton(
      foregroundColor: Colors.white,
      onPressed: () {
        setState(() {
          _showMessageInput = !_showMessageInput;
        });
      },
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      child: SvgPicture.asset('lib/assets/icons/message.svg', color: Colors.white,),
    ),
    body: Stack(
      children: [
        CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              scrolledUnderElevation: 0,
              expandedHeight: 250,
              pinned: true,
              backgroundColor: const Color.fromARGB(252, 255, 255, 255),
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Stack(
  alignment: Alignment.center,
  children: [
    Row(
      children: [
        Row(
          children: [
            
            Image.asset(_showStickySearch ? 'lib/assets/images/VC-1.png' : 'lib/assets/images/VC-2.png', width: 40,),
            Text(
              "  ",
              style: TextStyle(
                color: _showStickySearch ? const Color.fromARGB(255, 248, 0, 74) : Colors.transparent,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    ),
    Padding(
      padding: const EdgeInsets.only(left: 50.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(176, 221, 220, 220),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'lib/assets/icons/sun.svg',
              width: 20,
              color: Colors.black,
            ),
            const SizedBox(width: 5),
            const Text(
              'Good day!',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ),
  ],
),

actions: [
  IconButton(
    icon: Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(176, 221, 220, 220),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: SvgPicture.asset(
              'lib/assets/icons/filter.svg',
              width: 20,
              height: 20,
              color: _showStickySearch
                  ? Colors.black
                  : const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
      ),
    ),
    onPressed: () {
      _scaffoldKey.currentState?.openDrawer();
    },
  ),
],

              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset("lib/assets/images/vc2.png", fit: BoxFit.fitHeight),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.4),
                            Colors.transparent,
                            Colors.white.withOpacity(0.5),
                            Colors.white,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.0, 0.3, 0.7, 1.0],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      right: 20,
                      bottom: 20,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            SvgPicture.asset('lib/assets/icons/searchicon.svg', width: 20,),
                 
                            SizedBox(width: 10),
                            Expanded(
                            child: TextField(
                              style: TextStyle(fontSize: 13),
                              decoration: InputDecoration(
                                hintText: 'Search rooms and facilities',
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                                isCollapsed: true, // Removes default vertical padding
                                contentPadding: EdgeInsets.zero, // Makes it vertically centered
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

            // if (_showStickySearch)
            //   SliverPersistentHeader(
            //     pinned: true,
            //     delegate: _SearchBarDelegate(),
            //   ),

            // Filter Chips
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: SizedBox(
                  height: 48,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: ['Accommodations', 'Facilities', 'Amenities'].map((filter) {
                      final isSelected = selectedFilter == filter;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FilterChip(
                          label: Text(
                            filter,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey[800],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          avatar: isSelected
                              ? Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                )
                              : null,
                          selected: isSelected,
                          onSelected: (_) {
                            ref.read(selectedFilterProvider.notifier).state = filter;
                          },
                          selectedColor: Colors.black,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          showCheckmark: false,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),

            // Content based on selected filter
           if (selectedFilter == 'Accommodations') ...[

  // Common Rooms (0-3)
  SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
      child: Row(
        children: [
          SvgPicture.asset('lib/assets/icons/bed.svg', width: 20,),
          SizedBox(width: 5,),
          Text(
            "Common Rooms",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  ),
  SliverToBoxAdapter(
    child: SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: hotels.length >= 4 ? 4 : hotels.length,
        itemBuilder: (context, index) {
          return Container(
            width: 250,
            margin: const EdgeInsets.only(right: 12),
            child: HotelCard(hotel: hotels[index]),
          );
        },
      ),
    ),
  ),

  // Cameron Rooms (4 and 5)
  if (hotels.length >= 6) ...[
    SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
        child: Row(
          children: [
            SvgPicture.asset('lib/assets/icons/nature.svg', width: 20,),
          SizedBox(width: 5,),
            Text(
              "Cameron",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ),
SliverToBoxAdapter(
  child: SizedBox(
    height: 230,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: hotels.length >= 6 ? 2 : 0, // Only show if at least 6 hotels
      itemBuilder: (context, index) {
        final hotel = hotels[index + 4]; // 5th and 6th items
        return Container(
          width: 250,
          margin: const EdgeInsets.only(right: 12),
          child: HotelCard(hotel: hotel),
        );
      },
    ),
  ),
),


  ],

  // Luxurious Room (6)
  if (hotels.length >= 7) ...[
    SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
        child: Row(
          children: [
            SvgPicture.asset('lib/assets/icons/shine.svg', width: 20,),
          SizedBox(width: 5,),
            Text(
              "Luxury Room",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(thickness: 1,color: Colors.black, indent: 29,)
          ],
        ),
      ),
    ),
    SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: HotelCard(hotel: hotels[6]),
      ),
    ),
  ],
]


            else if (selectedFilter == 'Facilities')
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final facility = facilities[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: FacilityCard(facility: facility),
                    );
                  },
                  childCount: facilities.length,
                ),
              )
            else if (selectedFilter == 'Amenities')
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: amenities.map((amenity) {
                      final icon = amenityIcons[amenity] ?? Icons.star;
                      return Container(
                        width: 100,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE0E0E0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(icon, size: 26, color: Colors.black87),
                            const SizedBox(height: 8),
                            Text(
                              amenity,
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              )
            else
              SliverToBoxAdapter(
                child: Center(child: Text('No data available')),
              ),

            SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),

 // Dummy floating chatbox at the bottom
AnimatedPositioned(
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  bottom: _showMessageInput ? 80 : -400,
  left: 20,
  right: 20,
  child: AnimatedOpacity(
    duration: const Duration(milliseconds: 300),
    opacity: _showMessageInput ? 1.0 : 0.0,
    child: IgnorePointer(
      ignoring: !_showMessageInput,
      child: Container(
        height: 350,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header with recipient name
            Row(
  children: [
    const CircleAvatar(
      radius: 16,
      backgroundColor: Colors.black,
      child: Icon(Icons.admin_panel_settings, color: Colors.white, size: 16),
    ),
    const SizedBox(width: 10),
    const Text(
      "Admin",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
    Spacer(),
    PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'delete') {
          _deleteUserMessages();
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem<String>(
          value: 'delete',
          child: Text('Delete My Messages'),
        ),
      ],
    ),
    IconButton(
      icon: const Icon(Icons.close),
      onPressed: () {
        setState(() {
          _showMessageInput = false;
        });
      },
    ),
  ],
),


            const SizedBox(height: 8),

            // Chat messages (dummy messages for now)
            Expanded(
  child: ListView(
    controller: _scrollController2,
    children: [
      _chatBubble("Hello! 👋", isAdmin: true),
      _chatBubble("I'm the admin. How can I help you today?", isAdmin: true),
      _chatBubble("Feel free to ask any questions.", isAdmin: true),
      ..._userMessages.map((msg) => _chatBubble(msg, isAdmin: false)),
    ],
  ),
),


            // Message input
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      maxLines: 5,
                      minLines: 1,
                      decoration: const InputDecoration(
                        hintText: 'Type your message...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.black),
                    onPressed: () {
                      _sendMessage();
                      //final message = _messageController.text.trim();
                      // if (message.isNotEmpty) {
                      //   print('Sending message: $message');
                      //   _messageController.clear();
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //       content: Text('Message sent!'),
                      //       duration: Duration(seconds: 2),
                      //       behavior: SnackBarBehavior.floating,
                      //       margin: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(12),
                      //       ),
                      //     ),
                      //   );
                      // }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ),
),



      ],
    ),
  );
}
                }
Widget _chatBubble(String message, {bool isAdmin = false}) {
  return Align(
    alignment: isAdmin ? Alignment.centerLeft : Alignment.centerRight,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isAdmin ? Colors.grey[200] : Colors.blue[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        message,
        style: const TextStyle(color: Colors.black87),
      ),
    ),
  );
}


/// 🔧 Sticky Search Bar Delegate
class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.black),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search hotels, houses, meeting rooms',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
    
  }

  @override
  double get maxExtent => 60.0;

  @override
  double get minExtent => 60.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  
}


class HotelCard extends StatelessWidget {
  final HotelModel hotel;

  const HotelCard({Key? key, required this.hotel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HotelDetailPage(hotel: hotel),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 6,
              offset: Offset(1, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              Image.asset(
                hotel.imageUrl,
                fit: BoxFit.cover,
              ),
      
              // Gradient overlay for better text readability
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hotel details (left side)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hotel.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    hotel.location,
                                    style: TextStyle(color: Colors.white70, fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.star, size: 14, color: Colors.amber),
                                const SizedBox(width: 4),
                                Text(
                                  '${hotel.rating} (${hotel.reviewCount})',
                                  style: TextStyle(color: Colors.white70, fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Price & favorite button (right side)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(0, 128, 128, 128),
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                '₱${NumberFormat('#,##0', 'en_US').format(hotel.price)}/night',
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 253, 253, 253),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Icon(Icons.favorite_border, color: Colors.white),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



















// App Drawer Widget
class AppDrawer extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onToggleDarkMode;
  
  const AppDrawer({
    Key? key,
    required this.isDarkMode,
    required this.onToggleDarkMode,
  }) : super(key: key);


@override
Widget build(BuildContext context) {
  return Drawer(
    backgroundColor: Colors.white,
    child: Stack(
      children: [
        // Background gradient circles (extend behind header and list tiles)
        Positioned(
          top: -60,
          left: -60,
          child: Container(
            width: 300,
            height: 300,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(19, 233, 4, 62),
            ),
          ),
        ),
        Positioned(
          top: -30,
          left: -30,
          child: Container(
            width: 210,
            height: 210,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(50, 233, 4, 62),
            ),
          ),
        ),
        Positioned(
          top: -90,
          left: -90,
          child: Container(
            width: 400,
            height: 400,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(20, 233, 4, 62),
            ),
          ),
        ),

        // Foreground content with copyright at bottom
        Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    height: 160,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage('lib/assets/images/VC-1.png'),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'User',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            const Text(
                              'user@example.com',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height:10),

                  ListTile(
                    leading: SvgPicture.asset("lib/assets/icons/bedd.svg", height: 25,),
                    title: Text('My Booked Rooms', style: TextStyle(
                      fontWeight: FontWeight.w600
                    ),),
                    onTap: () {
                      Navigator.of(context).pop();
                      Future.delayed(const Duration(milliseconds: 1), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MyBookedRoomsPage()),
                        );
                      });
                    },
                  ),
                  ListTile(
                      leading:  SvgPicture.asset("lib/assets/icons/promo.svg", height: 25,),
                      title: Text(
                        'Promos and Offers',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        Navigator.of(context).pop(); // Close the drawer
                        Future.delayed(const Duration(milliseconds: 1), () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PromosAndOffersScreen()),
                        );
                        });
                      },
                    ),
                  ListTile(
                      leading: SvgPicture.asset("lib/assets/icons/rate.svg", height: 25,),
                      title: Text(
                        'Rate Our Service',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        Navigator.of(context).pop(); // Close the drawer
                        Future.delayed(const Duration(milliseconds: 1), () {
                          showDialog(
                            context: context,
                            builder: (context) => RateServiceDialog(),
                          );
                        });
                      },
                    ),
                    ListTile(
                    leading: SvgPicture.asset("lib/assets/icons/phone.svg", height: 25,),
                    title: const Text('Contact us', style: TextStyle(
                      fontWeight: FontWeight.w600
                    ),),
                    onTap: () {
                      Navigator.of(context).pop();
                      Future.delayed(const Duration(milliseconds: 1), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Contactuspage()),
                        );
                      });
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset("lib/assets/icons/about.svg", height: 25,),
                    title: const Text('About us', style: TextStyle(
                      fontWeight: FontWeight.w600
                    ),),
                    onTap: () {
                      Navigator.of(context).pop();
                      Future.delayed(const Duration(milliseconds: 1), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AboutUsPage()),
                        );
                      });
                    },
                  ),
                  
                  ListTile(
                    leading: SvgPicture.asset("lib/assets/icons/logout.svg", height: 25,),
                    title: const Text('Sign Out', style: TextStyle(
                      fontWeight: FontWeight.w600
                    ),),
                    onTap: () {
                      Navigator.of(context).pop();
                      Future.delayed(const Duration(milliseconds: 1), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AuthPage()),
                        );
                      });
                    },
                  ),
                ],
              ),
            ),
            
            // Copyright text at the very bottom
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  '© ${DateTime.now().year} Villa Costa. All rights reserved',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

}
class RateServiceDialog extends StatefulWidget {
  @override
  _RateServiceDialogState createState() => _RateServiceDialogState();
}

class _RateServiceDialogState extends State<RateServiceDialog> {
  int _rating = 0;
  final TextEditingController _feedbackController = TextEditingController();

  @override
Widget build(BuildContext context) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    content: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500), // Adjust width here
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Rate Our Service',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: Center(
                child: Wrap(
                  spacing: 4, // Small spacing between stars
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _rating = index + 1;
                        });
                      },
                      child: Icon(
                        index < _rating ? Icons.star_rate_rounded : Icons.star_border_purple500_rounded,
                        color: Colors.amber,
                        size: 30,
                      ),
                    );
                  }),
                ),
              ),
            ),


            const SizedBox(height: 12),
            TextField(
  controller: _feedbackController,
  maxLines: 3,
  decoration: InputDecoration(
    hintText: "Suggestions / Recommendations (optional)",
    filled: true,
    fillColor: const Color(0xFFF5F5F5),

    // Default border
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),

    // Border when focused
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.black, width: 2),
    ),
  ),
),

          ],
        ),
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('Cancel', style: TextStyle(color: Colors.black),),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Thanks for your feedback!")),
          );
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text('Submit'),
      ),
    ],
  );
}

}

// Provider for filter selection
final selectedFilterProvider = StateProvider<String>((ref) => 'All');