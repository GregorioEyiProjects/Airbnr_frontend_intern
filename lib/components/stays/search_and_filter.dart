import 'package:airbnbr/views/stays/Stays.dart';
import 'package:flutter/material.dart';

class SearchAndFilter extends StatelessWidget {
  const SearchAndFilter({super.key, required Size size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 7,
                    )
                  ]),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: InkWell(
                  onTap: () {
                    //TODO: Implement search functionality
                  },
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Stays(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 32,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Where to?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 20,
                              width: 200,
                              child: TextField(
                                decoration: InputDecoration(
                                    enabled: false,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: "Anywhere, Any week, Anyplace",
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 9),
          //Filter container with icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                shape: BoxShape.circle),
            child: const Icon(
              Icons.tune,
              color: Colors.black,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}
