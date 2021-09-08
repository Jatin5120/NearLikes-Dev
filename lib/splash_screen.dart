import 'package:flutter/material.dart';
import 'package:nearlikes/home_page.dart';
import 'package:nearlikes/page_guide.dart';
import 'package:nearlikes/theme.dart';
import 'dart:async';
import 'package:shimmer/shimmer.dart';
import 'package:nearlikes/onboarding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';


class SplashScreen extends StatefulWidget {
  String playerId;
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String phonenumber;
  bool checkuser=false;

  @override
  void initState(){
    super.initState();
    //getPlayerId();
    _mockCheckForSession().then(
            (status) {
        _navigateToLogin();
        }
    );
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
    await Future.delayed(Duration(milliseconds: 6000), () {});

    return true;
  }

  void _navigateToHome(){
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) => PageGuide(phoneNumber: phonenumber)
        )
    );
  }

  void _navigateToLogin()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  checkuser = prefs.getBool('checkuser');
  phonenumber= prefs.getString('phonenumber');
  if(checkuser==true){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => PageGuide(phoneNumber: phonenumber,)));
  }
  else
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => OnBoarding()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 40,),
            Image.asset('assets/logo.png',width:366.65,height:366.65),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Shimmer.fromColors(
                  period: Duration(milliseconds: 2000),
                  baseColor: kBlack,
                  highlightColor: Colors.white.withOpacity(0.8),
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "NEARLIKES",
                      style: GoogleFonts.montserrat(
                          letterSpacing: 10,
                          fontSize:25.0,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),
//                Text(
//                  "LINK",
//                  style: TextStyle(
//                      letterSpacing: 3,
//                      fontSize: 50.0,
//                      fontWeight: FontWeight.bold,
//                  ),
//                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


}