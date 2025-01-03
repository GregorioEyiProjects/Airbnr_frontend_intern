import 'package:flutter/material.dart';

class ClearAndSearch extends StatefulWidget {
  final Size size;
  final Map<String, dynamic>? whereToGo;
  final Map<String, dynamic>? whenIsYourTripChoice;
  final Map<String, dynamic>? whosComing;

  const ClearAndSearch({
    super.key,
    required this.size,
    this.whereToGo,
    this.whenIsYourTripChoice,
    this.whosComing,
  });

  @override
  State<ClearAndSearch> createState() => _ClearAndSearchState();
}

class _ClearAndSearchState extends State<ClearAndSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.symmetric(vertical: 40),
      //height: widget.size.height * 0.1,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Clear all",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decoration: TextDecoration.underline),
              ),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              //Create an object to send the data to the Backend
              final Map<String, dynamic> searchPlace = {
                "whereToGo": widget.whereToGo,
                "whenIsYourTripChoice": widget.whenIsYourTripChoice,
                "whosComing": widget.whosComing,
              };
              print(" ClearAndSearh Search Place: $searchPlace");

              //Send the data to the Backend
            },
            child: const _SearchStays(),
          ),
          const SizedBox(width: 16)
        ],
      ),
    );
  }
}

class _SearchStays extends StatelessWidget {
  const _SearchStays({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: Colors.white,
            size: 30,
          ),
          SizedBox(width: 8),
          Text(
            "Search",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
