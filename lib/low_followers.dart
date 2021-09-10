import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:nearlikes/constants/constants.dart';

import '../account_setup.dart';

class LowFollowers extends StatefulWidget {
  const LowFollowers({Key? key}) : super(key: key);

  @override
  _LowFollowersState createState() => _LowFollowersState();
}

class _LowFollowersState extends State<LowFollowers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: kPrimaryColor,
                      size: 30,
                    )),
              ),
              const SizedBox(
                height: 92,
              ),
              Image.asset('assets/logo.png', width: 65.54, height: 83),
              const SizedBox(
                height: 35,
              ),
              Center(
                child: Text(
                  "Better luck next time",
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
                  "You need a minimum of 100 followers to continue.",
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: kTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 280,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AccountSetup()));
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
                          )),
                      child: Center(
                        child: Text('Back to Login',
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
