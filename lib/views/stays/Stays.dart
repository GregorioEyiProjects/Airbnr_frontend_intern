//import 'dart:ffi';
import 'dart:math';
import 'package:airbnbr/components/stays/clearAndSearch.dart';
import 'package:airbnbr/views/stays/more.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Stays extends StatefulWidget {
  const Stays({super.key});
  @override
  State<Stays> createState() => _StaysState();
}

class _StaysState extends State<Stays> {
  final TextEditingController searchController = TextEditingController();

  String? selectedPlaceValue;
  String? whenIsYourTripChoice;
  String? selectedTripOption;
  String? whosComing;
  String? daySelected;
  String? stayForSelected;
  String? goOnMonthSelected;
  String? tripOptionDay;
  String? tripOptionMonthh;
  String? tripOptionFlexible;
  int monthValue = 1;

  //Months container values
  String? statingDateTextValue;
  String? endDateTextValue;

  // Final values for {WHERE TO GO} container value,  {WHEN IS YOUR TRIP} containers values,
  // and {WHO'S COMING} container values
  Map<String, dynamic> whereToGoFinalValues = {};
  Map<String, dynamic> whenIsYourTripFinalValues = {};
  Map<String, dynamic> whosComingFinalValues = {};

  List<DateTime?> _dates = [DateTime.now()];

  // ------ To display the dates selected on the screen ------

  //Global variables
  // End date for the Months option
  DateTime? endDate;

  // Dates container
  String displayCalendarDaysValues = "Not date selected"; // DATAfor exact dates
  String displayCalendarDaysInfo = "Not date selected"; // DATA for plus days

  // Months container
  String displayCalendarMonthsInfo = "Not date selected";

  // Flexible container
  String displayCalendarFlexibleInfo = "Not date selected";

