import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserFavScreen extends StatelessWidget {
  const UserFavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //simulating data from the database
    Map<String, dynamic> userFavRoom = {
      'rooms': [
        {
          'idRoom': 'idid9d0ew0wmmk3j322kkss0',
          'data': {
            'name': 'Hyde Hotel',
            'price': 5000,
            'rating': 4.0,
            'bedNumbers': 3,
            'reviewNumbers': 50,
            'roomImages': [
              'https://hydehotels.com/wp-content/uploads/sites/4/2024/05/hydebodrum-bed-beigeheadboard-creamseat.jpg',
              'https://ettehotels.com/wp-content/uploads/2023/05/room-main-new-img-01.jpg',
              'https://hydehotels.com/wp-content/uploads/sites/4/2024/05/hydebodrum-suite-angledview-bed.jpg',
              'https://hydehotels.com/wp-content/uploads/sites/4/2024/05/hydebodrum-hallway-door-bedroom.jpg',
              'https://cf.bstatic.com/xdata/images/hotel/max1024x768/301227104.jpg?k=fbfac3dfa055212f7eaf5fca0beb49c6404247b9926b1b317ef13d5a57d5e073&o=&hp=1'
            ],
            'vendorName': 'Miriam Ruiz',
            'yearsHosting': 3,
            'vendorProfession': 'Dentist',
            'authorImage':
                'https://plus.unsplash.com/premium_photo-1689551670902-19b441a6afde?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cmFuZG9tJTIwcGVvcGxlfGVufDB8fDB8fHww',
            'location': 'Madrid',
            'date': 'Nov 2021',
            'active': true,
            'description':
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
            'locations': {
              'latitude': 40.4168,
              'longitude': -3.7038,
            },
          }
        },
        {
          'idRoom': 'idid9d0ew0wmmk3j322kkss1',
          'data': {
            'name': 'Sofitel Hotel Dubai',
            'bedNumbers': 5,
            'reviewNumbers': 100,
            'price': 10000,
            'rating': 4.5,
            'roomImages': [
              'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2c/b0/b8/60/suite-hotels.jpg?w=1200&h=-1&s=1',
              'https://techcrunch.com/wp-content/uploads/2016/12/dream-presidential-suite-terrace.jpg',
              'https://www.iamsterdam.com/_next/image?url=https%3A%2F%2Fapp.thefeedfactory.nl%2Fapi%2Fassets%2F5ff880d6de7e8633a4aa620d%2Fc8655dc9-f866-4c3e-afd3-03f1b3e0de7b.jpg&w=750&q=75',
              'https://www.ca.kayak.com/rimg/himg/c6/47/f7/ice-5319749-114044299-315841.jpg?width=1366&height=768&crop=true',
              'https://q-xx.bstatic.com/xdata/images/hotel/840x460/351729652.jpg?k=6ee5b63e17eb517e94eed2216d91deec3d546575d8a45f821ad8049b627fd02f&o='
            ],
            'vendorName': 'John doe',
            'yearsHosting': 5,
            'vendorProfession': 'Real Estate',
            'authorImage':
                'https://mir-s3-cdn-cf.behance.net/project_modules/1400/35af6a41332353.57a1ce913e889.jpg',
            'location': 'Dubai',
            'date': 'Nov 2023',
            'active': false,
            'description':
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
            'locations': {
              'latitude': 40.3168,
              'longitude': -3.7438,
            },
          }
        },
      ]
    };

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
              userFavRoom.isEmpty
                  ? const Center(child: Text("No room found"))
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.68,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: userFavRoom['rooms'].length,
                        itemBuilder: (context, index) {
                          final room = userFavRoom['rooms'][index];
                          return FutureBuilder(
                            future: Future.value(
                                room), // change this to receive the room data from the API
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return const Center(
                                    child: Text("Error loading room"));
                              } else {
                                final roomData =
                                    snapshot.data as Map<String, dynamic>;
                                return Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(roomData['data']
                                              ['roomImages'][0]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Icon(
                                        Icons.favorite,
                                        color: Colors.red,
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
                                          roomData['data']['name'],
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
                              }
                            },
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
