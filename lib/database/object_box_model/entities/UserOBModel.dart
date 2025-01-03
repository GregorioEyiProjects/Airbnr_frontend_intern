import 'package:objectbox/objectbox.dart';

@Entity()
class UserOB {
  @Id(assignable: true)
  int? id; // Unique ID for User in ObjectBox
  String mongoUserId; // Unique ID for User coming from MongoDB
  String firstName;
  String lastName;
  DateTime dateOfBirth;
  String email;
  String contact;
  String password;
  String? profileImage;
  String role;
  DateTime createdAt;
  DateTime updatedAt;

  UserOB({
    this.id,
    required this.mongoUserId,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.email,
    required this.contact,
    required this.password,
    this.profileImage,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  // Method to check if the password is valid
  bool isPasswordValid(String candidatePassword) {
    return candidatePassword == this.password;
  }
}
