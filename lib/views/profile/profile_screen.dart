//import 'dart:ffi';

import 'package:airbnbr/components/icon_button.dart';
import 'package:airbnbr/database/objectBoxDB.dart';
import 'package:airbnbr/database/object_box_model/entities/UserOBModel.dart';
import 'package:airbnbr/main.dart';
import 'package:airbnbr/views/profile/userSettings/userSettings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:objectbox/objectbox.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _PState();
}

class _PState extends State<ProfileScreen> {
  late int? userOB_id;
  UserOB? userData;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    //Get the userOD_id from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userOB_id = prefs.getInt('userOB_id');
    print('UserProfile - userOB_id ini initState: $userOB_id');

    //If the userOB_id is not null, get the user data from the database
    if (userOB_id != null) {
      //Open the store
      Store? store = objectBoxdb.store;

      //Get the user object box
      userData = store.box<UserOB>().get(userOB_id!);
      //print('UserProfile - userOB_id in initState: ${userData.firstName}');
      if (userData != null) {
        print('UserProfile - userOB_id in initState: ${userData!.firstName}');
        print(
            'UserProfile - user profile in initState: ${userData!.profileImage}');
      } else {
        print('UserProfile - userOB_id in initState: User not found');
      }
    } else {
      print('UserProfile - userOB_id is null');
    }

    // Update the state to reflect the changes
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                //Row profile
                _profileAndNorifications(),
                const SizedBox(height: 15),
                //Row admin
                _admidProfile(size),
                const SizedBox(
                  height: 20,
                ),
                //Card details
                _card(),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 0.5,
                  color: Colors.black,
                ),

                //Settings
                const Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserSettings(),
                      ),
                    );
                  },
                  child: _listOfSettings(
                      Icons.person_2_outlined, "Personal information", () {
                    GoRouter.of(context).go('/user_settings');
                  }),
                ),
                _listOfSettings(Icons.security, "Login & security", () {
                  //GoRouter.of(context).go('/user_settings');
                }),
                _listOfSettings(Icons.payment_outlined, "Payments and payouts",
                    () {
                  //GoRouter.of(context).go('/user_settings');
                }),
                _listOfSettings(Icons.security, "Accessibility", () {
                  // GoRouter.of(context).go('/user_settings');
                }),
                _listOfSettings(Icons.note_alt_outlined, "Taxes", () {
                  //GoRouter.of(context).go('/user_settings');
                }),
                _listOfSettings(Icons.person_2_outlined, "Personal information",
                    () {
                  // GoRouter.of(context).go('/user_settings');
                }),
                _listOfSettings(Icons.translate, "Translations", () {
                  //GoRouter.of(context).go('/user_settings');
                }),
                _listOfSettings(
                    Icons.notification_add_outlined, "Notifications", () {
                  // GoRouter.of(context).go('/user_settings');
                }),
                _listOfSettings(Icons.lock_outline, "Privacy and sharing", () {
                  // GoRouter.of(context).go('/user_settings');
                }),
                _listOfSettings(Icons.card_travel_outlined, "Travel for work",
                    () {
                  // GoRouter.of(context).go('/user_settings');
                }),
                InkWell(
                  onTap: () async {
                    //Delete token from shared preferences
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    print(
                        "UserProfile - Before Before userID token ${prefs.getString('token')} user email token ${prefs.getString('token_user_email')} isLoggedIn? ${prefs.getBool('isLoggedIn')}");
                    print(
                        "UserProfile - Before userOB_id token ${prefs.getInt('userOB_id')} ");
                    await prefs.remove('token'); //  the contact is the ID
                    await prefs.remove('token_user_email');
                    await prefs.remove('isLoggedIn');
                    await prefs.remove('userOB_id');
                    print(
                        "UserProfile - After userID token ${prefs.getString('token')} user email token ${prefs.getString('token_user_email')} isLoggedIn? ${prefs.getBool('isLoggedIn')} ");
                    print(
                        "UserProfile - After userOB_id token ${prefs.getInt('userOB_id')} ");
                    GoRouter.of(context).go('/login_with_contact');
                  },
                  child: _listOfSettings(
                    Icons.logout,
                    "Log out",
                    () async {/*Nothing for now*/},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _profileAndNorifications() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Profile',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        Icon(
          Icons.notifications_outlined,
          size: 27,
          color: Colors.black,
        ),
      ],
    );
  }

  Row _admidProfile(Size size) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.black,
          backgroundImage: userData?.profileImage != null
              ? NetworkImage(userData!.profileImage!)
              : AssetImage('assets/images/defaultProfileImage.png')
                  as ImageProvider,
        ),
        //SizedBox(height: size.height * 0.06),
        SizedBox(width: size.width * 0.019),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userData?.firstName != null
                  ? userData!.firstName
                  : "No Name", //Real name of the user coming from the database
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Show profile',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black38,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Spacer(),
        const Icon(
          Icons.arrow_forward_ios,
          size: 20,
          color: Colors.black38,
        ),
        const SizedBox(height: 10),
        const Divider(
          color: Colors.black,
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Card _card() {
    return Card(
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, bottom: 15, top: 5),
        child: Row(
          children: [
            const Text.rich(
              const TextSpan(
                text: "Airbnbr your place\n",
                style: TextStyle(
                  fontSize: 18,
                  height: 2.4,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: "It's simple to get set up and\n start earning",
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.7,
                      color: Colors.black38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Image.asset(
              "assets/images/smallhouse.jpg",
              width: 100,
              height: 120,
            )
          ],
        ),
      ),
    );
  }

  Padding _listOfSettings(icon, name, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 30,
                color: Colors.black54,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onTap,
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Colors.black38,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(
            thickness: 0.1,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
