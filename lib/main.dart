import 'package:airbnbr/database/db.dart';
import 'package:airbnbr/database/objectBoxDB.dart';
import 'package:airbnbr/database/objectBox_helper.dart';
import 'package:airbnbr/database/object_box_model/OBinit/MyObjectBox.dart';
import 'package:airbnbr/database/object_box_model/entities/userFavRooms.dart';
//import 'package:airbnbr/database/object_box_model/entities/User_O_Box.dart';
//import 'package:airbnbr/database/object_box_model/entities/Room_Object_Box.dart';
import 'package:airbnbr/injection_containert.dart';
import 'package:airbnbr/model/fav_room_model.dart';
//import 'package:airbnbr/model/fav_room_model.dart';
import 'package:airbnbr/model/room_model.dart';
import 'package:airbnbr/objectbox.g.dart';
import 'package:airbnbr/provider/roomProvider.dart';
//import 'package:airbnbr/model/user_login_model.dart';
//import 'package:airbnbr/model/user_register_email.dart';
import 'package:airbnbr/provider/user_fav_room_provider.dart';
import 'package:airbnbr/views/home/home_screen.dart';
import 'package:airbnbr/views/home/reserveRoom/request_to_book.dart';
import 'package:airbnbr/views/home/room_details.dart';
import 'package:airbnbr/views/login/loginWithEmail.dart';
import 'package:airbnbr/views/profile/userSettings/userSettings.dart';
import 'package:airbnbr/views/register/registerContact.dart';
import 'package:airbnbr/views/stays/Stays.dart';
import 'package:flutter/material.dart';
import 'package:airbnbr/views/login/loginWithContact.dart';
import 'package:airbnbr/views/register/registerEmail.dart';
import 'package:go_router/go_router.dart';
import 'package:objectbox/objectbox.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:objectbox/objectbox.dart';
//import 'package:airbnbr/components/display_place.dart';

late MyObjectBox objectBox;
late Objectboxdb objectBoxdb;
late ConnectionApi roomApi;

void main() async {
  //Ensuring the user stays isLoggedIn after closing the app
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  String? userIdShareP = prefs.getString('user_contact_token');
  String? userEmailShareP = prefs.getString('user_email_token');

  /* OBJECT BOX INIT */
  objectBoxdb = await Objectboxdb.getInstance();

  //Revome all users (for testing purposes)
  //await objectBoxdb.removeAllUsers();

  //Initialize the GetIt locator, which will be used to inject the RoomApi
  await setupLocator(objectBoxdb);

  //Get all rooms from the Backend
  roomApi = locator<ConnectionApi>();
  List<Room> listOfRooms = await roomApi.fetchAllRoom();

  ////To copy the list of room to the provider to be used in the app
  /// create: (context) => Roomprovider()..addRooms(listOfRooms)
  /// The ".." Is call cascade notation and it creates an instance of RoomProvider and then calls the addRooms method on that instance.
  /// This allows you to perform multiple operations on the same object
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavRoomsScreenProvider()),
        ChangeNotifierProvider(
            create: (context) => RoomProvider()..addRooms(listOfRooms)),
        Provider<Objectboxdb>.value(value: objectBoxdb),
        Provider<ConnectionApi>(create: (context) => locator<ConnectionApi>()),
      ],
      //create: (context) => FavRoomsScreenProvider(),
      child: MyApp(
        isLoggedIn: isLoggedIn,
        userIdMyApp: userIdShareP,
        userEmailSMyApp: userEmailShareP,
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;
  final String? userIdMyApp;
  final String? userEmailSMyApp;

  const MyApp(
      {super.key,
      required this.isLoggedIn,
      this.userIdMyApp,
      this.userEmailSMyApp});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MyRouter(
      isLoggedIn: widget.isLoggedIn,
      userIdRouter: widget.userIdMyApp,
      userEmailRouter: widget.userEmailSMyApp,
    );
  }
}

class MyRouter extends StatefulWidget {
  final bool isLoggedIn;
  final String? userIdRouter;
  final String? userEmailRouter;

  const MyRouter({
    super.key,
    required this.isLoggedIn,
    this.userIdRouter,
    this.userEmailRouter,
  });

  @override
  State<MyRouter> createState() => _MyRouterState();
}

class _MyRouterState extends State<MyRouter> {
  late final GoRouter router;

