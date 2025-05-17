class FacilityModel {
  final String name;
  final String description;
  final String imageUrl;

  FacilityModel({
    required this.name,
    required this.description,
    required this.imageUrl,
  });
}



final List<FacilityModel> facilities = [
  FacilityModel(
    name: 'Swimming Pool',
    description: 'Enjoy our outdoor pool with scenic views and relaxing ambiance.',
    imageUrl: 'lib/assets/images/fac1.png',
  ),
  FacilityModel(
    name: 'Dining Space',
    description: 'Taste world-class cuisine in our elegant dining area.',
    imageUrl: 'lib/assets/images/fac2.png',
  ),
  FacilityModel(
    name: 'Fitness Facilities',
    description: 'Stay fit with our state-of-the-art gym and fitness center.',
    imageUrl: 'lib/assets/images/fac3.png',
  ),
  FacilityModel(
    name: 'Onsite SPA',
    description: 'Unwind and rejuvenate at our full-service luxury spa.',
    imageUrl: 'lib/assets/images/fac4.png',
  ),
];