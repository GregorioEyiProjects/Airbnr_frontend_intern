import 'package:airbnbr/components/icon_button.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:airbnbr/components/CustomPainter.dart';
import 'dart:ui' as ui;

class CustomMap extends StatefulWidget {
  const CustomMap({super.key});

  @override
  State<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  //CollectionReference placeColection =FirebaseFirestore.instance.collection('places'); //bring data from the BD
  final CustomInfoWindowController _customInfoWindow =
      CustomInfoWindowController();

  BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;
  List<Marker> markers = [];
  late GoogleMapController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_loadMakers();
  }

  Future<void> _loadMakers() async {
    Size size = MediaQuery.of(context).size;

    const marker = 'assets/images/marker.png';
    BitmapDescriptor.asset(const ImageConfiguration(), marker,
        width: 30, height: 40);

    /*placeColection.snapshots().listen((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        final List allMarkers = querySnapshot.docs;
        List<Marker> myMarker = [];
        for (final marker in allMarkers) {
          final data1 = marker.data();
          final data2 = (data1) as Map;
          myMarker.add(
            Marker(
                markerId: data2['locations'],
                position: LatLng(
                    data2['locations'].latitude, data2['locations'].longitude),
                onTap: () {
                  _customInfoWindow.addInfoWindow!(
                    Container(
                      width: size.width * 0.8,
                      height: size.height * 0.32,
                      //desing of the info window
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: size.height * 0.203,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  child: AnotherCarousel(
                                    images: data2['rooms']['roomImages']
                                        .map((url) => NetworkImage(url))
                                        .toList(),
                                    dotSize: 5,
                                    indicatorBgPadding: 5,
                                    dotBgColor: Colors.black,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 10,
                                left: 14,
                                top: 10,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: const Text(
                                        "GuestFavorite",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const Spacer(),
                                    const IconCustomButton(
                                      icon: Icons.favorite_border,
                                      radius: 20,
                                    ),
                                    const SizedBox(width: 12),
                                    InkWell(
                                      onTap: () {
                                        _customInfoWindow.hideInfoWindow!();
                                      },
                                      child: const IconCustomButton(
                                        icon: Icons.close,
                                        radius: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 9),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Location",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Icon(Icons.start),
                                    const SizedBox(width: 5),
                                    Text(data2['ratins'].toString()),
                                  ],
                                ),
                                const Text(
                                  '3005 m elevation',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  data2['date'],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                Text.rich(
                                  TextSpan(
                                    text: '\$${data2['price']}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                    children: const [
                                      TextSpan(
                                        text: ' / night',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    LatLng(data2['location'].latitude,
                        data2['location'].longitude),
                  );
                },
                icon: customIcon),
          );
        }
        setState(() {
          markers = myMarker;
        });
      }
    });*/

    // Render the widget to an image
    /* final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    const double size = 50.0; // Define size for the marker
    // Create an instance of IconPainter and paint it on the canvas
    IconPainter().paint(canvas, Size(size, size)); */
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FloatingActionButton.extended(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            clipBehavior: Clip.none,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              return Container(
                color: Colors.white,
                width: size.width,
                height: size.height * 0.77,
                child: Stack(
                  children: [
                    SizedBox(
                      height: size.height * 0.77,
                      child: GoogleMap(
                        initialCameraPosition: const CameraPosition(
                          target: LatLng(37.77483, -122.41942),
                          zoom: 14.4746,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          _controller = controller;
                          _customInfoWindow.googleMapController = controller;
                        },
                        onTap: (argument) {
                          _customInfoWindow.hideInfoWindow!();
                        },
                        onCameraMove: (position) {
                          _customInfoWindow.onCameraMove!();
                        },
                        markers: markers.toSet(),
                      ),
                    ),
                    CustomInfoWindow(
                      controller: _customInfoWindow,
                      width: size.width * 0.84,
                      height: size.height * 34,
                      offset: 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 175,
                          vertical: 5,
                        ),
                        child: Container(
                          height: 5,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            });
      },
      backgroundColor: Colors.transparent,
      elevation: 0,
      label: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Row(
          children: [
            SizedBox(width: 5),
            Text(
              "Map",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 17),
            ),
            SizedBox(width: 5),
            Icon(
              Icons.map_outlined,
              color: Colors.white,
            ),
            SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}
