import 'package:flutter/material.dart';
import 'package:airbnbr/global.dart' as global;

class DisplayTotalPrice extends StatefulWidget {
  const DisplayTotalPrice({super.key});

  @override
  State<DisplayTotalPrice> createState() => _DisplayTotalPriceState();
}

class _DisplayTotalPriceState extends State<DisplayTotalPrice> {
  bool isSwitch = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: global.horizontalPadding,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Display total Price",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                  Text("Include all fees, befere taxes",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54))
                ],
              ),
              Switch(
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey,
                  value: isSwitch,
                  onChanged: (value) {
                    setState(() {
                      isSwitch = value;
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