  //Who's coming variables
  int adultQuantity = 0;
  int childQuantity = 0;
  int infantQuantity = 0;
  int petQuantity = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Defaul state values for the components (WHERE TO GO, WHEN IS YOUR TRIP, & WHO'S COMING) to keep them hidden
    // This one null cuz it's the first one to be displayed
    selectedPlaceValue = null;
    whenIsYourTripChoice = "Any week";
    whosComing = "Add guests";

    //Defaul state values for the components DAY, MONTH, FLEXIBLE
    selectedTripOption = "Dates";
    daySelected = "Exact dates";
    stayForSelected = "Weekend";
    goOnMonthSelected = "Anytime";

    updateDisplayCalendarDays();
    displayCalendarDaysInfo = displayCalendarDaysValues;
    statingDateTextValue = _dates.isNotEmpty && _dates[0] != null
        ? _formatDate(_dates[0]!)
        : "Not date selected";
    endDateTextValue = _calculateEndDate();
    displayCalendarMonthsInfo = _calculateEndDateWithoutYear();
    updateWhoComingFinalValues(adultQuantity, childQuantity, infantQuantity,
        petQuantity); // To update the final values for the third container
  }

// Calculate the end date for the Months option. Example: "Dec 1, 2021 + 1 month = Jan 1, 2022"
  String _calculateEndDate() {
    if (_dates.isNotEmpty && _dates[0] != null) {
      DateTime startDate = _dates[0]!;
      DateTime endDate =
          DateTime(startDate.year, startDate.month + monthValue, startDate.day);
      return _formatDate(endDate);
    }
    return "Not date selected";
  }

// Calculate the end date for the Months option without the year. Example: "Dec 1 - Jan 1"
  String _calculateEndDateWithoutYear() {
    //Declare a new DateTime variable to store the start date
    List<DateTime?> dates = [DateTime.now()];

    if (dates.isNotEmpty && dates[0] != null) {
      DateTime startDate = dates[0]!;
      endDate = DateTime(startDate.year, startDate.month + monthValue,
          startDate.day); // This variable has to be Gobal
      String startDay = _formatDateWithoutYear(startDate);
      String endDay = _formatDateWithoutYear(endDate!);
      return "$startDay - $endDay";
      //return _formatDateWithoutYear(endDate);
    }
    return "Not date selected";
  }

// Format the date to be displayed on the screen, example: "Dec 1, 2021"
  String _formatDate(DateTime date) {
    return "${monthName(date.month)} ${date.day}, ${date.year}";
  }

// Format the date to be displayed on the screen, example: "Dec 1"
  String _formatDateWithoutYear(DateTime date) {
    return "${monthName(date.month)} ${date.day}";
  }

// To update the displayCalendarDays string to reflect the selected dates.
  void updateDisplayCalendarDays() {
    if (_dates.isNotEmpty && _dates[0] != null) {
      if (_dates.length > 1 && _dates[1] != null) {
        DateTime start = _dates[0]!;
        DateTime end = _dates[1]!;
        displayCalendarDaysValues =
            "${monthName((start.month))} ${start.day}-${end.day}";
      } else {
        DateTime start = _dates[0]!;
        displayCalendarDaysValues = "${monthName(start.month)} ${start.day}";
      }
    } else {
      displayCalendarDaysValues = "Not date selected";
    }
  }

// To get the number of Adults, Childen, Infants, Pets for the third container
  void updateWhoComingFinalValues(int? adultQuantity, int? childQuantity,
      int? infantQuantity, int? petQuantity) {
    setState(() {
      int previousAdultQuantity = this.adultQuantity;
      int previousChildQuantity = this.childQuantity;
      int previousInfantQuantity = this.infantQuantity;
      int previousPetQuantity = this.petQuantity;

      whosComingFinalValues = {
        "adult": adultQuantity ?? previousAdultQuantity,
        "child": childQuantity ?? previousChildQuantity,
        "infant": infantQuantity ?? previousInfantQuantity,
        "pet": petQuantity ?? previousPetQuantity,
      };

      // Update the state variables (In case i need them later on)
      if (adultQuantity != null) this.adultQuantity = adultQuantity;
      if (childQuantity != null) this.childQuantity = childQuantity;
      if (infantQuantity != null) this.infantQuantity = infantQuantity;
      if (petQuantity != null) this.petQuantity = petQuantity;
    });
  }

/* ---- Widget MAIN SCREEN starts here ---- */
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SizedBox(
        height: size.height * 0.1,
        child: ClearAndSearch(
          size: size,
          whereToGo: whereToGoFinalValues,
          whenIsYourTripChoice: whenIsYourTripFinalValues,
          whosComing: whosComingFinalValues,
        ), //Clear all and Search stays container
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 2,
                ),
                _staysAndExperienceRow(context),
                SizedBox(
                  height: 15,
                ),
                //Where to go container (1)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: selectedPlaceValue == null
                        ? _whereToGo()
                        : _collapsedWhereToGo(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //When is your trip container (2)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPlaceValue = "I am flexible";
                      whenIsYourTripChoice = null;
                      whosComing = "Add guests";
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    height: whenIsYourTripChoice == null
                        ? size.height * 0.75
                        : null,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: whenIsYourTripChoice == null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "When is your trip?",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //Options container
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey[300]),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    _whenIsYourTripMainContainer("Dates"),
                                    _whenIsYourTripMainContainer("Months"),
                                    _whenIsYourTripMainContainer("Flexible"),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // ------- When is your trip containers ------
                              //Days container
                              if (selectedTripOption == "Dates")
                                _daysContainer(),
                              //Months container
                              if (selectedTripOption == "Months")
                                _monthContainer(),
                              //Flexible container
                              if (selectedTripOption == "Flexible")
                                _flexibleContainer(),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [_resetOrNextContainer()],
                                ),
                              ),
                            ],
                          )
                        : _collapseWhenIsTrip(),
                  ),
                ),
                SizedBox(height: 20),
                //Who is coming container (3)
                whosComing == null
                    ? _whosComingContainer()
                    : _collapsedWhoCominToGo(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
/* ---- Widget MAIN SCREEN ends here ---- */

/* ---- Fisrt row starts here (Back Icon, Stays, Experiences) ---- */
  Row _staysAndExperienceRow(BuildContext context) {
    return Row(
      children: [
        //Button close
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
        // Display STAYS text
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Stays",
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              //Display EXPERIENCES text
              Text(
                "Experiences",
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
/* ---- Fisrt row ends here (Back Icon, Stays, Experiences) ---- */

/* ---- Where to go CONTAINER (1) starts here ---- */
  Column _whereToGo() {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Where to go?",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              selectedPlaceValue ?? "",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        // Search bar
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: Colors.black,
                size: 30,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                    width: 200,
                    //Search bar
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Search destinations",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        //Places to go
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: placesToGo["places"].map<Widget>(
              (place) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      //Get the selected place name
                      selectedPlaceValue = place['name'];

                      //Create a new Map to store the selected place
                      whereToGoFinalValues = {
                        "name": selectedPlaceValue,
                        "image": place['image'] ?? "",
                      };

                      //Reset the whenIsYourTripChoice component, so it can be displayed
                      whenIsYourTripChoice = null;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(place['image']),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                            border: Border.all(
                              color: selectedPlaceValue == place['name']
                                  ? Colors.black
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          place['name'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        )
      ],
    );
  }

  GestureDetector _collapsedWhereToGo() {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPlaceValue = null;
          whenIsYourTripChoice = "Any week";
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Where to go",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            selectedPlaceValue ?? "",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
/* ---- Where to go CONTAINER (1) ends here ---- */

/* ------ Where is your trip MAIN CONTAINER (2) starts here ------- */

// It contains the Days, Months, Flexible containers, and IT STARTS here
  Widget _whenIsYourTripMainContainer(String textValue) {
    bool isSelected = selectedTripOption == textValue;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTripOption = textValue;
        });
      },
      child: isSelected
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Text(
                textValue,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            )
          : Text(
              textValue,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
// It contains the Days, Months, Flexible containers, and IT ENDS here

//// ------- Date container starts (FIRST) -------- ////
  Widget _daysContainer() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          //calendar
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: CalendarDatePicker2(
              config: CalendarDatePicker2WithActionButtonsConfig(
                calendarType: CalendarDatePicker2Type.range,
              ),
              value: _dates,
              onValueChanged: (dates) {
                setState(() {
                  _dates = dates;
                  updateDisplayCalendarDays();
                });
              },
            ),
          ),
          Divider(
            color: Colors.black26,
          ),
          //Exact dates
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //Exact dates container
                GestureDetector(
                  onTap: () {
                    setState(() {
                      daySelected = "Exact dates";
                      displayCalendarDaysInfo = displayCalendarDaysValues;
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: daySelected == "Exact dates"
                            ? Colors.black
                            : Colors.black26,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Text(
                      "Exact dates",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                //Plus days containers
                Row(
                  children: [
                    _plusDays("1 day"),
                    SizedBox(
                      width: 10,
                    ),
                    _plusDays("2 days"),
                    SizedBox(
                      width: 10,
                    ),
                    _plusDays("3 days"),
                    SizedBox(
                      width: 10,
                    ),
                    _plusDays("4 days"),
                    SizedBox(
                      width: 10,
                    ),
                    _plusDays("5 days"),
                    SizedBox(
                      width: 10,
                    ),
                    _plusDays("6 days"),
                    SizedBox(
                      width: 10,
                    ),
                    _plusDays("7 days"),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(
            height: 5,
          ),
          Divider(),
          SizedBox(height: 15),
        ],
      ),
    );
  }

// ------- Plus days container  start here  --------
  Widget _plusDays(String dayValue, [Color color = Colors.black26]) {
    bool isDaySelected = daySelected == dayValue;
    return GestureDetector(
      onTap: () {
        setState(() {
          daySelected = dayValue;
          if (daySelected == "Exact dates") {
            displayCalendarDaysInfo = displayCalendarDaysValues;
          } else {
            displayCalendarDaysInfo =
                "$displayCalendarDaysValues - (+ $daySelected )";
          }
        });
      },
      child: _selectedPlusDaysCcontainer(
        dayValue,
        isDaySelected ? Colors.black : color,
      ),
    );
  }

  Container _selectedPlusDaysCcontainer(String dayValue, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                "+\n-",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  height: 0.6,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            dayValue,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
// ------- Plus days container ends here --------
//// ------- Dates container ends -------- ////

//// -------- Months container starts (SECOND) --------
  Widget _monthContainer() {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Row(
          //crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Month(s)",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (monthValue > 1) {
                        monthValue--;
                        endDateTextValue = _calculateEndDate();
                        print(
                            "STAYS decre endDateTextValue - : $endDateTextValue");
                        displayCalendarMonthsInfo =
                            _calculateEndDateWithoutYear();
                      }
                    });
                  },
                  child: incrementOrDecrementContainer("-"),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  monthValue.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (monthValue < 12) {
                        monthValue++;
                        endDateTextValue = _calculateEndDate();
                        print(
                            "STAYS incre endDateTextValue - : $endDateTextValue");
                        displayCalendarMonthsInfo =
                            _calculateEndDateWithoutYear();
                      }
                    });
                  },
                  child: incrementOrDecrementContainer("+"),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        _startingAndEndDateContainer("Starting date", statingDateTextValue!),
        SizedBox(height: 20),
        _startingAndEndDateContainer("End date", endDateTextValue!),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Row _startingAndEndDateContainer(String dateValue, String dateSettingDate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          dateValue,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          dateSettingDate,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
          ),
        )
      ],
    );
  }

