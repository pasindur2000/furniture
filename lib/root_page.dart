import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:page_transition/page_transition.dart';
import '../constants.dart';
import 'signin_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _bottomNavIndex = 0;

  //List of the pages

  //List of the pages icons
  List<IconData> iconList = [
    Icons.home,
    Icons.history,
    Icons.person,
    Icons.people_rounded,
  ];

  //List of theh pages titles
  List<String> titleList = [
    'Home',
    'History',
    'Profile',
    'Community',
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(titleList[_bottomNavIndex], style: TextStyle(
              color: Constants.blackColor,
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ),),
            Icon(Icons.notifications, color: Constants.blackColor, size: 30.0,)
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        child: Image.asset('assets/images/2nd_icon.png', height: 38.0,),
        backgroundColor: Constants.primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        splashColor: Constants.primaryColor,
        activeColor: Constants.primaryColor,
        inactiveColor: Colors.black.withOpacity(.5),
        icons: iconList,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index){
          setState(() {
            _bottomNavIndex = index;
          });
        },
      ),


    );
  }
}
