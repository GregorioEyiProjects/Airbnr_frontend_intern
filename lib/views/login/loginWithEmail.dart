import 'package:airbnbr/database/db.dart';
import 'package:airbnbr/injection_containert.dart';
import 'package:airbnbr/model/user_login_model.dart';
import 'package:airbnbr/model/user_register_email.dart';
import 'package:airbnbr/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:airbnbr/global.dart' as global;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:airbnbr/authentication/google_auth.dart';

class LoginWithEmail extends StatefulWidget {
  final String? email;
  const LoginWithEmail({super.key, this.email});

  @override
  State<LoginWithEmail> createState() => _LoginWithEmailState();
}

class _LoginWithEmailState extends State<LoginWithEmail> {
  late TextEditingController emailController;
  //final TextEditingController emailController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    emailController = TextEditingController(text: widget.email ?? '');

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    _focusNode.dispose();
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
                Padding(
                  padding: global.horizontalPadding,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.09,
                      ),
                      const Text(
                        "Log or sign up to Airbnbr",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                //Email  field
                _emailTextField(size, _focusNode, _isFocused, emailController),
                const SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: size.height * 0.01,
                ),
                //button continue
                InkWell(
                  onTap: () async {
                    try {
                      //final RoomApi roomApi = RoomApi();
                      //final roomApi = locator<RoomApi>();
                      final roomApi = locator<ConnectionApi>();
                      await roomApi.loginWithEmail(
                          emailController.text, context);
                      //GoRouter.of(context).go('/home_screen', extra: userLogin.id);
                    } catch (e) {
                      print(e);
                    }
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
                //Continue with Phone container
                InkWell(
                  onTap: () async {
                    GoRouter.of(context).go('/login_with_contact');
                  },
                  child: Padding(
                    padding: global.horizontalPadding,
                    child: _socialIcons(size, Icons.phone_android,
                        "Continue with Phone", Colors.grey, 29),
                  ),
                ),
                Padding(
                  padding: global.horizontalPadding,
                  child: _socialIcons(size, FontAwesomeIcons.google,
                      "Continue with Google", Colors.pink, 27),
                ),
                Padding(
                  padding: global.horizontalPadding,
                  child: _socialIcons(size, Icons.facebook,
                      "Continue with Facebook", Colors.blue, 30),
                ),
                Padding(
                  padding: global.horizontalPadding,
                  child: _socialIcons(size, Icons.apple, "Continue with Apple",
                      Colors.black, 30),
                ),
                const SizedBox(height: 10),
              ],
            )),
      ),
    );
  }

  Padding _emailTextField(
      Size size, FocusNode focusNode, bool isFocused, emailController) {
    print("EmailController: $emailController");
    return Padding(
      padding: global.horizontalPadding,
      child: Container(
        width: size.width,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black45),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: global.horizontalSimetric,
              child: TextField(
                controller: emailController,
                focusNode: focusNode,
                decoration: InputDecoration(
                  hintText: "Email",
                  border: InputBorder.none,
                  labelStyle: TextStyle(
                    color: isFocused ? Colors.pink : Colors.black45,
                    fontSize:
                        _isFocused || emailController.text.isNotEmpty ? 12 : 15,
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
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 10)
          ],
        ),
      ),
    );
  }
}
