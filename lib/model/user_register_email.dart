class UserRegisterWithEmail {
  final String id;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String email;
  final String password;

  UserRegisterWithEmail(
    this.id, {
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.email,
    required this.password,
  });

  factory UserRegisterWithEmail.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    return UserRegisterWithEmail(
      user['_id'],
      firstName: user['firstName'],
      lastName: user['lastName'],
      dateOfBirth: user['dateOfBirth'],
      email: user['email'],
      password: user['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
      'email': email,
    };
  }
}