  @override
  void initState() {
    super.initState();
    print(
        'Main Router initState: isLoggedIn=${widget.isLoggedIn}, userIdRouter=${widget.userIdRouter}, userEmailRouter=${widget.userEmailRouter}');

    router = GoRouter(
      initialLocation: widget.isLoggedIn &&
              (widget.userIdRouter != null || widget.userEmailRouter != null)
          ? '/home_screen'
          : '/login_with_contact',
      routes: [
        GoRoute(
          path: "/login_with_contact",
          pageBuilder: (context, state) {
            //final String? contact = state.uri.queryParameters['contact'];

            final String? contact = state.uri.queryParameters['contact'];
            print(
                'Main - Navigating to LoginWithContact with contact: $contact');
            //GoRouter.of(context).refresh();
            return MaterialPage(
              key: ValueKey(contact),
              child: LoginWithContact(userContact: contact),
            );
          },
        ),
        GoRoute(
          path: "/login_with_gmail",
          pageBuilder: (context, state) {
            final String? email = state.uri.queryParameters['email'];
            print('Main - Navigating to LoginWithEmail with email: $email');
            return MaterialPage(
              key: ValueKey(email),
              child: LoginWithEmail(email: email),
            );
          },
        ),
        GoRoute(
          path: "/registerWithEmail",
          pageBuilder: (context, state) {
            final userLoginEmail = state.extra as String;
            return MaterialPage(
                child: RegisterWithEmail(email: userLoginEmail));
          },
        ),
        GoRoute(
          path: "/registerWithContact",
          pageBuilder: (context, state) {
            final userLoginContact = state.extra as String;
            return MaterialPage(
                child: RegisterWithContactCont(contact: userLoginContact));
          },
        ),
        GoRoute(
          path: "/home_screen",
          pageBuilder: (context, state) {
            //ObjectBox
            //Stream<List<User>> streamUser = objectBox.getUsers();
            //Stream<List<RoomOB>> streamRooms = objectBox.getRooms();

            final userIdFromLogin = state.extra as String?;
            //which id to use when is logged in (contact or email)
            String? unsureUserID = '';

            if (widget.userIdRouter != null) {
              unsureUserID = widget.userIdRouter;
            } else if (widget.userEmailRouter != null) {
              unsureUserID = widget.userEmailRouter;
            }
            final userId = widget.isLoggedIn && unsureUserID != null
                ? unsureUserID
                : userIdFromLogin;
            print(
                'Main home_screen_myRouter userIdFromLogin : ${userIdFromLogin}');
            print('Main home_screen_myRouter User_ID?: ${userId}');

            if (userId == null) {
              print('Main Error: userId is null');
              return const MaterialPage(
                child: const LoginWithContact(userContact: null),
              );
            }
            print('Main MyRouter c: ${userId}');

            return MaterialPage(
              child: FutureBuilder<List<FavRoom>>(
                future: roomApi.fetchFavRooms(userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    //print('Main MyRouter favUserRooms has error');
                    return const Center(
                      child: Text('An error occurred!'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    print('Main MyRouter favUserRooms is empty');
                    return HomeScreen(userId: userId);
                  } else {
                    final favUserRooms = snapshot.data!;
                    print('Main MyRouter favUserRooms: ${favUserRooms}');
                    //Add the favorite rooms to the Local DB (ObjectBox)
                    //only if the the backend has returned the favorite rooms
                    // Use post-frame callback to add favorite rooms to the Local DB (ObjectBox) when the widget is built
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      addFavRoomToOB(context, favUserRooms);
                      // Retrieve the user's favorite rooms from ObjectBox if there are any
                      retrieveFavRooms(context, userId);
                    });
                    // Retrieve the user's favorite rooms from objextBox if there are any
                    //retrieveFavRooms(context, userId);
                    return HomeScreen(userId: userId);
                  }
                },
              ),
            );
          },
        ),
        GoRoute(
          path: "/room_details",
          pageBuilder: (context, state) {
            final room = state.extra as Room;
            //final room = state.extra as FavRoom;
            final userId = state.uri.queryParameters['userId'];
            return MaterialPage(
              child: RoomDetails(
                room: room,
                userId: userId,
              ),
            );
          },
        ),
        GoRoute(
          path: "/request_to_book",
          pageBuilder: (context, state) {
            final userID = state.uri.queryParameters['userId'];
            final room = state.extra as Room;
            return MaterialPage(
              child: RequestToBook(
                userID: userID,
                room: room,
              ),
            );
          },
        ),
        GoRoute(
          path: "/user_settings",
          pageBuilder: (context, state) {
            //final userID = state.uri.queryParameters['userId'];
            //final room = state.extra as Room;
            return const MaterialPage(
              child: UserSettings(),
            );
          },
        ),
        GoRoute(
          path: "/whereTo",
          pageBuilder: (context, state) {
            //final userID = state.uri.queryParameters['userId'];
            //final room = state.extra as Room;
            return const MaterialPage(
              child: Stays(),
            );
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: "Airbnb",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: router,
      ),
    );
  }
}
