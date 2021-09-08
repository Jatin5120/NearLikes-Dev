import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nearlikes/account_setup.dart';
import 'package:nearlikes/otp_verification.dart';
import 'theme.dart';

class Help extends StatefulWidget {

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
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
              Image.asset('assets/logo.png',width:46.31,height:60.28),
              SizedBox(height: 35,),
              Center(
                child: Text("HELP",style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: kFontColor,
                ),),
              ),
              SizedBox(height: 20,),
              Center(
                child: Text('We are happy to help you. \nFeel free to contact.',textAlign:TextAlign.center,style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: kFontColor,
                ),),
              ),

              SizedBox(height: 30,),
              Icon(Icons.mail_outline,color: kPrimaryOrange,),
              SizedBox(height: 13,),
              Text('''Email''',textAlign:TextAlign.start,style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: kFontColor,
              ),),
              SizedBox(height: 2,),
              Center(
                child: Text('''support@nearlikes.com''',textAlign:TextAlign.center,style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: kFontColor,
                ),),
              ),
              SizedBox(height: 20,),
              Icon(Icons.phone,color: kPrimaryOrange,),

              SizedBox(height: 13,),
              Text('''Phone''',textAlign:TextAlign.start,style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: kFontColor,
              ),),
              SizedBox(height: 2,),
              Center(
                child: Text('''Call: +91 9392708293''',textAlign:TextAlign.center,style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: kFontColor,
                ),),
              ),
              SizedBox(height: 20,),
              Icon(Icons.phone_android,color: kPrimaryOrange,),
              SizedBox(height: 13,),
              Text('''Message''',textAlign:TextAlign.start,style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: kFontColor,
              ),),
              SizedBox(height: 2,),
              Center(
                child: Text('''WhatsApp: +91 9392708293''',textAlign:TextAlign.center,style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: kFontColor,
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
