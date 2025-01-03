import 'package:airbnbr/database/db.dart';
import 'package:airbnbr/injection_containert.dart';
import 'package:airbnbr/model/fav_room_model.dart';
import 'package:airbnbr/model/room_model.dart';
import 'package:airbnbr/provider/user_fav_room_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchListScreen extends StatelessWidget {
  final String userId;
  const WatchListScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    //final RoomApi roomApi = RoomApi(); // Create an instance of RoomApi
    final roomApi = locator<RoomApi>();
    //Notify the provider to load the favorite rooms
    final provider = Provider.of<FavRoomsScreenProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Edit",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Watchlist",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              FutureBuilder<List<FavRoom>>(
                future: roomApi.fetchFavRooms(userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Error loading rooms"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No room found"));
                  } else {
                    final rooms = snapshot.data!;
                    return _displayFavRooms(context, rooms, roomApi, provider);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _displayFavRooms(BuildContext context, List<FavRoom> rooms,
      RoomApi roomApi, FavRoomsScreenProvider provider) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.68,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final room = rooms[index];
          print("WatchList  id is in user_fav_screen: ${room.id}");
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(room.roomImages[0]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: InkWell(
                  onTap: () async {
                    //User the provider later on
                    print(
                        'WatchList ID- for deleting: ${room.id} user: $userId');
                    final response =
                        await roomApi.deleteFavRoom(userId, room.id, context);

                    if (response.statusCode == 200) {
                      //provider.toggleFavorite(room.id);
                      provider.removeFavorite(room.roomId);
                      print(
                          'WatchList ID- for updateing the state: ${room.roomId}');
                    } else {
                      print('WatchList Failed to delete room from favorites.');
                    }
                  },
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    room.roomName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
