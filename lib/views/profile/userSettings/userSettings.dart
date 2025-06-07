import 'package:airbnbr/views/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.02),
            //Info
            const Text(
              "Personal info",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: size.height * 0.06,
            ),
            //Containers
            personalInfoContainer("Legal name",
                edit: "Edit", subheader: "Emulator"),
            Divider(),
            personalInfoContainer("Prefered fisrt name"),
            Divider(),
            personalInfoContainer("Phone number",
                edit: "Add", subheader: "No provide"),
            Divider(),
            personalInfoContainer("Email",
                edit: "Edit", subheader: "Emulator@gmail.com"),
            Divider(),
            personalInfoContainer("Address"),
            Divider(),
            personalInfoContainer("Emergency contact"),
            Divider(),
            personalInfoContainer("Government"),
            Divider(),
          ],
        ),
      )),
    );
  }

  Padding personalInfoContainer(String header,
      {String edit = "Add", String subheader = "Not provided"}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                header,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  letterSpacing: 0.5,
                  height: 1,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subheader,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black38,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                edit,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  letterSpacing: 0.5,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
