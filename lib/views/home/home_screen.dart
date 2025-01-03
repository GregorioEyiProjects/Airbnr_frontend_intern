import 'package:airbnbr/model/user_login_model.dart';
import 'package:airbnbr/views/home/explore_screen.dart';
import 'package:airbnbr/views/home/trips_sceens.dart';
import 'package:airbnbr/views/home/watch_list_screen.dart';
import 'package:airbnbr/views/mesages/messages_screen.dart';
import 'package:airbnbr/views/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  final String? userId;

  const HomeScreen({super.key, required this.userId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;
  late final String userId_;

  @override
  void initState() {
    super.initState();

    userId_ = widget.userId!;

    print('HomeScreen User_ID?: ${widget.userId}');

    _pages = [
      ExploreScreen(userId: userId_),
      WatchListScreen(userId: userId_),
      RoomListScreen(),
      MessagesScreen(),
      ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          elevation: 5,
          iconSize: 25,
          selectedItemColor: Colors.pink,
          unselectedItemColor: Colors.black12,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Image.network(
                'https://cdn3.iconfinder.com/data/icons/feather-5/24/search-512.png',
                height: 30,
                color: _selectedIndex == 0 ? Colors.pink : Colors.black12,
              ),
              label: "Explore",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_border,
                color: _selectedIndex == 1 ? Colors.pink : Colors.black12,
              ),
              label: "Watchlist",
            ),
            BottomNavigationBarItem(
              icon: Image.network(
                'https://cdn-icons-png.flaticon.com/512/2111/2111307.png',
                height: 24,
                color: _selectedIndex == 2 ? Colors.pink : Colors.black12,
              ),
              label: "Trips",
            ),
            BottomNavigationBarItem(
              icon: Image.network(
                'https://cdn.icon-icons.com/icons2/2770/PNG/512/message_dots_icon_176716.png',
                height: 24,
                color: _selectedIndex == 3 ? Colors.pink : Colors.black12,
              ),
              label: "Messages",
            ),
            BottomNavigationBarItem(
              icon: Image.network(
                'https://cdn-icons-png.flaticon.com/512/1144/1144760.png',
                height: 24,
                color: _selectedIndex == 4 ? Colors.pink : Colors.black12,
              ),
              label: "Profile",
            ),
          ],
        ),
        body: _pages[_selectedIndex]);
  }
}
