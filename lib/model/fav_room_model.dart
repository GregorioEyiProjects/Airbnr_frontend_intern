class FavRoom {
  final String id;
  final String userId;
  final String roomId;
  final String roomName; // Room name as a property
  final List<String> roomImages;

  FavRoom(
    this.roomImages,
    this.roomName, {
    required this.id,
    required this.userId,
    required this.roomId,
  });

/*   factory FavRoom.fromJson(Map<String, dynamic> json) {
    var room = json['room']['data']; // to reach the 'Images' object
    return FavRoom(
      id: json['_id'],
      userId: json['user'],
      roomId: json['room']['_id'],
      room['roomImages'] != null ? List<String>.from(room['roomImages']) : [],
    );
  } */

  factory FavRoom.fromJson(Map<String, dynamic> json) {
    var room = json['room']['data']; // to reach the 'Images' object
    return FavRoom(
      List<String>.from(room['roomImages'] ?? []), // Room images list
      room['name'], // Room name as a positional argument
      id: json['_id'], // Required named parameters
      userId: json['user'],
      roomId: json['room']['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'roomId': roomId,
      'roomImages': roomImages,
    };
  }
}
