import 'dart:convert';
//import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';
import 'package:airbnbr/database/objectBoxDB.dart';
import 'package:airbnbr/database/objectBox_helper.dart';
import 'package:airbnbr/database/object_box_model/OBinit/MyObjectBox.dart';
import 'package:airbnbr/database/object_box_model/entities/RoomOBModel.dart';
import 'package:airbnbr/database/object_box_model/entities/UserOBModel.dart';
import 'package:airbnbr/model/fav_room_model.dart';
import 'package:airbnbr/model/user_login_model.dart';
import 'package:airbnbr/model/user_register_contact.dart';
import 'package:airbnbr/model/user_register_email.dart';
import 'package:airbnbr/objectbox.g.dart';
import 'package:airbnbr/views/register/registerContact.dart';
import 'package:airbnbr/views/register/registerEmail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/room_model.dart';

class ConnectionApi {
  final String baseUrl;
  late final String apiUrlrooms;
  late final String addFavRoom;
  late final String getFavRooms;
  late final String deleteFavRoomUrl;
  late final String loginUrl;
  late final String registerUserWithEmailUrl;
  late final String loginWithEmailUrl;
  late final String registerWithContactlUrl;
  late final Objectboxdb objectboxdb;
  //late MyObjectBox box;

  // 3000 or 4000

  // For physical device " http://192.168.1.187:3000/api/v1/"
  // For physical device " http://3.25.117.11:3000/api/v1/"
  // For virtual device " http://10.0.2.2:3000/api/v1/"

  ConnectionApi(this.objectboxdb)
      : baseUrl = 'http://192.168.1.189:3000/api/v1/' {
    debugPrint('RoomApi initialized');

    apiUrlrooms = '${baseUrl}rooms/allRooms';
    addFavRoom = '${baseUrl}user/addFavRoom';
    getFavRooms = '${baseUrl}user/favRooms/';
    deleteFavRoomUrl = '${baseUrl}user/removeFavRoom';
    loginUrl = '${baseUrl}auth/loginWithContact';
    registerUserWithEmailUrl = '${baseUrl}auth/registerWithEmail';
    loginWithEmailUrl = '${baseUrl}auth/loginWithEmail';
    registerWithContactlUrl = '${baseUrl}auth/registerWithContact';
  }

  // ----------------- REGISTER -----------------
  Future<void> registerUserWithContact(String firstName, String lastName,
      String dateOfBirth, String contact, String password, context) async {
    print(
        'DB - registerUserWithContact API url register: ${registerWithContactlUrl}');

    final response = await http.post(
      Uri.parse(registerWithContactlUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'firstName': firstName,
        'lastName': lastName,
        'dateOfBirth': dateOfBirth,
        'contact': contact,
        'password': password,
      }),
    );

    print(
        'DB - registerUserWithContact Response status: ${response.statusCode}');
    print('DB - registerUserWithContact Response body: ${response.body}');

    if (response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Welcome on board!")),
      );
      //print('DB - registerUserWithContact JSO_Response: $jsonResponse');
      print(
          'DB - registerUserWithContact Navigating to /login_with_contact with contact: $contact');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isLoggedIn", false);
      GoRouter.of(context).go('/login_with_contact?contact=$contact');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to register")),
      );
      throw Exception('Failed to register');
    }
  }

  Future<UserRegisterWithEmail> registerUserWithEmail(
      String firstName,
      String lastName,
      String dateOfBirth,
      String email,
      String password,
      context) async {
    print('API url register: ${registerUserWithEmailUrl}');

    final response = await http.post(
      Uri.parse(registerUserWithEmailUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'firstName': firstName,
        'lastName': lastName,
        'dateOfBirth': dateOfBirth,
        'email': email,
        'password': password,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Welcome on board!")),
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isLoggedIn", false);
      GoRouter.of(context).go('/login_with_gmail?email=$email');
      print('JSO_Response: $jsonResponse');
      return UserRegisterWithEmail.fromJson(jsonResponse);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to register")),
      );
      throw Exception('Failed to register');
    }
  }

