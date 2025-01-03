import 'dart:async'; // Import for StreamController
import 'dart:ui';
import 'package:airbnbr/components/custom_map.dart';
import 'package:airbnbr/components/display_place.dart';
import 'package:airbnbr/components/display_total_price.dart';
import 'package:airbnbr/model/user_login_model.dart';
import 'package:airbnbr/views/stays/Stays.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:airbnbr/components/stays/search_and_filter.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class ExploreScreen extends StatefulWidget {
  final String userId;

  ExploreScreen({super.key, required this.userId});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final StreamController<Map<String, dynamic>> _categoryController =
      StreamController();

  //Bring this from the DB
  Map<String, dynamic> data = {
    'categories': [
      {
        'name': 'Beachfront',
        'icon': Icons.beach_access,
      },
      {
        'name': 'Icons',
        'icon': Icons.explore,
      },
      {
        'name': 'OMG!',
        'icon': Icons.emoji_emotions,
      },
      {
        'name': 'Design',
        'icon': Icons.design_services_outlined,
      },
      {
        'name': 'Amazing pools',
        'icon': Icons.pool_outlined,
      },
      {
        'name': 'Castles',
        'icon': Icons.castle,
      },
      {
        'name': 'Rooms',
        'icon': Icons.bed,
      },
    ]
  };

  @override
  void initState() {
    super.initState();
    _categoryController.add(data);
  }

  @override
  void dispose() {
    _categoryController.close();
    super.dispose();
  }

  int selectedIndexCategory = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Search and Filter
            SearchAndFilter(size: size),
            // Categories list
            _categoryList(size),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 2,
                    ),
                    // Display total price
                    const DisplayTotalPrice(),
                    const SizedBox(
                      height: 15,
                    ),
                    // Display place in anotherCarousel
                    DisplayPlace(
                      userId: widget.userId,
                    ),
                  ],
                ),
              ),
            ),

            //
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const CustomMap(),
    );
  }

  StreamBuilder<Map<String, dynamic>> _categoryList(
    Size size,
  ) {
    return StreamBuilder<Map<String, dynamic>>(
      stream: _categoryController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List categories = snapshot.data!['categories'];
          return Stack(
            children: [
              const Positioned(
                // line under the catergories
                right: 0,
                left: 0,
                top: 80,
                child: Divider(color: Colors.black26),
              ),
              SizedBox(
                height: size.height * 0.12,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    var category = categories[index]; // Get category data
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndexCategory = index;
                        });
                      },
                      child: Container(
                        padding:
                            const EdgeInsets.only(right: 20, left: 20, top: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 40,
                              height: 25,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: Icon(
                                category['icon'],
                                color: selectedIndexCategory == index
                                    ? Colors.black
                                    : Colors.black26,
                              ),
                            ),
                            const SizedBox(height: 1),
                            Text(
                              category['name'],
                              style: TextStyle(
                                fontSize: 13,
                                color: selectedIndexCategory == index
                                    ? Colors.black
                                    : Colors.black26,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              height: 2.5,
                              width: 55,
                              color: selectedIndexCategory == index
                                  ? Colors.black
                                  : Colors.transparent,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
