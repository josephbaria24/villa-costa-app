// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 18),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'About Us',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner image
            
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Learn more", style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 35,
                      ),),
                      Text("About us!", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 33,
                                    ),),
                    ],
                                    ),
                  ),
                SizedBox(height: 20,),
                  Text(
                    'Welcome to your dream home away from home',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Villa Costa is a cozy and inviting hotel that offers a perfect blend of comfort and convenience. '
                    'Located in Puerto Princesa City, Palawan, our hotel provides guests with modern amenities, '
                    'attentive service, and a relaxing atmosphere. Whether you\'re visiting for business or leisure, '
                    'Villa Costa is the ideal place to enjoy a memorable stay.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Color.fromARGB(255, 116, 116, 116),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  
                ],
              ),
            ),
             SizedBox(height: 30,),
            
            // Contact Information Section
            ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
              child: Image.asset(
                'lib/assets/images/bgh.jpg',
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}