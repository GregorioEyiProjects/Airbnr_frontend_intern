import 'dart:async';
//import 'package:airbnbr/views/favorite/user_fav_room%20copy.dart';
import 'package:airbnbr/database/db.dart';
import 'package:airbnbr/injection_containert.dart';
import 'package:airbnbr/model/fav_room_model.dart';
import 'package:airbnbr/model/room_model.dart';
import 'package:airbnbr/model/user_login_model.dart';
import 'package:airbnbr/provider/roomProvider.dart';
import 'package:airbnbr/provider/user_fav_room_provider.dart';
import 'package:flutter/material.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class DisplayPlace extends StatefulWidget {
  final String userId;
  const DisplayPlace({super.key, required this.userId});

  @override
  State<DisplayPlace> createState() => _DisplayPlaceState();
}

class _DisplayPlaceState extends State<DisplayPlace> {
  //final RoomApi roomApi = RoomApi(); //Data coming from the DB
  //final roomApi = locator<RoomApi>();
  final roomApi = locator<ConnectionApi>();

  List<String> favRoomIds = []; // List to hold favorite room IDs
  List<String> favRoomUserIds = []; // List to hold the user favorite room IDs

  //Publib list
  List<String> get generalUserIdsRoom => favRoomUserIds;

  @override
  void initState() {
    super.initState();
    _fetchFavRooms();
  }

// Fetch favorite rooms with the user ID to display the favorite icon in the main screen
  Future<void> _fetchFavRooms() async {
    try {
      print(" DisplayPlace User ID: ${widget.userId}");
      final favRooms = await roomApi.fetchFavRooms(widget.userId ?? '');

      // Set the list i have in the provider with the list i have here
      Provider.of<FavRoomsScreenProvider>(context, listen: false)
          .addFavRooms(favRooms);

      setState(() {
        // Just store the room ID and the user ID in the list
        favRoomIds = favRooms.map((room) => room.roomId).toList();
        favRoomUserIds = favRooms.map((room) => room.userId).toList();
      });
    } catch (e) {
      print("Error fetching favorite rooms: $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //Get the providers
    final favRoomProvider = Provider.of<FavRoomsScreenProvider>(context);
    final roomProvider = Provider.of<RoomProvider>(context);

    return FutureBuilder(
      future: Future.value(roomProvider.rooms), //roomApi.fetchAllRoom(),
      builder: (context, snapshot) {
        print('Snapshot state: ${snapshot.connectionState}');

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          ); // Show loading indicator while waiting for data
        }

        if (snapshot.hasError) {
          String errorMessage = snapshot.error
              .toString(); // Use toString() to convert any error to a string

          return Center(
            child: Text(' DisplayPlace - Error occurred: $errorMessage'),
          );
        }

        if (snapshot.hasData) {
          List<Room> rooms = snapshot.data!;

          return ListView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: rooms.length,
              shrinkWrap: true,
              itemBuilder: (contex, index) {
                //
                Room room = rooms[index];
                print('DisplayPlace RoomID: ${room.id}');

                bool isFavorite = favRoomIds.contains(room.id);
                bool isUserRoom = favRoomUserIds.contains(widget.userId);

                print(
                    'DisplayPlace isFavorite: ${isFavorite}  and userId ${isUserRoom} ');

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GestureDetector(
                    //Navigate to the room details screen
                    onTap: () {
                      GoRouter.of(context).go(
                        '/room_details?userId=${widget.userId}',
                        extra: room,
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: SizedBox(
                                height: 370,
                                width: double.infinity,
                                child: AnotherCarousel(
                                  images: room.roomImages
                                      .map((url) => NetworkImage(url))
                                      .toList(),
                                  dotSize: 6,
                                  indicatorBgPadding: 5,
                                  dotColor: Colors.black26,
                                  dotBgColor: Colors.transparent,
                                ),
                              ),
                            ),

                            //FavoriteGuess container
                            _favoriteGuessContainer(
                                room,
                                context,
                                favRoomProvider,
                                widget.userId,
                                isFavorite,
                                isUserRoom),
                            // Vendor photo
                            _verdorProfile(room),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),
                        Row(
                          children: [
                            Text(room.city,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            const Icon(
                              Icons.star,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(room.rating.toString(),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400)),
                          ],
                        ),
                        Text(
                            'Stay with ${room.vendorName} - ${room.vendorProfession}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400)),
                        Text(
                          room.date,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        RichText(
                          text: TextSpan(
                            text: '${room.price} THB',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            children: const [
                              TextSpan(
                                text: ' /night',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                      ],
                    ),
                  ),
                );
              });
        } else {
          return const Center(
              child: Text(
            'No rooms available',
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )); // Handle case with no data
        }
      },
    ); //stream: _placeController.snapshot() // for Firestore
  }

  Positioned _favoriteGuessContainer(
      Room room,
      BuildContext context,
      FavRoomsScreenProvider provider,
      String userId,
      bool isFavorite,
      bool isUserRoom) {
    return Positioned(
      top: 20,
      right: 15,
      left: 15,
      child: Row(
        children: [
          isFavorite == true && isUserRoom == true
              ? Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Text(
                      "FavoriteGuest",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ),
                )
              : SizedBox(width: MediaQuery.of(context).size.width * 0.03),
          const Spacer(), // To push the icon to the right
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.favorite_outline_rounded,
                color: isFavorite == true && isUserRoom == true ||
                        provider.isExist(room.id) == true
                    ? Colors.red
                    : Colors.white,
                size: 30,
              ),
              InkWell(
                onTap: () async {
                  //room ID coming from the DB Room schema
                  final String roomId = room.id;

                  print('Room ID: $roomId' ' : User ID: $userId');

                  //final roomApi = RoomApi();

                  List<FavRoom> faveRooms = await roomApi.fetchFavRooms(userId);

                  FavRoom? favoriteRoom = faveRooms.firstWhere(
                    (favRoom) => favRoom.roomId == roomId,
                    orElse: () => FavRoom(
                        roomImages: [],
                        roomName: '',
                        id: ' ',
                        userId: '',
                        roomId: ''),
                  );

                  // delete the room from the favorite list if it exists
                  if (favoriteRoom.roomId == roomId) {
                    print("favoriteRoom ID: ${favoriteRoom.id}");

                    final response = await roomApi.deleteFavRoom(
                        userId, favoriteRoom.id, context);
                    if (response.statusCode == 200) {
                      // set the new state in the DB here
                      provider.removeFavorite(roomId);
                      //provider.removeFavorite(favoriteRoom.roomId);
                      print(
                          'Display_Place roomID about to be deleted : ${favoriteRoom.id}');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Failed to delete from favorites")),
                      );
                      print('Failed to delete room from favorites.');
                    }
                  } else {
                    FavRoom newFavRoom = FavRoom(
                        roomImages: [],
                        roomName: ' ',
                        id: ' ',
                        userId: userId,
                        roomId: roomId);
                    await roomApi.addFavRoomToDB(userId, roomId, context);
                    print("What is the newFavRoom: $roomId");
                    provider.toggleFavorite(newFavRoom);
                  }
                },
                child: Icon(
                  Icons.favorite,
                  color: isFavorite == true && isUserRoom == true ||
                          provider.isExist(room.id)
                      ? Colors.red
                      : Colors.black26,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Positioned _verdorProfile(Room room) {
    return Positioned(
      bottom: 11,
      left: 15,
      right: 15,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
                10), //BorderRadius.only( bottomRight: Radius.circular(16),topRight: Radius.circular(16)),
            child: Image.network(
                "https://img.freepik.com/free-photo/abstract-surface-textures-white-concrete-stone-wall_74190-8189.jpg",
                height: 60,
                width: 60,
                fit: BoxFit.cover),
          ),
          Positioned(
            bottom: 11,
            left: 10,
            child: CircleAvatar(
              backgroundImage: NetworkImage(room.authorImage),
            ),
          ),
        ],
      ),
    );
  }
}
