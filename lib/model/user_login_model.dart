class UserLogin {
  final String id;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String email;
  final String password;
  final String contact;
  final String profileImage;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserLogin({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.email,
    required this.password,
    required this.contact,
    required this.profileImage,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserLogin.fromJson(Map<String, dynamic> userData) {
    print('UserLogin.fromJson: $userData');
    return UserLogin(
      id: userData['_id'] ?? '',
      firstName: userData['firstName'] ?? '',
      lastName: userData['lastName'] ?? '',
      dateOfBirth: DateTime.parse(
          userData['dateOfBirth'] ?? DateTime.now().toIso8601String()),
      email: userData['email'] ?? '',
      password: userData['password'] ?? '',
      contact: userData['contact'] ?? '',
      profileImage: userData['profileImage'] ?? '',
      role: userData['role'] ?? '',
      createdAt: DateTime.parse(
          userData['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(
          userData['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'email': email,
      'password': password,
      'contact': contact,
      'profileImage': profileImage,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
