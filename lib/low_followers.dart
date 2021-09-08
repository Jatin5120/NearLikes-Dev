import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nearlikes/account_setup.dart';
import 'package:nearlikes/otp_verification.dart';
import 'theme.dart';
import 'package:url_launcher/url_launcher.dart';

class LowFollowers extends StatefulWidget {

  @override
  _LowFollowersState createState() => _LowFollowersState();
}

class _LowFollowersState extends State<LowFollowers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:40,vertical: 90),
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


              SizedBox(height: 92,),
              Image.asset('assets/logo.png',width:65.54,height:83),
              SizedBox(height: 35,),
              Center(
                child: Text("Better luck next time",style: GoogleFonts.montserrat(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: kFontColor,
                ),),
              ),
              SizedBox(height: 20,),
              Center(
                child: Text("You need a minimum of 100 followers to continue.",style: GoogleFonts.montserrat(
                  fontSize:13,
                  fontWeight: FontWeight.w400,
                  color: kDarkGrey,
                ),textAlign: TextAlign.center,),
              ),
              SizedBox(height: 280,),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AccountSetup()));
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
                              kPrimaryPink,
                              kPrimaryOrange,
                            ],
                          )

                      ),
                      child: Center(
                        child:  Text('Back to Login',
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
                    Text("NearLikes’s  ",style: GoogleFonts.montserrat(
                      fontSize:13,
                      fontWeight: FontWeight.w400,
                      color: kDarkGrey,
                    ),textAlign: TextAlign.center,),
                    GestureDetector(
                      onTap: _launchPrivacy,
                      child: Text("Privacy",style: GoogleFonts.montserrat(
                        decoration: TextDecoration.underline,
                        fontSize:13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff5186F2),
                      ),textAlign: TextAlign.center,),
                    ),
                    Text("and  ",style: GoogleFonts.montserrat(
                      fontSize:13,
                      fontWeight: FontWeight.w400,
                      color: kDarkGrey,
                    ),textAlign: TextAlign.center,),
                    GestureDetector(
                      onTap: _launchTerms,
                      child: Text("Terms",style: GoogleFonts.montserrat(
                        decoration: TextDecoration.underline,
                        fontSize:13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff5186F2),
                      ),textAlign: TextAlign.center,),
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
    const url ="https://www.nearlikes.com/privacy";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchTerms() async {
    const url ="https://www.nearlikes.com/terms";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
