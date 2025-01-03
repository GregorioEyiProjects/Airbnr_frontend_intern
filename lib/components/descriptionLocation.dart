import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Descriptionlocation extends StatefulWidget {
  final DocumentSnapshot<Object?> location;

  const Descriptionlocation({super.key, required this.location}); //

  @override
  State<Descriptionlocation> createState() => _DescriptionlocationState();
}

class _DescriptionlocationState extends State<Descriptionlocation> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationButtonEnabled: false,
      markers: {
        Marker(
          markerId: MarkerId(widget.location.toString()),
          position: LatLng(
            widget.location['locations'].latitude,
            widget.location['locations'].longitude,
          ),
        ),
      },
      initialCameraPosition: CameraPosition(
        target: LatLng(
          widget.location['locations'].latitude,
          widget.location['locations'].longitude,
        ),
        zoom: 15,
      ),
    );
  }
}
