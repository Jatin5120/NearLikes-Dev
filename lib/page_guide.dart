import 'package:flutter/material.dart';
import '../home_page.dart';
import '../profile_page.dart';
import '../select_brand.dart';
import 'constants/constants.dart';

class PageGuide extends StatefulWidget {
  final String? phoneNumber;
  const PageGuide({this.phoneNumber, Key? key}) : super(key: key);
  @override
  _PageGuideState createState() => _PageGuideState();
}

class _PageGuideState extends State<PageGuide> {
  // var number;
  int _currentIndex = 0;
  late List<Widget> tabs;

  @override
  void initState() {
    super.initState();
    tabs = [
      const HomePage(),
      const SelectBrand(),
      ProfilePage(phoneNumber: widget.phoneNumber),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 20,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kPrimaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: kPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'New Story',
            backgroundColor: kPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: kPrimaryColor,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
