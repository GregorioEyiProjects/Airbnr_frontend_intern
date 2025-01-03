import 'dart:ffi';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

List<DateTime> _dates = [DateTime.now()];

Future<dynamic> openEditDays(
    BuildContext context, void Function(List<DateTime>) onDatesChanged, size) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: size.height * 0.6,
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
            CalendarDatePicker2(
              config: CalendarDatePicker2WithActionButtonsConfig(
                calendarType: CalendarDatePicker2Type.range,
              ),
              value: _dates,
              onValueChanged: (dates) {
                _dates = dates;
                onDatesChanged(dates);
              },
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Clear the date picker and set the default date
                          List<DateTime> currentDate = [DateTime.now()];
                          _dates = currentDate;
                          onDatesChanged(currentDate);
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
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      //Just cus the dates are already updated
                      // with the onDatesChanged callback
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 28, vertical: 10),
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
    },
  );
}
