import 'package:airbnbr/database/object_box_model/entities/RoomLocationOBModel.dart';
import 'package:airbnbr/database/object_box_model/entities/UserOBModel.dart';
import 'package:airbnbr/database/object_box_model/entities/userFavRooms.dart';
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:airbnbr/database/object_box_model/entities/RoomOBModel.dart';
import '../../../../objectbox.g.dart';

class MyObjectBox {
  late final Store _store;
  late final Box<RoomOB> _roomBox;
  late final Box<UserOB> _userBox;
  late final Box<RoomLocationOB> locationBox;
  late final Box<UserFavOB> userFavoriteRooms;

  MyObjectBox._init(this._store) {
    _roomBox = Box<RoomOB>(_store);
    _userBox = Box<UserOB>(_store);
    locationBox = Box<RoomLocationOB>(_store);
    userFavoriteRooms = Box<UserFavOB>(_store);
    print('MyObjectBox initialized');
  }

  static Future<MyObjectBox> init() async {
    try {
      final dir = await path_provider.getApplicationDocumentsDirectory();
      final store = await openStore(directory: dir.path);
      print('ObjectBox store opened');
      return MyObjectBox._init(store);
    } catch (e) {
      debugPrint('Error initializing ObjectBox: $e');
      rethrow;
    }
  }

// -----   Rooms     ------

  RoomOB? getRoom(int roomID) {
    return _roomBox.get(roomID);
  }

  int insertRoom(RoomOB room) => _roomBox.put(room);

  Stream<List<RoomOB>> getRooms() => _roomBox
      .query()
      .watch(triggerImmediately: true)
      .map((query) => query.find());

  bool deleteRoom(int roomID) => _roomBox.remove(roomID);

  //  -----   Users     ------

  UserOB? getUser(String userID) {
    return _userBox.get(int.parse(userID));
  }

  int insertUser(UserOB user) => _userBox.put(user);

  Stream<List<UserOB>> getUsers() => _userBox
      .query()
      .watch(triggerImmediately: true)
      .map((query) => query.find());

  bool deleteUser(int userID) => _userBox.remove(userID);
}
