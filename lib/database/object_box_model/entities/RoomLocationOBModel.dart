import 'package:objectbox/objectbox.dart';

@Entity()
class RoomLocationOB {
  @Id(assignable: true)
  int? id;
  String mongoRoomId;
  double latitude;
  double longitude;

  RoomLocationOB(
      {this.id,
      required this.mongoRoomId,
      required this.latitude,
      required this.longitude});
}
