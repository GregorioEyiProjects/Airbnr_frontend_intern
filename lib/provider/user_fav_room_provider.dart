import 'package:airbnbr/database/db.dart';
import 'package:airbnbr/injection_containert.dart';
import 'package:airbnbr/model/fav_room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FavRoomsScreenProvider extends ChangeNotifier {
  List<FavRoom> _favRoomIds = [];
  List<FavRoom> get favRoomIdList => _favRoomIds;

//To toggle the state of the user's favorite rooms
  void toggleFavorite(FavRoom favRoom) {
    if (_favRoomIds.contains(favRoom)) {
      _favRoomIds.remove(favRoom);
      print('FavRoomsScreenProvider - Removed: ${favRoom.roomId}');
    } else {
      _favRoomIds.add(favRoom);
      print('Added to favorites: ${favRoom.roomId}');
    }
    notifyListeners();
  }

  //check if there is a room in the favorite list and return true or false
  bool isExist(String roomId) {
    return _favRoomIds.any((favRoom) => favRoom.roomId == roomId);
  }

//to get the favorite room id
  String getFavRoomId(String roomId) {
    return _favRoomIds.firstWhere((favRoom) => favRoom.roomId == roomId).id;
  }

//to load the favorite rooms once the app starts
  void addFavRooms(List<FavRoom> favRooms) {
    _favRoomIds = favRooms;
    notifyListeners();
  }

//to remove the favorite room and display the updated list
  void removeFavorite(String roomId) {
    _favRoomIds.removeWhere((favRoom) => favRoom.roomId == roomId);
    print('Current favorites after removal: $_favRoomIds');
    notifyListeners();
  }

  Future<void> addFavRoomInDB(String userID, String roomID, context) async {
    try {
      //RoomApi roomApi = RoomApi();
      final roomApi = locator<ConnectionApi>();
      await roomApi.addFavRoomToDB(userID, roomID, context);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    notifyListeners();
  }

  Future<void> deleteFavRoomInDB(String userID, String roomID, context) async {
    try {
      //RoomApi roomApi = RoomApi();
      final roomApi = locator<ConnectionApi>();

      final response = await roomApi.deleteFavRoom(userID, roomID, context);
      if (response.statusCode == 200) {
//        removeFavorite(roomID);
        notifyListeners();
      } else {
        print('Failed to delete room from favorites.');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    notifyListeners();
  }

  //Clear the favorite rooms list when the user logs out
  void clearFavRooms() {
    _favRoomIds.clear();
    notifyListeners();
  }
}