// ----------------- LOGIN -----------------
  Future<void> loginWithContact_(String contact, context) async {
    print(' DB - loginWithContact_ API url login: ${loginUrl}');

    final response = await http.post(
      Uri.parse(loginUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'contact': contact,
      }),
    );

    //print('DB - loginWithContact_ Response status: ${response.statusCode}');
    print('DB - loginWithContact_ Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final userData = jsonResponse['user'];

      // Save token and login status in SharedPreferences
      String token = userData['_id'];
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('user_contact_token', token);
      await prefs.setBool('isLoggedIn', true);

      print("DB userID token ${prefs.getString('token')}");

      String userId = userData['_id'];

      //Get the user data from the response
      final user = UserLogin.fromJson(userData);

      //insert the user in the ObjectBox if he does not already exist
      await insertUserComingFromBackendLocally(context, user);

      //print('DB JSO_Response_id: ${userId}');
      /* ObjectBox STARTS 
      //I have to create a method to insert the user in the ObjectBox

      //Get the store variable
      Store store = objectboxdb.store;


      //print('DB - loginWithContact_ UserLogin fromJSOn: $user');
      final user_ = UserOB(
        mongoUserId: user.id,
        firstName: user.firstName,
        lastName: user.lastName,
        dateOfBirth: user.dateOfBirth,
        contact: user.contact,
        email: user.email,
        password: user.password,
        role: user.role,
        profileImage: user.profileImage,
        createdAt: user.createdAt,
        updatedAt: user.updatedAt,
      );

      // Check if the user exists by contact
      final userExistsWithContact = store
          .box<UserOB>()
          .query(UserOB_.contact.equals(user.contact))
          .build()
          .find();

      // Check if the user exists by email
      final userExistsWithEmail = store
          .box<UserOB>()
          .query(UserOB_.email.equals(user.email))
          .build()
          .find();

      // Print the contents of userExists for debugging
      //print('DB - loginWithContact_ userExists: $userExistsWithContact');

      // variable to store the user ID
      int userIDob = -1;

      if (userExistsWithContact.isEmpty && userExistsWithEmail.isEmpty) {
        // Insert the user in the ObjectBox if they do not already exist
        userIDob = store.box<UserOB>().put(user_);
        //Save temp user ID in SharedPreferences
        await prefs.setInt('userOB_id', userIDob);
        //print('DB - loginWithContact_ inserted and his ID is : $userIDob');
      } else {
        // Assign userIDob based on which user exists
        if (userExistsWithContact.isNotEmpty) {
          userIDob = userExistsWithContact.first.id!;
          //print('DB - loginWithContact_ userExistsWithContact ID: $userIDob');
        } else if (userExistsWithEmail.isNotEmpty) {
          userIDob = userExistsWithEmail.first.id!;
          //print('DB - loginWithContact_ userExistsWithEmail ID: ${userIDob}');
        }

        // Save temp user ID in SharedPreferences
        await prefs.setInt('userOB_id', userIDob);
      }

      //Get the user
      final userInserted = store.box<UserOB>().get(userIDob);
      //print('DB - loginWithContact_ inserted firstName: ${userInserted!.firstName}');

      ObjectBox ENDS */

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Welcome back!")),
      );
      GoRouter.of(context).go('/home_screen', extra: userId);
      //GoRouter.of(context).go('/home_screen?userId=$userId');
      //return UserLogin.fromJson(jsonResponse);
    } else {
      final jsonResponse = jsonDecode(response.body);
      String message = jsonResponse['message'];

      if (message == 'User not found.') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterWithContactCont(contact: contact),
          ),
        );
        //GoRouter.of(context).go('/registerWithContact', extra: contact);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
      //throw Exception('Failed to login');
    }
  }

  Future<void> loginWithEmail(String email, context) async {
    print('DB loginWithEmail API url login with email: ${loginWithEmailUrl}');

    final response = await http.post(
      Uri.parse(loginWithEmailUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': email,
      }),
    );
    /*   print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}'); */
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final userData = jsonResponse['user'];

      String userId = jsonResponse['user']['_id'];
      //String userEmail = jsonResponse['user']['email'];

      //print('DB userEmail: $userEmail & userID $userId in loginWithEmail');

      //Save data in shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_email_token', userId);
      await prefs.setBool('isLoggedIn', true);

      //Get the user data from the response
      final user = UserLogin.fromJson(userData);

      //Insert the user in the ObjectBox
      await insertUserComingFromBackendLocally(context, user);

      //print("DB userEmail token ${prefs.getString('token_user_email')} in loginWithEmail");

      /* ObjectBox STARTS 

      //Get the store variable
      Store store = objectboxdb.store;

      final user = UserLogin.fromJson(userData);
      //print('DB - loginWithEmail UserLogin fromJSOn: $user');
      final user_ = UserOB(
        mongoUserId: user.id,
        firstName: user.firstName,
        lastName: user.lastName,
        dateOfBirth: user.dateOfBirth,
        contact: user.contact,
        email: user.email,
        password: user.password,
        role: user.role,
        profileImage: user.profileImage,
        createdAt: user.createdAt,
        updatedAt: user.updatedAt,
      );

// Check if the user exists by contact
      final userExistsWithContact = store
          .box<UserOB>()
          .query(UserOB_.contact.equals(user.contact))
          .build()
          .find();

// Check if the user exists by email
      final userExistsWithEmail = store
          .box<UserOB>()
          .query(UserOB_.email.equals(user.email))
          .build()
          .find();

      // Print the contents of userExists for debugging
      //print('DB - loginWithEmail userExistsWithContact: $userExistsWithContact');
      //print('DB - loginWithEmail userExistsWithEmail: $userExistsWithEmail');

      // variable to store the user ID
      int userIDob = -1;

      if (userExistsWithContact.isEmpty && userExistsWithEmail.isEmpty) {
        // Insert the user in the ObjectBox if they do not already exist
        userIDob = store.box<UserOB>().put(user_);
        //Save temp user ID in SharedPreferences
        await prefs.setInt('userOB_id', userIDob);
        //print('DB - loginWithEmail inserted and his ID is : $userIDob');
      } else {
        if (userExistsWithContact.isNotEmpty) {
          userIDob = userExistsWithContact.first.id!;
          //print('DB - loginWithEmail userExistsWithContact ID: $userIDob');
        } else if (userExistsWithEmail.isNotEmpty) {
          userIDob = userExistsWithEmail.first.id!;
          //print('DB - loginWithEmail userExistsWithEmail ID: $userIDob');
        }
        //Save temp user ID in SharedPreferences
        await prefs.setInt('userOB_id', userIDob);
      }

      //Get the user
      //final userInserted = store.box<UserOB>().get(userIDob);
      //print('DB - loginWithEmail inserted firstName: ${userInserted!.firstName}');

     ObjectBox ENDS */

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Welcome back!")),
      );
      print('DB JSO_Response in loginWithEmail: $jsonResponse');
      GoRouter.of(context).go('/home_screen', extra: userId);
    } else {
      final jsonResponse = jsonDecode(response.body);
      String message = jsonResponse['message'];
      if (message == 'User not found.') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterWithEmail(email: email),
          ),
        );
        //GoRouter.of(context).go('/registerWithEmail', extra: email);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
      //throw Exception('Failed to login');
    }
  }

