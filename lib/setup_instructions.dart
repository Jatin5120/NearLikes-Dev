// ignore: implementation_imports
import 'package:flutter/src/widgets/actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nearlikes/choose_account.dart';
import 'package:nearlikes/link_account.dart';
import 'package:url_launcher/link.dart';
import 'theme.dart';
import 'dart:convert'show json;
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class SetupInstructions extends StatefulWidget {
  final phnum,name,age,location;
  SetupInstructions({this.phnum,this.name,this.age,this.location});

  @override
  _SetupInstructionsState createState() => _SetupInstructionsState();
}

class _SetupInstructionsState extends State<SetupInstructions> {
var  videoId = YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=9rdnmbAp9k4");


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
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back,color: kPrimaryOrange,size: 30,)),
                ),



                SizedBox(height: 70,),
                Image.asset('assets/logo.png', width: 65.54, height: 83),
                SizedBox(height: 35,),
                Center(
                  child: Text("How to setup your instagram", style: GoogleFonts.montserrat(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: kFontColor,
                  ),),
                ),
                SizedBox(height: 10,),
                Center(
                  child: Text(
                    "Follow the steps below to setup your instagram account.",
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: kDarkGrey,
                    ), textAlign: TextAlign.center,),
                ),
                SizedBox(height: 40,),

                YoutubePlayer(
                  controller: YoutubePlayerController(
                    initialVideoId: '$videoId', //Add videoID.
                    flags: YoutubePlayerFlags(
                      hideControls: false,
                      controlsVisibleAtStart: true,
                      autoPlay: false,
                      mute: false,
                    ),
                  ),
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.white,
                ),
                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Step wise guide -> ", style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: kDarkGrey,
                      ), textAlign: TextAlign.center,),
                      GestureDetector(
                        onTap: (){},
                        child: Text("HELP", style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryOrange,
                        ), textAlign: TextAlign.center,),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: InkWell(
                    onTap: () async {
                     print('080808');
                     print(widget.location);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LinkAccount(phnum: widget.phnum,name: widget.name,age:widget.age,location: widget.location,)));
                    },
                    child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xffC13584),
                                kPrimaryPink,
                                kPrimaryOrange,
                              ],
                            )

                        ),
                        child: Center(
                          child: Text('Next',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Colors.white,
                                    //letterSpacing: 1
                                  )),


                        )),
                  ),
                ),
                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("NearLikes’s  ", style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: kDarkGrey,
                      ), textAlign: TextAlign.center,),
                      GestureDetector(
                        onTap: _launchPrivacy,
                        child: Text("Privacy", style: GoogleFonts.montserrat(
                          decoration: TextDecoration.underline,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff5186F2),
                        ), textAlign: TextAlign.center,),
                      ),
                      Text("and  ", style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: kDarkGrey,
                      ), textAlign: TextAlign.center,),
                      GestureDetector(
                        onTap: _launchTerms,
                        child: Text("Terms", style: GoogleFonts.montserrat(
                          decoration: TextDecoration.underline,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff5186F2),
                        ), textAlign: TextAlign.center,),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
              ],
            ),
          ),
        )
    );
  }

_launchPrivacy() async {
  const url ="https://nearlikes.com/privacy_policy.html";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
_launchTerms() async {
  const url ="https://nearlikes.com/termsofservice.html";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
}
