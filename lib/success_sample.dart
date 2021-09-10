import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../page_guide.dart';
import 'constants/constants.dart';

class SuccessSample extends StatefulWidget {
  final phoneNumber;
  final interests;
  const SuccessSample({Key? key, this.phoneNumber, this.interests})
      : super(key: key);
  @override
  _SuccessSampleState createState() => _SuccessSampleState();
}

class _SuccessSampleState extends State<SuccessSample> {
  late ConfettiController _controllerTopCenter;
  List? mySelTeams;
  String animationName = "celebrationstart";

  void _playAnimation() {
    setState(() {
      if (animationName == "celebrationstart") {
        animationName = "celebrationstop";
      } else {
        animationName = "celebrationstart";
      }
    });
  }

  @override
  void initState() {
    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerTopCenter.play();
    _playAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: GestureDetector(
              //       onTap: (){
              //         Navigator.pop(context);
              //       },
              //       child: Icon(Icons.arrow_back,color: kPrimaryColor,size: 30,)),
              // ),
              const SizedBox(
                height: 92,
              ),
              Image.asset('assets/tick.png', width: 200, height: 200),
              const SizedBox(
                height: 35,
              ),
              Center(
                child: Text(
                  "Success!",
                  style: GoogleFonts.montserrat(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: kTextColor[300],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "Your instagram account was \nsuccessfully linked.",
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: kTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 200,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: InkWell(
                  onTap: () async {
                    //storing for new acc or old acc
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool('checkuser', true);
                    prefs.setString('phonenumber', widget.phoneNumber);

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PageGuide(phoneNumber: widget.phoneNumber)));
                  },
                  child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            kSecondaryColor,
                            kPrimaryColor,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text('Continue to Dashboard',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.white,
                              //letterSpacing: 1
                            )),
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "NearLikes’s  ",
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: kTextColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    GestureDetector(
                      onTap: _launchPrivacy,
                      child: Text(
                        "Privacy",
                        style: GoogleFonts.montserrat(
                          decoration: TextDecoration.underline,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff5186F2),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      "and  ",
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: kTextColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    GestureDetector(
                      onTap: _launchTerms,
                      child: Text(
                        "Terms",
                        style: GoogleFonts.montserrat(
                          decoration: TextDecoration.underline,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff5186F2),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchPrivacy() async {
    const url = "https://www.nearlikes.com/privacy";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchTerms() async {
    const url = "https://www.nearlikes.com/terms";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