// ----------------- API Calls -----------------
  // Fetch rooms data from the API

  Future<List<Room>> fetchAllRoom() async {
    print('API url: ${apiUrlrooms}');
    final response = await http.get(Uri.parse(apiUrlrooms));
    print('All: ${response.body}'); // Check what data you're getting

    if (response.statusCode == 200) {
      //List<dynamic> jsonResponse = jsonDecode(response.body);
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;
      print('DB - fetchAllRoom jsonResponse: $jsonResponse');

      // Get the room data from the jsonResponse and convert it to a list of Room objects
      final rooms =
          jsonResponse.map((roomJson) => Room.fromJson(roomJson)).toList();

      //insert all the rooms in the ObjectBox
      await inserAllRoomsComingFromBackendLocally(rooms);

      //Get the existing roomsId from the ObjectBox and converting them to a Set
      /* OBJECT BOX STARTS 
      final existingRooms = objectboxdb.store
          .box<RoomOB>()
          .getAll()
          .map((room) => room.mongoRoomId)
          .toSet();

      // runInTransaction: It ensures atomicity, consistency, and efficiency for multiple database operations.
      // TxMode.write is used for transactions that modify the database.
      store.runInTransaction(TxMode.write, () {
        //Check if the room already exists in the ObjectBox
        for (var room in rooms) {
          if (!existingRooms.contains(room.id)) {
            print(
                "DB fetchAllRoom - No rooms yet, so inserting in the ObjectBox room with ID: ${room.id}");
            //Ceate a room
            final roomOB = RoomOB(
              mongoRoomId: room.id,
              name: room.name,
              price: room.price,
              rating: room.rating,
              bedNumbers: room.bedNumbers,
              reviewNumbers: room.reviewNumbers,
              roomImages: room.roomImages,
              vendorName: room.vendorName,
              yearsHosting: room.yearsHosting,
              vendorProfession: room.vendorProfession,
              authorImage: room.authorImage,
              city: room.city,
              date: room.date,
              active: room.active,
              description: room.description,
              avaibleStartTime:
                  room.availability['startTime'] ?? DateTime(1970),
              avaibleEndTime: room.availability['endTime'] ?? DateTime(1970),
              stayFor: room.stayFor,
              stayOn: room.stayOn,
              petsAllowed: room.petsAllowed,
              maxAdults: room.maxAdults,
              maxChildren: room.maxChildren,
              maxInfants: room.maxInfants,
            );

            //Insert the room in the ObjectBox
            final id = store.box<RoomOB>().put(roomOB);
            print('DB fetchAllRoom - room inserted in ObjectBox with ID: $id');
          } else {
            print(
                'DB  fetchAllRoom - room already exists in the ObjectBox and the mongoRoomId is: ${room.id}');
          }
        }
      });

       OBJECT BOX ENDS */

      return jsonResponse.map((roomJson) => Room.fromJson(roomJson)).toList();
    } else {
      throw Exception('Failed to load rooms');
    }
  }

  /*  Future<List<RoomOB>> fetchAllRooms2() async {
    print('Fetching data...');
    // Simulate a fetch
    print('API url: ${apiUrlrooms}');
    final response = await http.get(Uri.parse(apiUrlrooms));
    print('All: ${response.body}'); // Check what data you're gettingß

    if (response.statusCode == 200) {
      print('DONE Fetching data...');
      List<dynamic> jsonResponse = jsonDecode(response.body);
      //final dir = await getApplicationDocumentsDirectory();
      //final box = myObjectBox;

      // Add data to the  ObjectBox
      for (var roomJson in jsonResponse) {
        //final room = RoomOB.fromJson(roomJson);
        //await box.insertRoom(room);
      }

      print("BD rooms coming from LOCAL DEVIDE ${box.getRooms()}");

      return jsonResponse.map((roomJson) => RoomOB.fromJson(roomJson)).toList();
    } else {
      throw Exception('Failed to load rooms');
    }
  } */

  Future<List<FavRoom>> fetchFavRooms(String userId) async {
    print("fetchFavRooms userId: $userId");
    final urlFaveRooms = "${getFavRooms}${userId}";
    final response = await http.get(Uri.parse(urlFaveRooms), headers: {
      'Content-Type': 'application/json',
    });
    print('fetchFavRooms Respose body: ${response.body}');
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((favRoom) => FavRoom.fromJson(favRoom)).toList();
    } else {
      throw Exception('Failed to load rooms');
    }
  }

