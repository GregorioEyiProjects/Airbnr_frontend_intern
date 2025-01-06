// Function to check if user is logged in and retrieve favorite rooms
import 'package:airbnbr/database/object_box_model/entities/RoomOBModel.dart';
import 'package:airbnbr/database/object_box_model/entities/UserOBModel.dart';
import 'package:airbnbr/model/room_model.dart';
import 'package:airbnbr/model/user_login_model.dart';
import 'package:flutter/material.dart'; // BuildContext class
import 'package:airbnbr/database/object_box_model/entities/userFavRooms.dart'; // UserFavOB
import 'package:airbnbr/main.dart'; // objectBoxdb
import 'package:airbnbr/model/fav_room_model.dart'; // FavRoom
import 'package:airbnbr/objectbox.g.dart'; // Store class
import 'package:airbnbr/provider/user_fav_room_provider.dart'; // FavRoomsScreenProvider
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Provider class

Store store = objectBoxdb.store;

//Function to add a favorite room to the ObjectBox database
//It excetuets when the logs in.
void addFavRoomToOB(BuildContext context, List<FavRoom> favRooms) {
  //Store store = objectBoxdb.store;

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

//Function to add a new fav into the ObjectBox database
//It exceutes when the user clicks on the favorite icon
void addNewFavRoom(BuildContext context, FavRoom favRoom) {
  //Store store = objectBoxdb.store;

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
  int id = store.box<UserFavOB>().put(userFavoriteRooms);

  //Get the id of the inserted object
  final roomInsertedId = store.box<UserFavOB>().get(id);
  print(
      'Helper - addNewFavRoom - new inserted room with ID: ${roomInsertedId!.mongosFavRoomId}');

//Add the favorite room to the favorite room provider list
  Provider.of<FavRoomsScreenProvider>(context, listen: false)
      .toggleFavorite(favRoom);
}

//Function to check if user is logged in and retrieve favorite rooms
void retrieveFavRooms(BuildContext context, String currentUserId) {
  if (currentUserId != null) {
    //Open the ObjectBox store
    //Store store = objectBoxdb.store;
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

//Function to insert a user coming from the backend to the ObjectBox database
Future<void> insertUserComingFromBackendLocally(
    BuildContext context, UserLogin user) async {
  print('Helper: inserting user coming from backend locally');

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final user_ = UserOB(
    mongoUserId: user.id,
    firstName: user.firstName,
    lastName: user.lastName,
    dateOfBirth: user.dateOfBirth,
    contact: user.contact,
    email: user.email,
    password: user.password,
    role: user.role,
    profileImage: user.profileImage,
    createdAt: user.createdAt,
    updatedAt: user.updatedAt,
  );

  // Check if the user exists by contact
  final userExistsWithContact = store
      .box<UserOB>()
      .query(UserOB_.contact.equals(user.contact))
      .build()
      .find();

  // Check if the user exists by email
  final userExistsWithEmail = store
      .box<UserOB>()
      .query(UserOB_.email.equals(user.email))
      .build()
      .find();

  // variable to store the user ID
  int userIDob = -1;

  if (userExistsWithContact.isEmpty && userExistsWithEmail.isEmpty) {
    // Insert the user in the ObjectBox if he does not exist and assign the user ID
    userIDob = store.box<UserOB>().put(user_);
    //Save temp user ID in SharedPreferences
    await prefs.setInt('userOB_id', userIDob);
    //print('DB - loginWithContact_ inserted and his ID is : $userIDob');
  } else {
    // Assign userIDob based on which user exists
    if (userExistsWithContact.isNotEmpty) {
      userIDob = userExistsWithContact.first.id!;
      //print('DB - loginWithContact_ userExistsWithContact ID: $userIDob');
    } else if (userExistsWithEmail.isNotEmpty) {
      userIDob = userExistsWithEmail.first.id!;
      //print('DB - loginWithContact_ userExistsWithEmail ID: ${userIDob}');
    }

    // Save temp user ID in SharedPreferences
    await prefs.setInt('userOB_id', userIDob);
  }

  //Get the user (Delete later on) it's for testing purposes
  final userInserted = store.box<UserOB>().get(userIDob);
  print(
      'Helper - insertUserComingFromBackendLocally - inserted user contact: ${userInserted!.contact}');
}

//Function to insert all rooms coming from the backend to the ObjectBox database
Future<void> inserAllRoomsComingFromBackendLocally(List<Room> rooms) async {
  print('Helper: inserting all rooms coming from backend locally');

  //Store store = objectBoxdb.store;

  //Get the FavUserIds first, just to make sure we don't add the same room twice
  //Get the existing roomsId from the ObjectBox and converting them to a Set
  final existingRooms =
      store.box<RoomOB>().getAll().map((room) => room.mongoRoomId).toSet();

  // runInTransaction: It ensures atomicity, consistency, and efficiency for multiple database operations.
  // TxMode.write is used for transactions that modify the database.

  try {
    store.runInTransaction(TxMode.write, () {
      for (var room in rooms) {
        if (!existingRooms.contains(room.id)) {
          print(
              "Helper - No rooms yet, so inserting in the ObjectBox room with ID: ${room.id}");

          //Ceate a room
          final roomOB = RoomOB(
            mongoRoomId: room.id,
            name: room.name,
            price: room.price,
            rating: room.rating,
            bedNumbers: room.bedNumbers,
            reviewNumbers: room.reviewNumbers,
            roomImages: room.roomImages,
            vendorName: room.vendorName,
            yearsHosting: room.yearsHosting,
            vendorProfession: room.vendorProfession,
            authorImage: room.authorImage,
            city: room.city,
            date: room.date,
            active: room.active,
            description: room.description,
            avaibleStartTime: room.availability['startTime'] ?? DateTime(1970),
            avaibleEndTime: room.availability['endTime'] ?? DateTime(1970),
            stayFor: room.stayFor,
            stayOn: room.stayOn,
            petsAllowed: room.petsAllowed,
            maxAdults: room.maxAdults,
            maxChildren: room.maxChildren,
            maxInfants: room.maxInfants,
          );

//Insert the room in the ObjectBox
          final id = store.box<RoomOB>().put(roomOB);
          print('DB fetchAllRoom - room inserted in ObjectBox with ID: $id');
        } else {
          print(
              'Helper Room already exists, so not adding room with ID: ${room.id}');
        }
      }
    });
  } catch (err) {
    debugPrint("Error while adding favorite rooms: $err");
  }
}

//Function to delete a favorite room from the ObjectBox database
//It executes when the user clicks on the favorite icon
Future<void> deleteFavRoomFromOB(
    BuildContext context, String userId, String favRoomId) async {
//Query
  final query = store
      .box<UserFavOB>()
      .query(UserFavOB_.mongosFavRoomId.equals(favRoomId) &
          UserFavOB_.userId.equals(userId))
      .build();

  final favRoomExists = query.find().isNotEmpty;
  print(
      'Helper - deleteFavRoomFromOB - room exists in the ObjectBox: $favRoomExists');

  if (!favRoomExists) {
    print(
        'Helper - deleteFavRoomFromOB - room does not exist in the ObjectBox');
    //Let the user know something went wrong
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Locally fav room does not exist in favorites",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  //Get the favorite room to delete
  final favRoomToDelete = query.find().first;
  if (favRoomToDelete != null) {
    store.box<UserFavOB>().remove(favRoomToDelete.id!);
    print(
        'Helper - deleteFavRoomFromOB - room deleted with FavID: ${favRoomToDelete.mongosFavRoomId}');
    // Remove the favorite room from the favorite room provider list
    //Provider.of<FavRoomsScreenProvider>(context, listen: false).removeFavorite(favRoomId);
  } else {
    print('Helper - deleteFavRoomFromOB - room not found for deletion');
  }
}
