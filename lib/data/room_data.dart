import 'package:flutter/material.dart';
import 'package:villa_costa/model/room_model.dart';

final List<HotelModel> hotels = [
  HotelModel(
    id: 'room1',
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
    id: 'room2',
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
    id: 'room3',
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
    id: 'room4',
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
    id: 'room5',
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
    id: 'room6',
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
      id: 'room7',
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
