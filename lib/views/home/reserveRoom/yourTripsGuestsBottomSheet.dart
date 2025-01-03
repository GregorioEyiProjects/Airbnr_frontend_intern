import 'package:flutter/material.dart';

class EditGuests extends StatefulWidget {
  //CallBack function to update the dates
  final void Function(int adults, int children, int infants, int pets)
      onGuestsChanged;

//Constructor
  EditGuests({required this.onGuestsChanged});

//Create the state of the class
  @override
  State<StatefulWidget> createState() => _EditGuestsState();
}

//State of the class that uses the EditDays class
class _EditGuestsState extends State<EditGuests> {
  int adultQuantity = 0;
  int childQuantity = 0;
  int infantQuantity = 0;
  int petQuantity = 0;

  Map<String, dynamic> whosComingFinalValues = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateWhoComingFinalValues(
        adultQuantity, childQuantity, infantQuantity, petQuantity);
  }

  void updateWhoComingFinalValues(int? adultQuantity, int? childQuantity,
      int? infantQuantity, int? petQuantity) {
    setState(() {
      int previousAdultQuantity = this.adultQuantity;
      int previousChildQuantity = this.childQuantity;
      int previousInfantQuantity = this.infantQuantity;
      int previousPetQuantity = this.petQuantity;

      //Update the final values
      whosComingFinalValues = {
        "adults": adultQuantity ?? previousAdultQuantity,
        "child": childQuantity ?? previousChildQuantity,
        "infant": infantQuantity ?? previousInfantQuantity,
        "pet": petQuantity ?? previousPetQuantity,
      };

      // Update the state variables (In case i need them later on)
      if (adultQuantity != null) this.adultQuantity = adultQuantity;
      if (childQuantity != null) this.childQuantity = childQuantity;
      if (infantQuantity != null) this.infantQuantity = infantQuantity;
      if (petQuantity != null) this.petQuantity = petQuantity;

      // Call the callback function
      widget.onGuestsChanged(
          whosComingFinalValues["adults"],
          whosComingFinalValues["child"],
          whosComingFinalValues["infant"],
          whosComingFinalValues["pet"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 500,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.99,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // Close button
            InkWell(
              onTap: () {
                // Clear the guests
                updateWhoComingFinalValues(0, 0, 0, 0);
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
                    "Guests",
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
            //Text
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "This place has a maximun of ? guests, not including ?. ? Are not allowed.",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
            ),
            _whosComingContainer(),
            const SizedBox(height: 10),

            // Save button & clear button
            Container(
              decoration: BoxDecoration(
                //color: Colors.white,
                border: Border.all(color: Colors.black12),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      // Clear the guests
                      updateWhoComingFinalValues(0, 0, 0, 0);
                      // Close the modal
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
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
                      // Just because the Guests are already updated
                      // with the onGuestChanged callback
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
                  const SizedBox(width: 10),
                ],
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget _whosComingContainer() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Options container
          _whosComingOptions(
            "Adults",
            "Ages +13",
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

  _whosComingOptions(String header, String subHeader, int quantity,
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

Future<dynamic> openEditGuests(
    BuildContext context,
    void Function(int adults, int children, int infants, int pets)
        onDatesChanged) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return EditGuests(onGuestsChanged: onDatesChanged);
    },
  );
}
