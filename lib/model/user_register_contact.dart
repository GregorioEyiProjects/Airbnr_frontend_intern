class UserRegisterWithContact {
  final String id;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String contact;
  final String password;

  UserRegisterWithContact(
    this.id, {
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.contact,
    required this.password,
  });

  factory UserRegisterWithContact.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    return UserRegisterWithContact(
      user['_id'],
      firstName: user['firstName'],
      lastName: user['lastName'],
      dateOfBirth: user['dateOfBirth'],
      contact: user['contact'],
      password: user['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
      'contact': contact,
    };
  }
}
