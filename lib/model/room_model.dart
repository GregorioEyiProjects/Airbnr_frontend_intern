class Room {
  final String id;
  final String name;
  final double price;
  final double rating;
  final int bedNumbers;
  final int reviewNumbers;
  final List<String> roomImages;
  final String vendorName;
  final int yearsHosting;
  final String vendorProfession;
  final String authorImage;
  final String location;
  final String date;
  final bool isActive;
  final String description;
  final Map<String, double> locations;

  // Constructor
  Room({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.bedNumbers,
    required this.reviewNumbers,
    required this.roomImages,
    required this.vendorName,
    required this.yearsHosting,
    required this.vendorProfession,
    required this.authorImage,
    required this.location,
    required this.date,
    required this.isActive,
    required this.description,
    required this.locations,
  });

  // Factory method to create a Room from JSON
  factory Room.fromJson(Map<String, dynamic> json) {
    final locations = json['data']['locations'] ?? {};
    return Room(
      id: json['_id'] ?? 'Unnamed id',
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
      location: json['data']['location'] ?? '',
      date: json['data']['date'] ?? '',
      isActive: json['data']['isActive'] ?? false,
      description: json['data']['description'] ?? '',
      locations: {
        'latitude': (locations['latitude'] != null
            ? (locations['latitude'] as num).toDouble()
            : 0.0),
        'longitude': (locations['longitude'] != null
            ? (locations['longitude'] as num).toDouble()
            : 0.0),
      },
    );
  }

  factory Room.fromJson2(Map<String, dynamic> json) {
    // Accessing the nested room data
    var roomData = json['room']['data']; // Accessing the nested 'data' object

    return Room(
      id: json['_id'] ?? 'Unnamed id',
      name: roomData['name'] ?? '',
      price: roomData['price'] != null
          ? (roomData['price'] as num).toDouble()
          : 0.0,
      rating: roomData['rating'] != null
          ? (roomData['rating'] as num).toDouble()
          : 0.0,
      bedNumbers: roomData['bedNumbers'] ?? 0,
      reviewNumbers: roomData['reviewNumbers'] ?? 0,
      roomImages: List<String>.from(roomData['roomImages'] ?? []),
      vendorName: roomData['vendorName'] ?? '',
      yearsHosting: roomData['yearsHosting'] ?? 0,
      vendorProfession: roomData['vendorProfession'] ?? '',
      authorImage: roomData['authorImage'] ?? '',
      location: roomData['location'] ?? '',
      date: roomData['date'] ?? '',
      isActive: roomData['active'] ?? false,
      description: roomData['description'] ?? '',
      locations: {
        'latitude': (roomData['locations']['latitude'] != null
            ? (roomData['locations']['latitude'] as num).toDouble()
            : 0.0),
        'longitude': (roomData['locations']['longitude'] != null
            ? (roomData['locations']['longitude'] as num).toDouble()
            : 0.0),
      },
    );
  }

  // Method to convert a Room object to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'price': price,
      'rating': rating,
      'bedNumbers': bedNumbers,
      'reviewNumbers': reviewNumbers,
      'roomImages': roomImages,
      'vendorName': vendorName,
      'yearsHosting': yearsHosting,
      'vendorProfession': vendorProfession,
      'authorImage': authorImage,
      'location': location,
      'date': date,
      'active': isActive,
      'description': description,
      'locations': locations,
    };
  }
}
