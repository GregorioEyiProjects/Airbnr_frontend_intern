import 'package:airbnbr/database/object_box_model/entities/RoomOBModel.dart';
import 'package:airbnbr/database/object_box_model/entities/UserOBModel.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class UserFavoriteRooms {
  @Id(assignable: true)
  int? id; // Unique ID for UserFavRoom

  // Store the IDs of the user and room
  final int userId;
  final int roomId;
  DateTime createdAt;

  UserFavoriteRooms({
    this.id,
    required this.userId,
    required this.roomId,
    required this.createdAt,
  });
}
