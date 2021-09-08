import 'package:flutter/material.dart';
import 'package:nearlikes/home_page.dart';
import 'package:nearlikes/profile_page.dart';
import 'package:nearlikes/select_brand.dart';
import 'package:nearlikes/theme.dart';
import 'package:google_fonts/google_fonts.dart';
int number;
class PageGuide extends StatefulWidget {
  final phoneNumber;
  PageGuide({this.phoneNumber});
  @override
  _PageGuideState createState() => _PageGuideState();
}


class _PageGuideState extends State<PageGuide> {
  // var number;
  int _currentIndex=0;

  @override
  Widget build(BuildContext context) {
    final tabs=[
      HomePage(),
      SelectBrand(),
      ProfilePage(phoneNumber:widget.phoneNumber),
    ];
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 20,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 20,
        selectedItemColor: kPrimaryOrange,
        selectedIconTheme: IconThemeData(size: 22),
        selectedFontSize: 14,
        unselectedFontSize: 13,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title:Text('Home',style:GoogleFonts.poppins(fontSize: 13),),
            backgroundColor: kPrimaryOrange,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            title:Text('New Story',style:GoogleFonts.poppins(fontSize: 13),),
            backgroundColor: kPrimaryOrange,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title:Text('Profile',style:GoogleFonts.poppins(fontSize: 13),),
            backgroundColor: kPrimaryOrange,
          )
        ],
        onTap: (index){
          setState(() {
            _currentIndex=index;
          });
        },
      ),
    );
  }
}
