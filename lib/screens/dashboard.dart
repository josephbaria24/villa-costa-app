// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:villa_costa/model/facilities_model.dart';
import 'package:villa_costa/screens/AboutUs.dart';
import 'package:villa_costa/screens/MyBookedRoomsPage.dart';
import 'package:villa_costa/screens/facilities_card.dart';
import 'package:villa_costa/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class HotelDashboard extends ConsumerStatefulWidget {
  const HotelDashboard({Key? key}) : super(key: key);

  @override
  _HotelDashboardState createState() => _HotelDashboardState();
}

class _HotelDashboardState extends ConsumerState<HotelDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

bool _showMessageInput = false;
final TextEditingController _messageController = TextEditingController();
final selectedFilterProvider = StateProvider<String>((ref) => 'Accommodation');

ScrollController _scrollController = ScrollController();
bool _showStickySearch = false;
@override
void initState() {
  super.initState();
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





 
final List<HotelModel> _hotels = [
  HotelModel(
    name: 'Single Room',
    location: 'A room designed for 1 person, often with a single bed.',
    price: 4500,
    rating: 4.9,
    reviewCount: 230,
    imageUrl: 'lib/assets/images/room1.png',
    amenities: [
      Amenity(icon: Icons.bed, label: '1 single bed'),
      Amenity(icon: Icons.shower, label: 'Shower'),
      Amenity(icon: Icons.wifi, label: 'Internet'),
      Amenity(icon: Icons.local_cafe, label: 'Coffee/tea maker'),
      Amenity(icon: Icons.desktop_windows, label: 'Desk'),
      Amenity(icon: Icons.air, label: 'Hair dryer'),
      Amenity(icon: Icons.smoke_free, label: 'Smoke detector'),
      Amenity(icon: Icons.bathtub, label: 'Towels'),
      Amenity(icon: Icons.spa, label: 'Bathrobes'),
      Amenity(icon: Icons.king_bed, label: 'Slippers'),
      Amenity(icon: Icons.local_bar, label: 'Mini bar'),
      Amenity(icon: Icons.phone, label: 'Telephone'),
      Amenity(icon: Icons.soap, label: 'Toiletries'),
      Amenity(icon: Icons.microwave, label: 'Microwave'),
      Amenity(icon: Icons.kitchen, label: 'Kitchenette'),
      Amenity(icon: Icons.ac_unit, label: 'Air conditioner'),
      Amenity(icon: Icons.backpack, label: 'Luggage storage'),
    ],
  ),
  HotelModel(
    name: 'Double Room',
    location: 'A room for two people, often with a double or two single beds.',
    price: 6700,
    rating: 4.7,
    reviewCount: 195,
    imageUrl: 'lib/assets/images/room2.png',
    amenities: [
      Amenity(icon: Icons.bed, label: '2 single bed'),
      Amenity(icon: Icons.shower, label: 'Shower'),
      Amenity(icon: Icons.wifi, label: 'Internet'),
      Amenity(icon: Icons.local_cafe, label: 'Coffee/tea maker'),
      Amenity(icon: Icons.desktop_windows, label: 'Desk'),
      Amenity(icon: Icons.air, label: 'Hair dryer'),
      Amenity(icon: Icons.smoke_free, label: 'Smoke detector'),
      Amenity(icon: Icons.bathtub, label: 'Towels'),
      Amenity(icon: Icons.spa, label: 'Bathrobes'),
      Amenity(icon: Icons.king_bed, label: 'Slippers'),
      Amenity(icon: Icons.local_bar, label: 'Mini bar'),
      Amenity(icon: Icons.phone, label: 'Telephone'),
      Amenity(icon: Icons.soap, label: 'Toiletries'),
      Amenity(icon: Icons.microwave, label: 'Microwave'),
      Amenity(icon: Icons.kitchen, label: 'Kitchenette'),
      Amenity(icon: Icons.ac_unit, label: 'Air conditioner'),
      Amenity(icon: Icons.backpack, label: 'Luggage storage'),
      Amenity(icon: Icons.checkroom, label: 'Closet'),
      Amenity(icon: Icons.lock, label: 'In-room safe box'),
      Amenity(icon: Icons.event_seat, label: 'Seating area'),
      Amenity(icon: Icons.room_service, label: 'Room service'),
    ],
  ),
  HotelModel(
    name: 'Tripple Room',
    location: 'A room that accomodates three people, with a combination of beds.',
    price: 9000,
    rating: 4.8,
    reviewCount: 178,
    imageUrl: 'lib/assets/images/room3.png',
    amenities: [
      Amenity(icon: Icons.bed, label: '1 queen size bed'),
      Amenity(icon: Icons.bed, label: '1 single bed'),
      Amenity(icon: Icons.shower, label: 'Shower'),
      Amenity(icon: Icons.wifi, label: 'Internet'),
      Amenity(icon: Icons.local_cafe, label: 'Coffee/tea maker'),
      Amenity(icon: Icons.desktop_windows, label: 'Desk'),
      Amenity(icon: Icons.air, label: 'Hair dryer'),
      Amenity(icon: Icons.smoke_free, label: 'Smoke detector'),
      Amenity(icon: Icons.bathtub, label: 'Towels'),
      Amenity(icon: Icons.spa, label: 'Bathrobes'),
      Amenity(icon: Icons.king_bed, label: 'Slippers'),
      Amenity(icon: Icons.local_bar, label: 'Mini bar'),
      Amenity(icon: Icons.phone, label: 'Telephone'),
      Amenity(icon: Icons.soap, label: 'Toiletries'),
      Amenity(icon: Icons.microwave, label: 'Microwave'),
      Amenity(icon: Icons.kitchen, label: 'Kitchenette'),
      Amenity(icon: Icons.ac_unit, label: 'Air conditioner'),
      Amenity(icon: Icons.backpack, label: 'Luggage storage'),
      Amenity(icon: Icons.checkroom, label: 'Closet'),
      Amenity(icon: Icons.lock, label: 'In-room safe box'),
      Amenity(icon: Icons.event_seat, label: 'Seating area'),
      Amenity(icon: Icons.room_service, label: 'Room service'),
      Amenity(icon: Icons.business_center, label: 'Business facilities'),
      Amenity(icon: Icons.tv, label: 'Smart TV'),
      Amenity(icon: Icons.local_laundry_service, label: 'Laundry service'),
      Amenity(icon: Icons.support_agent, label: 'Concierge'),
    ],
  ),
  HotelModel(
    name: 'Quad Room',
    location: 'A room for four people, usually with two double beds or a mix of single and double beds.',
    price: 13500,
    rating: 4.8,
    reviewCount: 178,
    imageUrl: 'lib/assets/images/room4.png',
    amenities: [
      Amenity(icon: Icons.bed, label: '2 queen size bed'),
      Amenity(icon: Icons.shower, label: 'Shower'),
      Amenity(icon: Icons.wifi, label: 'Internet'),
      Amenity(icon: Icons.local_cafe, label: 'Coffee/tea maker'),
      Amenity(icon: Icons.desktop_windows, label: 'Desk'),
      Amenity(icon: Icons.air, label: 'Hair dryer'),
      Amenity(icon: Icons.smoke_free, label: 'Smoke detector'),
      Amenity(icon: Icons.bathtub, label: 'Towels'),
      Amenity(icon: Icons.spa, label: 'Bathrobes'),
      Amenity(icon: Icons.king_bed, label: 'Slippers'),
      Amenity(icon: Icons.local_bar, label: 'Mini bar'),
      Amenity(icon: Icons.phone, label: 'Telephone'),
      Amenity(icon: Icons.soap, label: 'Toiletries'),
      Amenity(icon: Icons.microwave, label: 'Microwave'),
      Amenity(icon: Icons.kitchen, label: 'Kitchenette'),
      Amenity(icon: Icons.ac_unit, label: 'Air conditioner'),
      Amenity(icon: Icons.backpack, label: 'Luggage storage'),
      Amenity(icon: Icons.checkroom, label: 'Closet'),
      Amenity(icon: Icons.lock, label: 'In-room safe box'),
      Amenity(icon: Icons.event_seat, label: 'Seating area'),
      Amenity(icon: Icons.room_service, label: 'Room service'),
      Amenity(icon: Icons.business_center, label: 'Business facilities'),
      Amenity(icon: Icons.tv, label: 'Smart TV'),
      Amenity(icon: Icons.local_laundry_service, label: 'Laundry service'),
      Amenity(icon: Icons.support_agent, label: 'Concierge'),
      Amenity(icon: Icons.hearing, label: 'Soundproof room'),
      Amenity(icon: Icons.hot_tub, label: 'Sauna'),
      Amenity(icon: Icons.local_laundry_service, label: 'Laundrymat'),
    ],
  ),
  HotelModel(
    name: 'Camera con vista',
    location: 'A room offering a scenic view, often of the sea, a city, or mountains.',
    price: 16000,
    rating: 4.8,
    reviewCount: 178,
    imageUrl: 'lib/assets/images/room6.png',
    amenities: [
      Amenity(icon: Icons.bed, label: '2 queen size bed'),
      Amenity(icon: Icons.shower, label: 'Shower'),
      Amenity(icon: Icons.wifi, label: 'Internet'),
      Amenity(icon: Icons.local_cafe, label: 'Coffee/tea maker'),
      Amenity(icon: Icons.desktop_windows, label: 'Desk'),
      Amenity(icon: Icons.air, label: 'Hair dryer'),
      Amenity(icon: Icons.smoke_free, label: 'Smoke detector'),
      Amenity(icon: Icons.bathtub, label: 'Towels'),
      Amenity(icon: Icons.spa, label: 'Bathrobes'),
      Amenity(icon: Icons.king_bed, label: 'Slippers'),
      Amenity(icon: Icons.local_bar, label: 'Mini bar'),
      Amenity(icon: Icons.phone, label: 'Telephone'),
      Amenity(icon: Icons.soap, label: 'Toiletries'),
      Amenity(icon: Icons.microwave, label: 'Microwave'),
      Amenity(icon: Icons.kitchen, label: 'Kitchenette'),
      Amenity(icon: Icons.ac_unit, label: 'Air conditioner'),
      Amenity(icon: Icons.backpack, label: 'Luggage storage'),
      Amenity(icon: Icons.checkroom, label: 'Closet'),
      Amenity(icon: Icons.lock, label: 'In-room safe box'),
      Amenity(icon: Icons.event_seat, label: 'Seating area'),
      Amenity(icon: Icons.room_service, label: 'Room service'),
      Amenity(icon: Icons.business_center, label: 'Business facilities'),
      Amenity(icon: Icons.tv, label: 'Smart TV'),
      Amenity(icon: Icons.local_laundry_service, label: 'Laundry service'),
      Amenity(icon: Icons.support_agent, label: 'Concierge'),
      Amenity(icon: Icons.hearing, label: 'Soundproof room'),
      Amenity(icon: Icons.hot_tub, label: 'Sauna'),
      Amenity(icon: Icons.local_laundry_service, label: 'Laundrymat'),
      Amenity(icon: Icons.spa, label: 'Spa'),
      Amenity(icon: Icons.self_improvement, label: 'Massage'),
      Amenity(icon: Icons.wifi, label: 'WiFi in public area'),
      Amenity(icon: Icons.airport_shuttle, label: 'Airport transfer'),
      Amenity(icon: Icons.currency_exchange, label: 'Currency exchange'),
    ],
  ),
  HotelModel(
    name: 'Camera Superior',
    location: 'A higher end-room, typically with extra comfort or additional features like a larger bathroom or better views.',
    price: 18500,
    rating: 4.8,
    reviewCount: 178,
    imageUrl: 'lib/assets/images/room7.png',
    amenities: [
      Amenity(icon: Icons.bed, label: '2 queen size bed'),
      Amenity(icon: Icons.shower, label: 'Shower'),
      Amenity(icon: Icons.wifi, label: 'Internet'),
      Amenity(icon: Icons.local_cafe, label: 'Coffee/tea maker'),
      Amenity(icon: Icons.desktop_windows, label: 'Desk'),
      Amenity(icon: Icons.air, label: 'Hair dryer'),
      Amenity(icon: Icons.smoke_free, label: 'Smoke detector'),
      Amenity(icon: Icons.bathtub, label: 'Towels'),
      Amenity(icon: Icons.spa, label: 'Bathrobes'),
      Amenity(icon: Icons.king_bed, label: 'Slippers'),
      Amenity(icon: Icons.local_bar, label: 'Mini bar'),
      Amenity(icon: Icons.phone, label: 'Telephone'),
      Amenity(icon: Icons.soap, label: 'Toiletries'),
      Amenity(icon: Icons.microwave, label: 'Microwave'),
      Amenity(icon: Icons.kitchen, label: 'Kitchenette'),
      Amenity(icon: Icons.ac_unit, label: 'Air conditioner'),
      Amenity(icon: Icons.backpack, label: 'Luggage storage'),
      Amenity(icon: Icons.checkroom, label: 'Closet'),
      Amenity(icon: Icons.lock, label: 'In-room safe box'),
      Amenity(icon: Icons.event_seat, label: 'Seating area'),
      Amenity(icon: Icons.room_service, label: 'Room service'),
      Amenity(icon: Icons.business_center, label: 'Business facilities'),
      Amenity(icon: Icons.tv, label: 'Smart TV'),
      Amenity(icon: Icons.local_laundry_service, label: 'Laundry service'),
      Amenity(icon: Icons.support_agent, label: 'Concierge'),
      Amenity(icon: Icons.hearing, label: 'Soundproof room'),
      Amenity(icon: Icons.hot_tub, label: 'Sauna'),
      Amenity(icon: Icons.local_laundry_service, label: 'Laundrymat'),
      Amenity(icon: Icons.spa, label: 'Spa'),
      Amenity(icon: Icons.self_improvement, label: 'Massage'),
      Amenity(icon: Icons.wifi, label: 'WiFi in public area'),
      Amenity(icon: Icons.airport_shuttle, label: 'Airport transfer'),
      Amenity(icon: Icons.currency_exchange, label: 'Currency exchange'),
    ],
  ),
    HotelModel(
      name: 'Luxury Room',
      location: 'A Luxury room, often with a seperate living area, more space, and premium amenities. ',
      price: 20000,
      rating: 4.8,
      reviewCount: 178,
      imageUrl: 'lib/assets/images/room8.png',
      amenities: [
      Amenity(icon: Icons.bed, label: '2 queen size bed'),
      Amenity(icon: Icons.shower, label: 'Shower'),
      Amenity(icon: Icons.wifi, label: 'Internet'),
      Amenity(icon: Icons.local_cafe, label: 'Coffee/tea maker'),
      Amenity(icon: Icons.desktop_windows, label: 'Desk'),
      Amenity(icon: Icons.air, label: 'Hair dryer'),
      Amenity(icon: Icons.smoke_free, label: 'Smoke detector'),
      Amenity(icon: Icons.bathtub, label: 'Towels'),
      Amenity(icon: Icons.spa, label: 'Bathrobes'),
      Amenity(icon: Icons.king_bed, label: 'Slippers'),
      Amenity(icon: Icons.local_bar, label: 'Mini bar'),
      Amenity(icon: Icons.phone, label: 'Telephone'),
      Amenity(icon: Icons.soap, label: 'Toiletries'),
      Amenity(icon: Icons.microwave, label: 'Microwave'),
      Amenity(icon: Icons.kitchen, label: 'Kitchenette'),
      Amenity(icon: Icons.ac_unit, label: 'Air conditioner'),
      Amenity(icon: Icons.backpack, label: 'Luggage storage'),
      Amenity(icon: Icons.checkroom, label: 'Closet'),
      Amenity(icon: Icons.lock, label: 'In-room safe box'),
      Amenity(icon: Icons.event_seat, label: 'Seating area'),
      Amenity(icon: Icons.room_service, label: 'Room service'),
      Amenity(icon: Icons.business_center, label: 'Business facilities'),
      Amenity(icon: Icons.tv, label: 'Smart TV'),
      Amenity(icon: Icons.local_laundry_service, label: 'Laundry service'),
      Amenity(icon: Icons.support_agent, label: 'Concierge'),
      Amenity(icon: Icons.hearing, label: 'Soundproof room'),
      Amenity(icon: Icons.hot_tub, label: 'Sauna'),
      Amenity(icon: Icons.local_laundry_service, label: 'Laundrymat'),
      Amenity(icon: Icons.spa, label: 'Spa'),
      Amenity(icon: Icons.self_improvement, label: 'Massage'),
      Amenity(icon: Icons.wifi, label: 'WiFi in public area'),
      Amenity(icon: Icons.airport_shuttle, label: 'Airport transfer'),
      Amenity(icon: Icons.currency_exchange, label: 'Currency exchange'),
    ],
    ),
  ];



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
      child: Icon(Icons.messenger_outline_sharp),
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
              title: _showStickySearch
      ? Row(
          children: [
            
            const SizedBox(width: 10),
            const Text(
              "Villa Costa",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        )
      : null,
              actions: [
                
                IconButton(
                  icon: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(0, 255, 255, 255),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: SvgPicture.asset(
                        'lib/assets/icons/menu.svg',
                        width: 30,
                        height: 30,
                        color: _showStickySearch ? Colors.black : Colors.white,// Remove this line if your SVG has its own color
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
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: Colors.black),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search rooms and facilities',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey),
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

            if (_showStickySearch)
              SliverPersistentHeader(
                pinned: true,
                delegate: _SearchBarDelegate(),
              ),

            // Filter Chips
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: SizedBox(
                  height: 48,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: ['Accommodation', 'Facilities', 'Amenities'].map((filter) {
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
            if (selectedFilter == 'Accommodation')
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final hotel = _hotels[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: HotelCard(hotel: hotel),
                    );
                  },
                  childCount: _hotels.length,
                ),
              )
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

        // Floating message input at bottom
        AnimatedPositioned(
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  bottom: _showMessageInput ? 20 : -200, // Animate in/out
  left: 20,
  right: 80,
  child: AnimatedOpacity(
    duration: const Duration(milliseconds: 300),
    opacity: _showMessageInput ? 1.0 : 0.0,
    child: IgnorePointer(
      ignoring: !_showMessageInput, // Prevents interaction when invisible
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
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
                final message = _messageController.text.trim();
                if (message.isNotEmpty) {
                  print('Sending message: $message');
                  _messageController.clear();
                  setState(() {
                    _showMessageInput = false;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Message sent!'),
                      duration: Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                }
              },
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








class HotelModel {
  final String name;
  final String location;
  final double price;
  final double rating;
  final int reviewCount;
  final String imageUrl;
  final List<Amenity> amenities;

  HotelModel({
    required this.name,
    required this.location,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    required this.amenities,
  });
}
class Amenity {
  final IconData icon;
  final String label;

  Amenity({required this.icon, required this.label});
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
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
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
                                fontWeight: FontWeight.normal,
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
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('lib/assets/icons/fit.jpg'),
                ),
                SizedBox(height: 10),
                Text(
                  'CHTM',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 18,
                  ),
                ),
                Text(
                  'joseph@example.com',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
  leading: Icon(Icons.bedroom_child_outlined),
  title: Text('My Booked Rooms'),
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
            leading: Icon(Icons.favorite_border_outlined),
            title: Text('Saved Rooms'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
              leading: const Icon(Icons.info_outline_rounded),
              title: const Text('About us'),
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
        ],
      ),
    );
  }
  
}

// Provider for filter selection
final selectedFilterProvider = StateProvider<String>((ref) => 'All');