import 'package:airbnbr/components/icon_button.dart';
import 'package:airbnbr/model/message.model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MesagesScreenState();
}

class _MesagesScreenState extends State<MessagesScreen> {
  List<String> testMessages = [
    'All',
    'Unread',
    'Important',
    'Draft',
    'Sent',
    'Trash',
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(),
                  const Spacer(),
                  IconCustomButton(
                    icon: Icons.search,
                    color: Colors.black.withOpacity(0.1),
                  ),
                  const SizedBox(width: 10),
                  IconCustomButton(
                    icon: Icons.tune,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                "Messages",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    testMessages.length,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 7),
                          decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? Colors.black
                                : Colors.black12.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            testMessages[index],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: selectedIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ...messages.map((message) => _buildMessage(message))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessage(Message messages) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 85,
                width: 75,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(messages.roomImage),
                  ),
                ),
              ),
              Positioned(
                bottom: -10,
                right: -10,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(messages.autorImage),
                  backgroundColor: Colors.white,
                ),
              )
            ],
          ),
          const SizedBox(width: 20),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    messages.name,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    messages.timestamp,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Text(
                messages.message,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                messages.duration,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
