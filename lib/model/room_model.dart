
import 'package:flutter/material.dart';

class HotelModel {
  final String id;
  final String name;
  final String location;
  final double price;
  final double rating;
  final int reviewCount;
  final String imageUrl;
  final List<Amenity> amenities;
  final List<DateTime> bookedDates;

  HotelModel({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    required this.amenities,
    List<DateTime>? bookedDates,
  }) : bookedDates = bookedDates ?? [];

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      price: json['price'],
      rating: json['rating'],
      reviewCount: json['reviewCount'],
      imageUrl: json['imageUrl'],
      amenities: (json['amenities'] as List)
          .map((item) => Amenity.fromJson(item))
          .toList(),
      bookedDates: (json['bookedDates'] as List)
          .map((dateStr) => DateTime.parse(dateStr))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'price': price,
      'rating': rating,
      'reviewCount': reviewCount,
      'imageUrl': imageUrl,
      'amenities': amenities.map((a) => a.toJson()).toList(),
      'bookedDates': bookedDates.map((d) => d.toIso8601String()).toList(),
    };
  }
}

class Amenity {
  final IconData icon;
  final String label;

  Amenity({required this.icon, required this.label});

  factory Amenity.fromJson(Map<String, dynamic> json) {
    return Amenity(
      icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
      label: json['label'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'icon': icon.codePoint,
      'label': label,
    };
  }
}


