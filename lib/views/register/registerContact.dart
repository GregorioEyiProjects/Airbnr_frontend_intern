import 'package:airbnbr/components/CustomTextField.dart';
import 'package:airbnbr/components/icon_button.dart';
import 'package:airbnbr/components/passwordTextField';
import 'package:airbnbr/database/db.dart';
import 'package:airbnbr/injection_containert.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:airbnbr/global.dart' as global;
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class RegisterWithContactCont extends StatefulWidget {
  final String contact;
  const RegisterWithContactCont({super.key, required this.contact});

  @override
  State<RegisterWithContactCont> createState() =>
      _RegisterWithContactContState();
}

class _RegisterWithContactContState extends State<RegisterWithContactCont> {
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _contactFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  List<DateTime?> _dates = [DateTime.now()];
  String displayText = "Date of birth"; // Default display text

  void _openDatePickerDialog() async {
    final List<DateTime?>? selectedDates = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(),
      dialogSize: const Size(325, 400),
      value: _dates,
      borderRadius: BorderRadius.circular(15),
    );

    if (selectedDates != null) {
      setState(() {
        _dates = selectedDates;
        if (_dates[0] != null) {
          displayText =
              "${_dates[0]!.day}/${_dates[0]!.month}/${_dates[0]!.year}";
        } else {
          displayText = " ";
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    contactController.text = widget.contact;

    _firstNameFocusNode.addListener(() {
      setState(() {});
    });
    _lastNameFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(height: size.height * 0.07),
                    //Back button
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        //GoRouter.of(context).go('/login');
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black54,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.02),

                //Title
                const Text(
                  "Finish signing up",
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Legal name",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _textFieldContainer(size),
                    const SizedBox(height: 5),
                    RichText(
                      text: const TextSpan(
                        text:
                            "Make sure it matches with the name on your goverment ID if you\ngo by another name, you can add  a",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                        children: [
                          TextSpan(
                            text: " preferred fisrt name",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Date of birth",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    //Date picker
                    const SizedBox(height: 10),
                    _calendar(size),
                    const SizedBox(height: 10),
                    const Text(
                      "To sign up, you need to be al least 18. Other people who use \nAirbnbr won't see you birthday.",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 20),
                    //CONTACT
                    const Text(
                      "Contact",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CustomTextField(
                        hintText: contactController.text,
                        controller: contactController,
                        focusNode: _contactFocusNode,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "We'll call you a reservation for confirmation.",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),

                    //Password
                    const SizedBox(height: 20),
                    const Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: PasswordTextField(
                        hintText: "  Password",
                        controller: passwordController,
                        focusNode: _passwordFocusNode,
                      ),
                    ),

                    //Policies and terms
                    const SizedBox(height: 10),
                    _privacyAndTerms(),
                    const SizedBox(height: 20),
                    //Continue button
                    _btnContinue(
                        context,
                        size,
                        firstNameController,
                        lastNameController,
                        contactController,
                        passwordController),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell _btnContinue(BuildContext context, Size size, firstNameController,
      lastNameController, contactController, passwordController) {
    return InkWell(
      onTap: () async {
        if (_dates[0] != null &&
            _dates.isNotEmpty &&
            _dates != null &&
            _dates[0] != DateTime.now()) {
          DateTime dateOfBirth = _dates[0]!;

          //final RoomApi roomApi = RoomApi();
          final roomApi = locator<RoomApi>();

          print("RegisterWithContactContState - DOB: ${dateOfBirth}");
          await roomApi.registerUserWithContact(
            firstNameController.text,
            lastNameController.text,
            dateOfBirth.toIso8601String(),
            contactController.text,
            passwordController.text,
            context,
          );
          GoRouter.of(context).refresh();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Please select a valid date of birth"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text(
            "Agree and continue",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  RichText _privacyAndTerms() {
    return RichText(
      text: const TextSpan(
        text: "By selecting ",
        style: TextStyle(
          color: Colors.black87,
          fontSize: 14,
        ),
        children: [
          TextSpan(
            text: "Agree and continue,",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          TextSpan(
            text: " I agree to Arbnbr's\n",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              decoration: TextDecoration.underline,
            ),
          ),
          TextSpan(
            text: "Terms of Service, Payments Terms of Service, Privacy",
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              decoration: TextDecoration.underline,
            ),
          ),
          TextSpan(
            text: " and  ",
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          TextSpan(
            text: " \nNondiscrimination Policy, ",
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              decoration: TextDecoration.underline,
            ),
          ),
          TextSpan(
            text: "and acknowledge the ",
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 14),
          ),
          TextSpan(
            text: " Privacy ",
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              decoration: TextDecoration.underline,
            ),
            children: [
              TextSpan(
                text: "Privacy.",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  InkWell _calendar(Size size) {
    return InkWell(
      onTap: _openDatePickerDialog,
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black45),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                displayText,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                ),
              ),
              const Icon(
                Icons.calendar_today,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _textFieldContainer(Size size) {
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black45),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //FistName container
          CustomTextField(
            hintText: "  First name on ID",
            controller: firstNameController,
            focusNode: _firstNameFocusNode,
          ),
          const Divider(color: Colors.black45),
          //LastName container
          CustomTextField(
            hintText: "  Last name on ID",
            controller: lastNameController,
            focusNode: _lastNameFocusNode,
          ),
        ],
      ),
    );
  }
}
