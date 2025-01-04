import 'package:airbnbr/model/room_model.dart';
import 'package:flutter/material.dart';

class RoomProvider with ChangeNotifier {
  List<Room> _rooms = [];

  //public getter
  List<Room> get rooms => _rooms;

  void addRooms(List<Room> rooms) {
    _rooms = rooms;
    notifyListeners();
  }
}
