import 'package:airbnbr/database/db.dart';
import 'package:airbnbr/injection_containert.dart';
import 'package:airbnbr/model/user_login_model.dart';
import 'package:airbnbr/views/home/home_screen.dart';
import 'package:airbnbr/views/login/loginWithEmail.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:airbnbr/global.dart' as global;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:airbnbr/authentication/google_auth.dart';

class LoginWithContact extends StatefulWidget {
  final String? userContact;
  const LoginWithContact({super.key, this.userContact});

  @override
  State<LoginWithContact> createState() => _LoginWithContactState();
}

class _LoginWithContactState extends State<LoginWithContact> {
  late TextEditingController contactController;
  //final TextEditingController contactController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print('LoginWithContact - contact_1: ${widget.userContact}');
    contactController = TextEditingController(text: widget.userContact ?? '');
    print('LoginWithContact - contact_1_1: ${widget.userContact}');
  }

  @override
  void dispose() {
    super.dispose();
    contactController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Login or Resgister",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                color: Colors.black12,
              ),
              const Padding(
                  padding: global.horizontalPadding,
                  child: const Column(
                    children: [
                      Text(
                        "Welcome to Airbnb replica",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: size.height * 0.02,
              ),
              //Phone number field
              _phoneNumberTextField(size),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: global.horizontalPadding,
                child: RichText(
                    text: const TextSpan(
                  text:
                      "We'll call or text you to confirm your number. Standard message and data rates apply.  ",
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 12,
                  ),
                  children: [
                    TextSpan(
                      text: "Privacy Policy",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          decoration: TextDecoration.underline),
                    )
                  ],
                )),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              //------ BUTTON CONTINUE ------ //
              InkWell(
                onTap: () async {
                  final roomApi = locator<ConnectionApi>();
                  await roomApi.loginWithContact_(
                      contactController.text, context);
                },
                child: _buttonContinue(size),
              ),
              SizedBox(
                height: size.height * 0.026,
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    height: 1,
                    color: Colors.black26,
                  )),
                  const Padding(
                      padding: global.horizontalSimetric, child: Text("or")),
                  Expanded(
                      child: Container(
                    height: 1,
                    color: Colors.black26,
                  ))
                ],
              ),
              SizedBox(
                height: size.height * 0.026,
              ),
              InkWell(
                onTap: () {
                  GoRouter.of(context).go('/login_with_gmail');
                  //Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => const LoginWithEmail()));
                },
                child: Padding(
                  padding: global.horizontalPadding,
                  child: _socialIcons(size, Icons.email, "Continue with gmail",
                      Colors.pink, 29),
                ),
              ),
              InkWell(
                onTap: () async {
                  //await FirebaseAuthService().signInWithGoogle();
                },
                child: Padding(
                  padding: global.horizontalPadding,
                  child: _socialIcons(size, FontAwesomeIcons.google,
                      "Continue with Google", Colors.pink, 27),
                ),
              ),
              Padding(
                padding: global.horizontalPadding,
                child: _socialIcons(size, Icons.facebook,
                    "Continue with Facebook", Colors.blue, 30),
              ),
              Padding(
                padding: global.horizontalPadding,
                child: _socialIcons(
                    size, Icons.apple, "Continue with Apple", Colors.black, 30),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Padding _socialIcons(Size size, icon, name, color, double iconSize) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Container(
          width: size.width,
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width * 0.1,
              ),
              Icon(
                icon,
                color: color,
                size: iconSize,
              ),
              SizedBox(
                width: size.width * 0.18,
              ),
              Text(
                name,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 10)
            ],
          ),
        ));
  }

  Padding _phoneNumberTextField(Size size) {
    return Padding(
      padding: global.horizontalPadding,
      child: Container(
        width: size.width,
        height: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black45),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                right: 10,
                left: 10,
                top: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Country/Region",
                    style: TextStyle(fontSize: 12),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Thailand (+66)",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Icon(
                        Icons.arrow_drop_down_sharp,
                        size: 30,
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: global.horizontalSimetric,
              child: TextField(
                controller: contactController,
                decoration: const InputDecoration(
                  hintText: "Phone number",
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.black45,
                    fontSize: 15,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding _buttonContinue(Size size) {
    return Padding(
      padding: global.horizontalPadding,
      child: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text(
            "Continue",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
