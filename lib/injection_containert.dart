import 'package:airbnbr/database/db.dart';
import 'package:airbnbr/database/objectBoxDB.dart';
import 'package:airbnbr/database/object_box_model/OBinit/MyObjectBox.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> setupLocator(Objectboxdb objectbox) async {
  //final MyObjectBox box = await MyObjectBox.init();
  print('Setting up locator');
  locator.registerSingleton<RoomApi>(RoomApi(objectbox));
  print('Done setting up locator');
}
