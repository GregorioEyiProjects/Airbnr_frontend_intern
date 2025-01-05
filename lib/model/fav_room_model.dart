class FavRoom {
  String id;
  String roomName; // Room name as a property
  String userId;
  String roomId;
  List<String> roomImages;

  FavRoom({
    required this.id, // MongoDB ID
    required this.roomName,
    required this.roomImages,
    required this.userId,
    required this.roomId,
  });

  factory FavRoom.fromJson(Map<String, dynamic> json) {
    var room = json['roomId']['data'];
    return FavRoom(
      id: json['_id'],
      roomName: room['name'],
      roomImages: List<String>.from(room['roomImages'] ?? []),
      userId: json['userId'],
      roomId: json['roomId']['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'roomName': roomName,
      'userId': userId,
      'roomId': roomId,
      'roomImages': roomImages,
    };
  }
}
