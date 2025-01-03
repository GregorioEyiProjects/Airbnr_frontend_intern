import 'package:objectbox/objectbox.dart';

@Entity()
class LocationOB {
  @Id(assignable: true)
  int? id;
  String mongoRoomId;
  double latitude;
  double longitude;

  LocationOB(
      {this.id,
      required this.mongoRoomId,
      required this.latitude,
      required this.longitude});
}
