class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String city;
  final String state;
  final String zip;
  final String date;

  // Constructor
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.state,
    required this.zip,
    required this.date,
  });

  // Factory method to create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      zip: json['zip'],
      date: json['date'],
    );
  }

  // Method to convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
      'state': state,
      'zip': zip,
      'date': date,
    };
  }
}
