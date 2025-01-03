import 'package:airbnbr/model/room_model.dart';
import 'package:airbnbr/views/home/reserveRoom/payWithBottomSheet.dart';
import 'package:airbnbr/views/home/reserveRoom/totalBottomSheet.dart';
import 'package:airbnbr/views/home/reserveRoom/yourTripsCalendarBottomSheet.dart';
import 'package:airbnbr/views/home/reserveRoom/yourTripsGuestsBottomSheet.dart';
import 'package:airbnbr/views/stays/more.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestToBook extends StatefulWidget {
  final String? userID;
  final Room room;
  //final String? roomID;
  //final String? image;
  const RequestToBook({super.key, this.userID, required this.room});

  @override
  State<RequestToBook> createState() => _RequestToBookState();
}

class _RequestToBookState extends State<RequestToBook> {
  late final List<String> images;

  //DateTime
  final List<DateTime?> _dates = [DateTime.now()];

  //Your trip variables
  String? _yourTripDays = "Nov 19 - 24";
  Map<String, dynamic> _yourTripGuests = {};
  String? _yourTripGuestsString = "1 guest";

  //Price details variables
  int totalNights = 6;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    images = List<String>.from(widget.room.roomImages);
  }

//To update the variable that holds the number of guests
  void updateGuestString(int adults, int children, int infants, int pets) {
    List<String> parts = [];
    if (adults > 0) {
      parts.add(adults == 1 ? "1 adult" : "$adults adults");
    }
    if (children > 0) {
      parts.add(children == 1 ? "1 child" : "$children children");
    }
    if (infants > 0) {
      parts.add(infants == 1 ? "1 infant" : "$infants infants");
    }
    if (pets > 0) {
      parts.add(pets == 1 ? "1 pet" : "$pets pets");
    }
    //To ensure that setState is called after the build process is complete.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _yourTripGuestsString = parts.join(", ");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      //Button Rquest to book
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: InkWell(
              onTap: () {
                //final userID = widget.userID;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(
                      "Room booked successfully!",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
                GoRouter.of(context).go('/home_screen');
              },
              child: const Text(
                'Request to book',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Arrow back container
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        final userID = widget.userID;
                        final room = widget.room;

                        GoRouter.of(context)
                            .go('/room_details?userId=$userID', extra: room);
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Request to book',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                //Room details
                Row(
                  children: [
                    //Image
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Image.network(
                        images[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 15),
                    //Details
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.room.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.room.vendorName,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 25,
                              color: Colors.black,
                            ),
                            Text(
                              widget.room.rating.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                //Divider
                const Divider(
                  color: Colors.grey,
                  height: 2,
                ),
                //Details 1 (YOUR TRIP)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your trip',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(height: 10),
                    //First row (Edit dates)
                    _detailConatainer(
                      "Dates",
                      _yourTripDays!,
                      "Edit",
                      () {
                        //Open botton sheet to edit dates
                        //The callback function will return the new dates
                        //So i can update the days here
                        openEditDays(
                          context,
                          (dates) {
                            print("RequestToBook - Dates coming: $dates");

                            if (dates.isNotEmpty && dates[0] != null) {
                              if (dates.length > 1 && dates[1] != null) {
                                DateTime start = dates[0]!;
                                DateTime end = dates[1]!;
                                setState(() {
                                  _yourTripDays =
                                      "${monthName(start.month)}  ${start.day}-${end.day}";
                                });
                              } else {
                                setState(() {
                                  _yourTripDays =
                                      "${monthName(dates[0]!.month)}  ${dates[0]!.day}";
                                });
                              }
                            } else {
                              setState(
                                () {
                                  _yourTripDays = "Nov 19 - 24";
                                },
                              );
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    //Second row (Edit guests)
                    _detailConatainer(
                      "Guests",
                      _yourTripGuestsString?.isEmpty == true
                          ? "1 Guest"
                          : _yourTripGuestsString!,
                      "Edit",
                      () {
                        //Open bottom sheet to edit guests
                        openEditGuests(
                          context,
                          (adults, children, infants, pets) {
                            //Update the map that will contain the data to send to the DB here
                            _yourTripGuests = {
                              "adults": adults,
                              "children": children,
                              "infants": infants,
                              "pets": pets,
                            };
                            print(
                                "RequestToBook - Guests coming map: $_yourTripGuests");
                            updateGuestString(adults, children, infants, pets);
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    //Divider
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: Colors.grey,
                  height: 2,
                ),
                const SizedBox(height: 10),
                //Details 2 (PRICE DETAILS)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Price details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    //First row
                    _detailConatainer2(
                        "\$36.99 x $totalNights night", "\$180.6"),
                    const SizedBox(height: 10),
                    //Second row
                    _detailConatainer2(
                        "Special offer", "\$-37.00", Colors.green),
                    const SizedBox(height: 10),
                    _detailConatainer2("Airbnb service fees", "\$25.97"),
                    //Divider
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1),
                      child: Divider(),
                    ),
                    //Total
                    totalContainer(),
                    //Divider
                  ],
                ),
                const SizedBox(height: 10),
                //Divider
                const Divider(
                  color: Colors.grey,
                  height: 2,
                ),
                const SizedBox(height: 10),
                //Pay with
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Column on the left
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Pay with',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        const Text(
                          'Payment methods',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        //Payment methods images
                        Row(
                          children: [
                            Image.network(
                              "https://avpn.asia/wp-content/uploads/2021/10/VISA-logo.png",
                              height: 50,
                              width: 50,
                            ),
                            const SizedBox(width: 10),
                            Image.network(
                              "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/MasterCard_Logo.svg/1280px-MasterCard_Logo.svg.png",
                              height: 50,
                              width: 50,
                            ),
                            const SizedBox(width: 10),
                            Image.network(
                              "https://w7.pngwing.com/pngs/289/163/png-transparent-paypal-business-logo-computer-icons-paypal-blue-text-trademark.png",
                              height: 50,
                              width: 50,
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ],
                    ),
                    //Column on the right
                    Container(
                      width: 55,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            openPayWithModal(context);
                          },
                          child: const Text(
                            "Add",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

//Your trip details
  Row _detailConatainer(
      String dates, String date, String edit, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Column on the left
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dates,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              date,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
        //Column on the right
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onTap,
              child: Text(
                edit,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

//Price details
  Column _detailConatainer2(String leftText, String rigthText,
      [Color color = Colors.black87]) {
    return Column(
      children: [
        //Column on the left
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              leftText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 18,
              ),
            ),
            Text(
              rigthText,
              style: TextStyle(
                color: color,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ],
    );
  }

//Total container
  Column totalContainer() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            Text(
              '\$150.00',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
              ),
            )
          ],
        ),
        SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                //Open total info bottom sheet
                openTotalBottomSheet(context, 3, 100, 300); // default values
              },
              child: Text(
                'More info',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
