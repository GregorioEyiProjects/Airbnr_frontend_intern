//Temporary data
Map<String, dynamic> placesToGo = {
  "places": [
    {
      "name": "I am flexible",
      "image":
          "https://mapofeurope.com/wp-content/uploads/2013/11/world-map.jpg"
    },
    {
      "name": "Europe",
      "image":
          "https://labeledmaps.com/wp-content/uploads/2023/04/europe-labeled-map-colored-scaled.jpg"
    },
    {
      "name": "Japan",
      "image":
          "https://i.pinimg.com/736x/de/bd/8b/debd8b320f894fed612dd87b10a0a3c9.jpg"
    },
    {
      "name": "Australia",
      "image":
          "https://labeledmaps.com/wp-content/uploads/2024/03/australia-labeled-map-colored-12-1-900x675.jpg"
    },
    {
      "name": "South Korea",
      "image":
          "https://c8.alamy.com/comp/2PGR7TT/colorful-south-korea-political-map-with-clearly-labeled-separated-layers-vector-illustration-2PGR7TT.jpg"
    },
    {
      "name": "United States",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Map_of_USA_with_state_and_territory_names_2.png/1200px-Map_of_USA_with_state_and_territory_names_2.png"
    },
    {
      "name": "United Kingdom",
      "image":
          "https://ukmap360.com/img/1200/united%20kingdom%20(uk)-regions-map.jpg"
    },
    {
      "name": "South America",
      "image":
          "https://i.etsystatic.com/34794111/r/il/759f8a/4215331704/il_fullxfull.4215331704_1xo8.jpg"
    },
    {
      "name": "Malesia",
      "image": "https://c8.alamy.com/comp/G08GWB/map-of-malaysia-G08GWB.jpg"
    },
  ]
};

List<DateTime?> _dates = [DateTime.now()];

String monthName(int month) {
  const monthNames = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  return monthNames[month - 1];
}

//To update the displayCalendarDays string to reflect the selected dates.
String displayCalendarDays = "Not date selected";
void _updateDisplayCalendarDays() {
  if (_dates.isNotEmpty && _dates[0] != null) {
    if (_dates.length > 1 && _dates[1] != null) {
      DateTime start = _dates[0]!;
      DateTime end = _dates[1]!;
      displayCalendarDays =
          "${monthName((start.month))} ${start.day}-${end.day}";
    } else {
      DateTime start = _dates[0]!;
      displayCalendarDays = "${monthName(start.month)} ${start.day}";
    }
  } else {
    displayCalendarDays = "Not date selected";
  }
}

// Calculate the end date for the Months option
String calculateEndDate(int monthValue) {
  if (_dates.isNotEmpty && _dates[0] != null) {
    DateTime startDate = _dates[0]!;
    DateTime endDate =
        DateTime(startDate.year, startDate.month + monthValue, startDate.day);
    return formatDate(endDate);
  }
  return "Not date selected";
}

String formatDate(DateTime date) {
  return "${monthName(date.month)} ${date.day}, ${date.year}";
}

String calculateEndDateWithoutYear(int monthValue) {
  if (_dates.isNotEmpty && _dates[0] != null) {
    DateTime startDate = _dates[0]!;
    DateTime endDate =
        DateTime(startDate.year, startDate.month + monthValue, startDate.day);
    String startDay = _formatDateWithoutYear(startDate);
    String endDay = _formatDateWithoutYear(endDate);
    return "$startDay - $endDay";
    //return _formatDateWithoutYear(endDate);
  }
  return "Not date selected";
}

String _formatDateWithoutYear(DateTime date) {
  return "${monthName(date.month)} ${date.day}";
}
