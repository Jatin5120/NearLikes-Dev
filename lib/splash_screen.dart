import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import 'package:nearlikes/constants/constants.dart';

import '../onboarding.dart';
import '../page_guide.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? phonenumber;
  bool? checkuser = false;

  @override
  void initState() {
    super.initState();
    //getPlayerId();
    _mockCheckForSession().then((status) {
      _navigateToLogin();
    });
  }
  // getPlayerId()async {
  //   print('inside the getPlayerId');
  //   final status = await OneSignal.shared.getDeviceState();
  //   final String osUserID = status.userId;
  //   print('the player id is $osUserID');
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('playerId',osUserID).then((value) => print('job done $value'));
  // }

  Future<bool> _mockCheckForSession() async {
    await Future.delayed(const Duration(milliseconds: 6000), () {});

    return true;
  }

  // void _navigateToHome() {
  //   Navigator.of(context).pushReplacement(MaterialPageRoute(
  //       builder: (BuildContext context) =>
  //           PageGuide(phoneNumber: phonenumber)));
  // }

  void _navigateToLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    checkuser = prefs.getBool('checkuser');
    phonenumber = prefs.getString('phonenumber');
    if (checkuser == true) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => PageGuide(
                phoneNumber: phonenumber,
              )));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const OnBoarding()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.05),
          Image.asset(
            'assets/logo.png',
            width: size.width * 0.75,
            height: size.width * 0.75,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Shimmer.fromColors(
                period: const Duration(milliseconds: 2000),
                baseColor: kTextColor[700]!,
                highlightColor: Colors.white.withOpacity(0.8),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "NEARLIKES",
                    style: GoogleFonts.montserrat(
                        letterSpacing: 10,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