//Used in DisplayPlace.dart
  Future<void> addFavRoomToDB(String userId, String roomId, context) async {
    final response = await http.post(
      Uri.parse(addFavRoom),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'userId': userId,
        'roomId': roomId,
      }),
    );

    final jsonResponse = jsonDecode(response.body);
    final message_ = jsonResponse['message'];

    if (response.statusCode == 201) {
      //Get the response message
      //final message = jsonResponse['message'];
      final data = jsonResponse['data'];

      print("DB - addFavRoomToDB data: $data");

      //Extract the data from the response and convert it to a FavRoom object
      final favRoom = FavRoom.fromJson(data);

      //Insert the fav room in the ObjectBox
      addNewFavRoom(context, favRoom);
      print("DB - addFavRoomToDB data id of the fav room added: ${favRoom.id}");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message_,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message_,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

//DELETE
  Future<http.Response> deleteFavRoom(
      String userId, String favRoomId, context) async {
    print("DELETE - userId: $userId DELETE - roomId: $favRoomId");
    try {
      final response = await http.delete(
        Uri.parse(deleteFavRoomUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'favRoomId': favRoomId, 'userId': userId}),
      );
      if (response.statusCode == 200) {
        //Get the response message
        final jsonResponse = jsonDecode(response.body);
        final message = jsonResponse['message'];

        print('DELETE message from backend: $message');

        //Delete the fav room from the ObjectBox
        await deleteFavRoomFromOB(context, userId, favRoomId);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        print('DELETE response: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to remove from favorites")),
        );
      }

      return response;
    } catch (e) {
      print('DELETE Error: $e');
      return http.Response('Error', 500);
    }
  }
}
