import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'constants.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    width: size.width * .9,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, color: Colors.black54.withOpacity(.6)),
                        const Expanded(
                          child: TextField(
                            showCursor: false,
                            decoration: InputDecoration(
                              hintText: 'Search Disease',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(Icons.mic, color: Colors.black54.withOpacity(.5)),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Constants.primaryColor.withOpacity(.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 50.0,
              width: size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10, // replace with your dynamic item count
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? Constants.primaryColor.withOpacity(.7)
                              : Constants.primaryColor.withOpacity(.3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            'Disease ${index + 1}', // replace with your dynamic item
                            style: TextStyle(
                              color: selectedIndex == index ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: size.height * .3,
              child: Center(
                child: Text(
                  'Content for Disease ${selectedIndex + 1}', // replace with your dynamic content
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16, bottom: 20, top: 20),
              child: const Text(
                'New Diseases',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
