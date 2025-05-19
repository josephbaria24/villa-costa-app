// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingsScreen extends StatefulWidget {
  const RatingsScreen({super.key});

  @override
  State<RatingsScreen> createState() => _RatingsScreenState();
}

class _RatingsScreenState extends State<RatingsScreen> {
  final double hotelRating = 4.6;
  final int hotelReviews = 128;
  
  // Track which cards are expanded
  final Set<String> _expandedCards = {};

  final List<Map<String, dynamic>> roomRatings = [
    {
      'roomName': 'Single Room',
      'rating': 4.8,
      'reviews': 230,
      'category': 'Common Rooms',
      'comment': 'Perfect for solo travelers.',
    },
    {
      'roomName': 'Double Room',
      'rating': 4.7,
      'reviews': 195,
      'category': 'Common Rooms',
    },
    {
      'roomName': 'Triple Room',
      'rating': 4.8,
      'reviews': 178,
      'category': 'Common Rooms',
      'comment': 'Great for small families!',
    },
    {
      'roomName': 'Quad Room',
      'rating': 4.8,
      'reviews': 178,
      'category': 'Common Rooms',
    },
    {
      'roomName': 'Camera Con Room',
      'rating': 4.8,
      'reviews': 178,
      'category': 'Cameron Rooms',
      'comment': 'Spacious with mountain views.',
    },
    {
      'roomName': 'Camera Superior',
      'rating': 4.9,
      'reviews': 160,
      'category': 'Cameron Rooms',
    },
    {
      'roomName': 'Luxury Room',
      'rating': 4.9,
      'reviews': 53,
      'category': 'Luxury Rooms',
      'comment': 'Top-tier comfort and design.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final categories = _groupByCategory(roomRatings);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 18),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        scrolledUnderElevation: 0,
        title: const Text('Guest Ratings', style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 18
        ),),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOverallRating(),
          const Divider(height: 20, thickness: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 16),
              children: categories.entries.map((entry) {
                return _buildCategorySection(entry.key, entry.value);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverallRating() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Overall Rating',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                hotelRating.toString(),
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 12),
              RatingBarIndicator(
                rating: hotelRating,
                itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                itemCount: 5,
                itemSize: 24,
                unratedColor: Colors.grey[300],
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '$hotelReviews reviews',
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(String category, List<Map<String, dynamic>> rooms) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.2,
            children: rooms.map((room) => _buildExpandableRoomRatingCard(room)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableRoomRatingCard(Map<String, dynamic> room) {
    // Create a unique ID for this card
    final String cardId = '${room['roomName']}_${room['rating']}';
    final bool isExpanded = _expandedCards.contains(cardId);
    
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isExpanded) {
            _expandedCards.remove(cardId);
          } else {
            _expandedCards.add(cardId);
          }
        });
      },
      child: AnimatedContainer(
        height: isExpanded && room['comment'] != null ? 250 : 250,
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    room['roomName'],
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  size: 18,
                ),
              ],
            ),
            const SizedBox(height: 6),
            RatingBarIndicator(
              rating: room['rating'],
              itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
              itemCount: 5,
              itemSize: 16,
              unratedColor: Colors.grey[300],
            ),
            const SizedBox(height: 4),
            Text(
              '${room['rating']} (${room['reviews']} reviews)',
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
            if (room['comment'] != null) ...[
              const SizedBox(height: 6),
              if (isExpanded)
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      room['comment'],
                      style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic, color: Colors.black87),
                    ),
                  ),
                )
              else
                Text(
                  room['comment'],
                  style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic, color: Colors.black87),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ],
        ),
      ),
    );
  }

  /// Groups rooms by category
  Map<String, List<Map<String, dynamic>>> _groupByCategory(List<Map<String, dynamic>> rooms) {
    final Map<String, List<Map<String, dynamic>>> grouped = {};
    for (var room in rooms) {
      final category = room['category'] ?? 'Others';
      grouped.putIfAbsent(category, () => []).add(room);
    }
    return grouped;
  }
}