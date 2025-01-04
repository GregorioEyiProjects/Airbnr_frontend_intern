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
  final String city;
  final String continent;
  final String date;
  final bool active;
  final String description;
  final Map<String, double> locations;
  final Map<String, DateTime?> availability;
  //final DateTime avaibleStartTime;
  //final DateTime avaibleEndTime;
  final String stayFor;
  final String stayOn;
  final bool petsAllowed;
  final int maxAdults;
  final int maxChildren;
  final int maxInfants;

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
    required this.city,
    required this.continent,
    required this.date,
    required this.active,
    required this.description,
    required this.locations,
    required this.availability,
    //required this.avaibleStartTime,
    //required this.avaibleEndTime,
    required this.stayFor,
    required this.stayOn,
    required this.petsAllowed,
    required this.maxAdults,
    required this.maxChildren,
    required this.maxInfants,
  });

  // Factory method to createJSON from the room values
  factory Room.fromJson(Map<String, dynamic> json) {
    final locations = json['data']['locations'] ?? {};
    final avaibilityValue = json['data']['avaibility'] ?? {};
    final startTime = avaibilityValue['startTime'] != null
        ? DateTime.tryParse(avaibilityValue['startTime'])
        : null;
    final endTime = avaibilityValue['endTime'] != null
        ? DateTime.tryParse(avaibilityValue['endTime'])
        : null;
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
      city: json['data']['location'] ?? '',
      continent: json['data']['continent'] ?? '',
      date: json['data']['date'] ?? '',
      active: json['data']['active'] ?? false,
      description: json['data']['description'] ?? '',
      locations: {
        'latitude': (locations['latitude'] != null
            ? (locations['latitude'] as num).toDouble()
            : 0.0),
        'longitude': (locations['longitude'] != null
            ? (locations['longitude'] as num).toDouble()
            : 0.0),
      },
      availability: {
        "startTime": startTime ?? DateTime(1970),
        "endTime": endTime ?? DateTime(1970),
      },
      stayFor: json['data']['stayFor'] ?? 'Weekend',
      stayOn: json['data']['stayOn'] ?? 'Anytime',
      petsAllowed: json['data']['petsAllowed'] ?? false,
      maxAdults: json['data']['maxAdults'] ?? 0,
      maxChildren: json['data']['maxChildren'] ?? 0,
      maxInfants: json['data']['maxInfants'] ?? 0,
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
      'location': city,
      'continent': continent,
      'date': date,
      'active': active,
      'description': description,
      'locations': locations,
      'avaibility': availability,
      'stayFor': stayFor,
      'stayOn': stayOn,
      'petsAllowed': petsAllowed,
      'maxAdults': maxAdults,
      'maxChildren': maxChildren,
      'maxInfants': maxInfants,
    };
  }
}
