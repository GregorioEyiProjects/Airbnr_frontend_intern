import 'dart:convert';

import 'package:airbnbr/components/descriptionLocation.dart';
import 'package:airbnbr/components/icon_button.dart';
import 'package:airbnbr/components/star_rating.dart';
import 'package:airbnbr/injection_containert.dart';
import 'package:airbnbr/model/fav_room_model.dart';
import 'package:airbnbr/provider/user_fav_room_provider.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:airbnbr/database/db.dart';
import 'package:airbnbr/model/room_model.dart';
import 'package:provider/provider.dart';

class RoomDetails extends StatefulWidget {
  final Room room;
  final String? userId;

  //final Map<String, dynamic> room;
  const RoomDetails({super.key, required this.room, this.userId});

  @override
  State<RoomDetails> createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  int _current = 0;
  late final List<String> roomImages;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    roomImages = List<String>.from(widget.room.roomImages);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _roomImages(size, widget.userId, context),
            roomInfoBellowImages(size),
            widget.room.active == true
                ? _activeContainerTrue()
                : _activeContainerFalse(),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _propertyInfo(
                      size,
                      'https://i.pinimg.com/originals/14/96/03/149603e24cfdd7db3ea0597bcff78359.png',
                      'This is rare to find',
                      "${widget.room.vendorName}'s place is usually fully booked."),
                  _propertyInfo(
                      size,
                      widget.room.authorImage ??
                          'https://cdn1.iconfinder.com/data/icons/user-interface-664/24/User-512.png',
                      'Room in a rental unit',
                      "Your own room in the house, plus \naccess to share places."),
                  _propertyInfo(
                      size,
                      'https://cdn-icons-png.flaticon.com/512/6192/6192020.png',
                      'Stay with ${widget.room.vendorName}',
                      "Superhot. ${widget.room.yearsHosting} years hosting."),
                  _propertyInfo(
                      size,
                      'https://cdn0.iconfinder.com/data/icons/co-working/512/coworking-sharing-17-512.png',
                      'Share common spaces',
                      "You'll share part of the house with \nthe host."),
                  SizedBox(height: size.height * 0.02),
                  const Divider(),
                  const Text(
                    'About this place',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.room.description,
                    maxLines: 10,
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis),
                  ),
                  const Divider(),
                  const Text(
                    "Where you'll be",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.room.city,
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 400,
                    width: size.height,
                    child:
                        const Center(), //Descriptionlocation(location: widget.room['location']), //change this later on
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _reserverRoon(size),
    );
  }

  Container _reserverRoon(Size size) {
    return Container(
      height: size.height * 0.1,
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
              RichText(
                text: TextSpan(
                  text: '\$${widget.room.price.toString()}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: const [
                    TextSpan(
                      text: '/ Night',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                widget.room.date,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decoration: TextDecoration.underline),
              ),
            ],
          ),
          const Spacer(),
          //Navigate to the request to book screen
          InkWell(
            onTap: () {
              final userId = widget.userId;
              final room = widget.room;
              GoRouter.of(context)
                  .go('/request_to_book?userId=$userId', extra: room);
            },
            child: const _Resrvebtn(),
          ),
          const SizedBox(width: 16)
        ],
      ),
    );
  }

  Stack _roomImages(Size size, userID, BuildContext context) {
    final provider = Provider.of<FavRoomsScreenProvider>(context);
    return Stack(
      children: [
        SizedBox(
          height: size.height * 0.35,
          child: AnotherCarousel(
            images: roomImages.map((e) => NetworkImage(e)).toList(),
            showIndicator: false,
            dotBgColor: Colors.black12,
            onImageChange: (p0, p1) => {
              setState(() {
                _current = p1;
              })
            },
            autoplay: true,
            boxFit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black26,
            ),
            child: Text(
              "${_current + 1}/${roomImages.length}",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        Positioned(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Arrow back button to the home screen
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    //GoRouter.of(context).go('/home_screen');
                  },
                  child: const IconCustomButton(
                    icon: Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                const SizedBox(width: 7),
                const IconCustomButton(
                  icon: Icons.share_outlined,
                  color: Colors.white,
                ),
                const SizedBox(width: 20),
                //Favorite button
                _handleFavIconInkWell(provider, context)
              ],
            ),
          ),
        ),
      ],
    );
  }

  InkWell _handleFavIconInkWell(
      FavRoomsScreenProvider provider, BuildContext context) {
    return InkWell(
      onTap: () async {
        final roomID = widget.room.id;
        final userID = widget.userId;
        //RoomApi roomApi = RoomApi();
        //final roomApi = locator<RoomApi>();
        //final roomApi = locator<ConnectionApi>();

        print('RoomDetails Room ID: $roomID, User ID: $userID');

        try {
          if (provider.isExist(roomID)) {
            //Get the favorite rooms from the provider
            List<FavRoom> faveRoomsProvider = provider.favRoomIdList;

            if (faveRoomsProvider.isNotEmpty) {
              print(
                  'DisplayPlace - faveRoomsProvider rooms and room ID is: ${faveRoomsProvider.first.id}');
            } else {
              print('DisplayPlace - faveRoomsProvider is empty');
            }
            //final response = await roomApi.fetchFavRooms(userID!);
            FavRoom? favRoom = faveRoomsProvider.firstWhere(
              (element) => element.roomId == roomID,
              orElse: () => FavRoom(
                roomName: '',
                roomImages: [],
                id: ' ',
                userId: '',
                roomId: '',
              ),
            );

            if (favRoom.id != ' ') {
              print('RoomDetails Room_ID: $roomID, User ID: $userID');
              //remove the room from the database
              final response = await provider.deleteFavRoomInDB(
                  favRoom.id, userID!, context);
              if (response.statusCode == 200) {
                //remove the room from the provider list
                provider.removeFavorite(roomID);
              }
            }
          } else {
            //remove the room from the database
            await provider.addFavRoomInDB(userID!, roomID, context);

            //add the room to the provider list
            //provider.toggleFavorite(newFavRoom);
          }
        } catch (e) {
          print(e);
        }
      },
      child: Icon(Icons.favorite,
          color: provider.isExist(widget.room.id!) ? Colors.red : Colors.white,
          size: 35),
    );
  }

  Padding roomInfoBellowImages(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.room.name ?? 'Default name',
            maxLines: 2,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              height: 1.2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Text(
            'Room in ${widget.room.city ?? 'Default city'}',
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54),
          ),
          Text(
            '${widget.room.bedNumbers ?? '0/0'} bedrooms',
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Padding _propertyInfo(Size size, image, title, subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Divider(),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(image),
                  radius: 30,
                ),
                SizedBox(width: size.width * 0.02),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        subtitle,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                          fontSize: size.width * 0.0345,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _activeContainerTrue() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                widget.room.rating.toString() ?? '0.0',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              StarRating(rating: widget.room.rating),
            ],
          ),
          Stack(
            children: [
              Image.network(
                'https://wallpapers.com/images/high/golden-laurel-wreath-graphic-ltz1obp363nwlcxe-ltz1obp363nwlcxe.png',
                height: 50,
                width: 130,
                color: Colors.amber,
              ),
              const Positioned(
                top: 2,
                left: 37,
                child: Text(
                  'Guests\nFavorite',
                  style: TextStyle(
                    height: 1.5,
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 9,
          ),
          Column(
            children: [
              Text(
                widget.room.reviewNumbers.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Text(
                'Reviews',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  height: 0.7,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding _activeContainerFalse() {
    // ignore: prefer_const_constructors
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.star,
            color: Colors.red,
          ),
          const SizedBox(width: 10),
          Text(
            "${widget.room.rating.toString()} ",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            "  .${widget.room.reviewNumbers.toString()} reviews",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}

class _Resrvebtn extends StatelessWidget {
  const _Resrvebtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        "Reserve",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