//// -------- Months container ends --------

//// -------  Flexible containers starts (THIRD) --------
  Column _flexibleContainer() {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 25,
        ),
        RichText(
          //Text: Stay for
          text: TextSpan(
            text: "Stay for ",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: "${stayForSelected}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        //Stay for options container
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _stayForContainer("Weekend"),
            SizedBox(width: 10),
            _stayForContainer("Week"),
            SizedBox(width: 10),
            _stayForContainer("Month"),
          ],
        ),
        SizedBox(height: 30),
        //Go on month container
        _goOnMonthContainer()
      ],
    );
  }

  GestureDetector _stayForContainer(String stayForValue) {
    bool stayForSelectedOption = stayForSelected == stayForValue;
    return GestureDetector(
      onTap: () {
        setState(() {
          stayForSelected = stayForValue;
          displayCalendarFlexibleInfo = "$stayForSelected";
          goOnMonthSelected = "Anytime";
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[200],
          border: stayForSelectedOption
              ? Border.all(color: Colors.black, width: 2)
              : Border.all(color: Colors.black26),
        ),
        child: Text(
          stayForValue,
          style: TextStyle(
              color: stayForSelectedOption ? Colors.black87 : Colors.black38,
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Column _goOnMonthContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          //Text: Go
          text: TextSpan(
            text: "Go ",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: "$goOnMonthSelected",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        //Go on month options
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _goOnMonthContainerCalendar("Decemeber 2024"),
              SizedBox(width: 10),
              _goOnMonthContainerCalendar("January 2025"),
              SizedBox(width: 10),
              _goOnMonthContainerCalendar("February 2025"),
              SizedBox(width: 10),
              _goOnMonthContainerCalendar("March 2025"),
              SizedBox(width: 10),
              _goOnMonthContainerCalendar("April 2025"),
              SizedBox(width: 10),
              _goOnMonthContainerCalendar("May 2025"),
              SizedBox(width: 10),
              _goOnMonthContainerCalendar("June 2025"),
              SizedBox(width: 10),
              _goOnMonthContainerCalendar("July 2025"),
              SizedBox(width: 10),
              _goOnMonthContainerCalendar("August 2025"),
              SizedBox(width: 10),
              _goOnMonthContainerCalendar("September 2025"),
              SizedBox(width: 10),
              _goOnMonthContainerCalendar("October 2025"),
              SizedBox(width: 10),
              _goOnMonthContainerCalendar("November 2025"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _goOnMonthContainerCalendar(String monthValue) {
    bool goOnMonthSelectedValue = goOnMonthSelected == monthValue;
    return GestureDetector(
      onTap: () {
        setState(() {
          //goOnMonthSelected = "Anytime";
          goOnMonthSelected = monthValue;
          displayCalendarFlexibleInfo =
              "$stayForSelected in $goOnMonthSelected"; // it should be format "Weekend in December 2024"
        });
      },
      child: selectedMonthOrNotContainer(goOnMonthSelectedValue, monthValue),
    );
  }

  Container selectedMonthOrNotContainer(
      bool goOnMonthSelectedValue, String monthValue,
      {Border? border}) {
    border ??= Border.all(color: Colors.black);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: goOnMonthSelectedValue ? Colors.grey[300] : Colors.white,
        border: goOnMonthSelectedValue
            ? border
            : Border.all(
                color: Colors.black26,
              ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.calendar_month,
            color: Colors.black,
            size: 30,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            monthValue,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.1,
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
//// ------- Flexible containers ends -------

// ------- Reset or Next container starts here -------
  Row _resetOrNextContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Reset",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              if (selectedTripOption == "Dates" &&
                  displayCalendarDaysInfo != "Not date selected") {
                if (daySelected == "Exact dates") {
                  //Create a new Map to store the selected dates
                  whenIsYourTripFinalValues = {
                    "monthName": monthName(_dates[0]!.month),
                    "startDate": _dates[0]!,
                    "endDate": _dates[1]!,
                  };
                  whenIsYourTripChoice = displayCalendarDaysValues;
                } else {
                  //Create a new Map to store the selected dates
                  whenIsYourTripFinalValues = {
                    "monthName": monthName(_dates[0]!.month),
                    "startDate": _dates[0]!,
                    "endDate": _dates[1]!,
                    "plusDays": daySelected,
                  };
                  whenIsYourTripChoice = displayCalendarDaysInfo;
                }
              } else if (selectedTripOption == "Months" &&
                  displayCalendarMonthsInfo != "Not date selected") {
                //Create a new Map to store the selected dates
                whenIsYourTripFinalValues = {
                  "startDate": _dates[0]!,
                  "endDate": endDate,
                };

                whenIsYourTripChoice = displayCalendarMonthsInfo;
              } else if (selectedTripOption == "Flexible" &&
                  stayForSelected != null) {
                if (displayCalendarFlexibleInfo != "Not date selected" &&
                    goOnMonthSelected != "Anytime") {
                  //Create a new Map to store the selected dates with the selected options
                  whenIsYourTripFinalValues = {
                    "stayFor": stayForSelected,
                    "goOnMonth": goOnMonthSelected,
                  };
                  whenIsYourTripChoice = displayCalendarFlexibleInfo;
                } else {
                  if (goOnMonthSelected != "Anytime") {
                    //Create a new Map to store the selected dates with default month
                    whenIsYourTripFinalValues = {
                      "stayFor": stayForSelected,
                      "goOnMonth": goOnMonthSelected,
                    };
                    whenIsYourTripChoice = displayCalendarFlexibleInfo;
                  } else {
                    //Create a new Map to store the selected dates with previous "Stay for value" and a month
                    whenIsYourTripFinalValues = {
                      "stayFor": stayForSelected,
                      "goOnMonth": goOnMonthSelected,
                    };
                    whenIsYourTripChoice =
                        "$stayForSelected in $goOnMonthSelected";
                  }
                }
              }
              whosComing = null;
            });
          },
          child: Container(
            //color: Colors.black,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 15),
            child: Text(
              "Next",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }
// ------- Reset or Next container ends here -------

// ------- Collapse when is done picking the dates starts here -------
  Widget _collapseWhenIsTrip() {
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "When is your trip?",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          whenIsYourTripChoice ?? "",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
// ------- Collapse when is done picking the dates ends here -------

/* ------ Where is your trip MAIN CONTAINER (2) ends here ------- */

/* -------  Who is coming CONTAINERS (3) starts  here ------- */
  Widget _whosComingContainer() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Who's coming?",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //Options container
          _whosComingOptions(
            "Adults",
            "Ages 13 or above",
            adultQuantity,
            (newValue) {
              setState(() {
                adultQuantity = newValue;
                updateWhoComingFinalValues(adultQuantity, null, null, null);
              });
            },
          ),
          Divider(),
          _whosComingOptions(
            "Children",
            "Ages 2 - 12",
            childQuantity,
            (newValue) {
              setState(() {
                childQuantity = newValue;
                updateWhoComingFinalValues(null, childQuantity, null, null);
              });
            },
          ),
          Divider(),
          _whosComingOptions(
            "Infants",
            "Under 2",
            infantQuantity,
            (newValue) {
              setState(() {
                infantQuantity = newValue;
                updateWhoComingFinalValues(null, null, infantQuantity, null);
              });
            },
          ),
          Divider(),
          _whosComingOptions(
            "Pets",
            "Bringing a service animal?",
            petQuantity,
            (newValue) {
              setState(() {
                petQuantity = newValue;
                updateWhoComingFinalValues(null, null, null, infantQuantity);
              });
            },
            TextDecoration.underline,
          ),
        ],
      ),
    );
  }

  Widget _whosComingOptions(String header, String subHeader, int quantity,
      ValueChanged<int> onChanged,
      [TextDecoration? textDecoration = TextDecoration.none]) {
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
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subHeader,
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  decoration: textDecoration,
                ),
              ),
            ],
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  if (quantity > 0) {
                    onChanged(quantity - 1);
                  }
                },
                child: incrementOrDecrementContainer("-"),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                quantity.toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  onChanged(quantity + 1);
                },
                child: incrementOrDecrementContainer("+"),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container incrementOrDecrementContainer(String textValue) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
      ),
      child: Text(
        textValue,
        style: TextStyle(
            color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _collapsedWhoCominToGo() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Who",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            whosComing ?? "",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
/* ------- Who is coming CONTAINERS (3) ends here ------- */
}
