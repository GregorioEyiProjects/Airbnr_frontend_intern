import 'package:airbnbr/components/star_rating.dart';
import 'package:airbnbr/database/object_box_model/entities/RoomOBModel.dart';
import 'package:airbnbr/database/object_box_model/entities/UserOBModel.dart';
import 'package:airbnbr/main.dart';
import 'package:airbnbr/model/fav_room_model.dart';
import 'package:airbnbr/objectbox.g.dart';
import 'package:airbnbr/provider/user_fav_room_provider.dart';
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:provider/provider.dart';

@Entity()
class UserFavOB {
  @Id(assignable: true)
  int? id;
  String mongosFavRoomId; // MongoDB ID

  // Store the IDs of the user and room
  final String roomName;
  final String userId;
  final String roomId;
  final List<String> roomImages;
  DateTime createdAt;

  UserFavOB(
    this.id,
    this.createdAt, {
    required this.mongosFavRoomId,
    required this.roomName,
    required this.userId,
    required this.roomId,
    required this.roomImages,
  });
}
