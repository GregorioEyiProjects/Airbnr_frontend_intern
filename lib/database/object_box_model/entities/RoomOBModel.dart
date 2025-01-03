import 'package:airbnbr/database/object_box_model/entities/Location_O_Box.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';

@Entity()
class RoomOB {
  @Id(assignable: true)
  int? id; // Unique ID for Room
  String mongoRoomId;
  String name;
  double price;
  double? rating;
  int bedNumbers;
  int? reviewNumbers;
  List<String> roomImages;
  String vendorName;
  int yearsHosting;
  String vendorProfession;
  String authorImage;
  String locationName;
  DateTime date;
  bool isActive;
  String? description;
  // In ObjectBox, you can store the location data as a ToOne<Location>
  final localtionData = ToOne<LocationOB>();

  //String hostId; // In ObjectBox, you can store the host's ID as a String

  RoomOB({
    this.id,
    required this.mongoRoomId,
    required this.name,
    required this.price,
    this.rating,
    required this.bedNumbers,
    this.reviewNumbers,
    required this.roomImages,
    required this.vendorName,
    required this.yearsHosting,
    required this.vendorProfession,
    required this.authorImage,
    required this.locationName,
    required this.isActive,
    this.description,
    required this.date,
  });

// Factory method to create a Room from JSON
  factory RoomOB.fromJson(
      Map<String, dynamic> json, Box<LocationOB> locationBox) {
    final locations = json['data']['locations'] ?? {};
    final location = LocationOB(
      mongoRoomId: json['_id'] ?? 'Unnamed id',
      latitude: locations['latitude'] != null
          ? (locations['latitude'] as num).toDouble()
          : 0.0, // Safely parse latitude
      longitude: locations['longitude'] != null
          ? (locations['longitude'] as num).toDouble()
          : 0.0, // Safely parse longitude
    );

    // Save the location to ObjectBox
    locationBox.put(location);

    final room = RoomOB(
      id: null,
      mongoRoomId: json['_id'] ?? 'Unnamed id',
      name: json['data']['name'] ?? '',
      price: json['data']['price'] != null
          ? (json['data']['price'] as num).toDouble()
          : 0.0, // Safely parse price
      rating: json['data']['rating'] != null
          ? (json['data']['rating'] as num).toDouble()
          : 0.0, // Safely parse rating
      bedNumbers: json['data']['bedNumbers'] ?? 0,
      reviewNumbers: json['data']['reviewNumbers'] ?? 0,
      roomImages: List<String>.from(json['data']['roomImages'] ?? []),
      vendorName: json['data']['vendorName'] ?? '',
      yearsHosting: json['data']['yearsHosting'] ?? 0,
      vendorProfession: json['data']['vendorProfession'] ?? '',
      authorImage: json['data']['authorImage'] ?? '',
      locationName: json['data']['location'] ?? '',
      date: json['data']['date'] ?? '',
      isActive: json['data']['isActive'] ?? false,
      description: json['data']['description'] ?? '',
    );

    room.localtionData.target = location; // Link the location to the room

    return room;
  }
}
