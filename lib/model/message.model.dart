import 'package:airbnbr/components/icon_button.dart';
import 'package:flutter/material.dart';

class Message {
  final String roomImage;
  final String autorImage;
  final String message;
  final String name;
  final String duration;
  final String timestamp;

  Message({
    required this.roomImage,
    required this.autorImage,
    required this.message,
    required this.name,
    required this.duration,
    required this.timestamp,
  });
}

final List<Message> messages = [
  Message(
      roomImage:
          "https://hydehotels.com/wp-content/uploads/sites/4/2024/05/hydebodrum-bed-beigeheadboard-creamseat.jpg",
      autorImage:
          "https://plus.unsplash.com/premium_photo-1689551670902-19b441a6afde?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cmFuZG9tJTIwcGVvcGxlfGVufDB8fDB8fHww",
      message: "Hello, how are you?",
      name: "Miriam Ruiz",
      duration: "4 min",
      timestamp: "12:00"),
  Message(
      roomImage:
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2c/b0/b8/60/suite-hotels.jpg?w=1200&h=-1&s=1",
      autorImage:
          "https://mir-s3-cdn-cf.behance.net/project_modules/1400/35af6a41332353.57a1ce913e889.jpg",
      message: "Hello, Are you interested on the room?",
      name: "John Doe",
      duration: "1 min",
      timestamp: "6:00")
];
