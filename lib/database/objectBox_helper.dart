// Function to check if user is logged in and retrieve favorite rooms
import 'package:flutter/material.dart'; // BuildContext class
import 'package:airbnbr/database/object_box_model/entities/userFavRooms.dart'; // UserFavOB
import 'package:airbnbr/main.dart'; // objectBoxdb
import 'package:airbnbr/model/fav_room_model.dart'; // FavRoom
import 'package:airbnbr/objectbox.g.dart'; // Store class
import 'package:airbnbr/provider/user_fav_room_provider.dart'; // FavRoomsScreenProvider
import 'package:provider/provider.dart'; // Provider class

//Function to add a favorite room to the ObjectBox database
void addFavRoomToOB(BuildContext context, List<FavRoom> favRooms) {
  Store store = objectBoxdb.store;

  //Get the FavUserIds first, just to make sure we don't add the same room twice
  final existingFavUserIds = store
      .box<UserFavOB>()
      .query()
      .build()
      .find()
      .map((room) => room.mongosFavRoomId)
      .toSet();

  try {
    store.runInTransaction(TxMode.write, () {
      for (var favRoom in favRooms) {
        if (!existingFavUserIds.contains(favRoom.id)) {
          print(
              'Helper Room does not exist, so adding favorite room with ID: ${favRoom.id}');
          //Create a new UserFavoriteRooms object
          final userFavoriteRooms = UserFavOB(
            null,
            DateTime.now(),
            mongosFavRoomId: favRoom.id, // MongoDB ID
            roomName: favRoom.roomName,
            userId: favRoom.userId,
            roomId: favRoom.roomId,
            roomImages: favRoom.roomImages,
          );
          //Add the UserFavoriteRooms object to the store
          store.box<UserFavOB>().put(userFavoriteRooms);
        } else {
          print(
              'Helper Room already exists, so not adding favorite room with ID: ${favRoom.id}');
        }
      }
    });
  } catch (err) {
    debugPrint("Error while adding favorite rooms: $err");
  }
}

//Function to check if user is logged in and retrieve favorite rooms
void retrieveFavRooms(BuildContext context, String currentUserId) {
  if (currentUserId != null) {
    //Open the ObjectBox store
    Store store = objectBoxdb.store;
    // Retrieve favorite rooms from the ObjectBox database
    final favRooms = store
        .box<UserFavOB>()
        .query(UserFavOB_.userId.equals(currentUserId))
        .build()
        .find();

    List<FavRoom> favRoomsOBList = [];

    // Add the favorite rooms to the favorite room provider list
    favRooms.forEach((favRoom) {
      // Create a new FavRoom object
      final favRoomsOB = FavRoom(
        id: favRoom.mongosFavRoomId, // MongoDB ID
        roomName: favRoom.roomName,
        roomImages: favRoom.roomImages,
        userId: favRoom.userId,
        roomId: favRoom.roomId,
      );

      // Add the FavRoom object to the list
      favRoomsOBList.add(favRoomsOB);

      //print('Helper FavRooms: ${favRoomsOBList[0].id}');

      //Add it to the favorite room provider list
      Provider.of<FavRoomsScreenProvider>(context, listen: false)
          .addFavRooms(favRoomsOBList);
    });
  } else {
    //If the user is not logged in, clear the favorite room list
    //Provider.of<FavRoomsScreenProvider>(context, listen: false).addFavRooms([]);
    if (currentUserId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Curent user is not logged in",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      );
    }
  }
}
