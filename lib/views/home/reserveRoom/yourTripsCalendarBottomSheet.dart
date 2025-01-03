import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

class EditDays extends StatefulWidget {
  //CallBack function to update the dates
  final void Function(List<DateTime>) onDatesChanged;

//Constructor
  EditDays({required this.onDatesChanged});

//Create the state of the class
  @override
  State<StatefulWidget> createState() => _EditDaysState();
}

//State of the class that uses the EditDays class
class _EditDaysState extends State<EditDays> {
  List<DateTime> _dates = [DateTime.now()];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          // Close button
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(children: [
                Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                const SizedBox(width: 20),
                Text(
                  "Dates",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                )
              ]),
            ),
          ),
          const Divider(),
          // Date picker
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              width: MediaQuery.of(context).size.width, // Set a specific width
              child: CalendarDatePicker2(
                config: CalendarDatePicker2WithActionButtonsConfig(
                  calendarType: CalendarDatePicker2Type.range,
                ),
                value: _dates,
                onValueChanged: (dates) {
                  setState(() {
                    _dates = dates;
                  });
                  widget.onDatesChanged(dates);
                },
              ),
            ),
          ),
          // Save button & clear button
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black12),
            ),
            child: Row(
              children: [
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    // Clear the date picker and set the default date
                    List<DateTime> defaultDate = [DateTime.now()];
                    setState(() {
                      _dates = defaultDate;
                    });
                    widget.onDatesChanged(defaultDate);
                  },
                  child: Text(
                    "Clear",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        decoration: TextDecoration.underline),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    // Just because the dates are already updated
                    // with the onDatesChanged callback
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 8),
                        Text(
                          "Save",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16)
              ],
            ),
          )
        ],
      ),
    );
  }
}

Future<dynamic> openEditDays(
    BuildContext context, void Function(List<DateTime>) onDatesChanged) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return EditDays(onDatesChanged: onDatesChanged);
    },
  );
}
