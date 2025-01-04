import 'package:airbnbr/database/object_box_model/entities/RoomLocationOBModel.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';

@Entity()
class RoomOB {
  @Id(assignable: true)
  int? id; // Unique ID for Room
  String mongoRoomId; // Unique ID from MongoDB
  String name;
  double price;
  double rating;
  int bedNumbers;
  int? reviewNumbers;
  List<String> roomImages;
  String vendorName;
  int yearsHosting;
  String vendorProfession;
  String authorImage;
  String city;
  String date;
  bool active;
  String description;
  // In ObjectBox, you can store the location data as a ToOne<Location>
  final localtionData = ToOne<RoomLocationOB>();
  DateTime avaibleStartTime;
  DateTime avaibleEndTime;
  String stayFor;
  String stayOn;
  bool petsAllowed;
  int maxAdults;
  int maxChildren;
  int maxInfants;
  //String hostId; // In ObjectBox, you can store the host's ID as a String

  RoomOB({
    this.id,
    required this.mongoRoomId,
    required this.name,
    required this.price,
    required this.rating,
    required this.bedNumbers,
    this.reviewNumbers,
    required this.roomImages,
    required this.vendorName,
    required this.yearsHosting,
    required this.vendorProfession,
    required this.authorImage,
    required this.city,
    required this.date,
    required this.active,
    required this.description,
    required this.avaibleStartTime,
    required this.avaibleEndTime,
    required this.stayFor,
    required this.stayOn,
    required this.petsAllowed,
    required this.maxAdults,
    required this.maxChildren,
    required this.maxInfants,
  });

  factory RoomOB.fromJson(
      Map<String, dynamic> json, Box<RoomLocationOB> locationBox) {
    // Parse the available start and end time
    final availableStartTime = json['data']['avaibility']?['startTime'] != null
        ? DateTime.tryParse(json['data']['avaibility']['startTime'])
        : DateTime(1970); // Default or fallback value
    final availableEndTime = json['data']['avaibility']?['endTime'] != null
        ? DateTime.tryParse(json['data']['avaibility']['endTime'])
        : DateTime(1970); // Default or fallback value

    final locations = json['data']['locations'] ?? {};
    final availbleStart = json['data']['avaibility']['startTime'] ?? '';
    final availbleEnd = json['data']['avaibility']['endTime'] ?? '';
    final location = RoomLocationOB(
      mongoRoomId: json['_id'] ?? 'Unnamed id',
      latitude: locations['latitude'] != null
          ? (locations['latitude'] as num).toDouble()
          : 0.0, // Safely parse latitude
      longitude: locations['longitude'] != null
          ? (locations['longitude'] as num).toDouble()
          : 0.0, // Safely parse longitude
    );

    // Save the location to ObjectBox before creating the room cus
    // the room will need the location to be saved in the database before it can be linked to it
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
      city: json['data']['location'] ?? '',
      date: json['data']['date'] ?? '',
      active: json['data']['active'] ?? false,
      description: json['data']['description'] ?? '',
      avaibleStartTime: availableStartTime ?? DateTime(1970),
      avaibleEndTime: availableEndTime ?? DateTime(1970),
      stayFor: json['data']['stayFor'] ?? 'Weekend',
      stayOn: json['data']['stayOn'] ?? 'Anytime',
      petsAllowed: json['data']['petsAllowed'] ?? false,
      maxAdults: json['data']['maxAdults'] ?? 0,
      maxChildren: json['data']['maxChildren'] ?? 0,
      maxInfants: json['data']['maxInfants'] ?? 0,
    );

    room.localtionData.target = location; // Link the location to the room

    return room;
  }
}
