import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nearlikes/account_setup.dart';
import 'package:nearlikes/link_UPI.dart';
import 'package:nearlikes/otp_verification.dart';
import 'theme.dart';

class LinkBank extends StatefulWidget {

  @override
  _LinkBankState createState() => _LinkBankState();
}




class _LinkBankState extends State<LinkBank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:40,vertical: 80),
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


              SizedBox(height: 0,),
              Image.asset('assets/logo.png',width:46.31,height:60.28),
              SizedBox(height: 25,),
              Center(
                child: Text("LINK BANK ACCOUNT",style: GoogleFonts.montserrat(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: kFontColor,
                ),),
              ),
              SizedBox(height: 20,),
              Center(
                child: Text("You need to link your bank account for instant withdrawal of money.",style: GoogleFonts.montserrat(
                  fontSize:13,
                  fontWeight: FontWeight.w400,
                  color: kDarkGrey,
                ),textAlign: TextAlign.center,),
              ),
              SizedBox(height: 40,),
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                height: 70.0,
                decoration: new BoxDecoration(
                  //color: kLightGrey,
                    border: Border.all(color: kLightGrey),
                    borderRadius: new BorderRadius.circular(
                        15.0)),
                child: TextFormField(
                  maxLines: 1,
                  onChanged: (value) {
                    //phone = value;
                  },
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: kDarkGrey,
                      fontWeight: FontWeight.w700),
                  cursorColor: kPrimaryOrange,
                  //autofocus: true,
                  decoration: InputDecoration(
                    prefixStyle: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: kDarkGrey,
                        fontWeight: FontWeight.w700),
                    isDense: true,
                    contentPadding:
                    EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                    prefixIcon: Icon(
                      Icons.person_outline_sharp,
                      color:kLightGrey,
                      size: 20,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(
                          width: 1, color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(
                          width: 1, color: Colors.transparent),
                    ),
                    labelText: "Payee Name",
                    labelStyle: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: kLightGrey,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(height: 22,),
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                height: 70.0,
                decoration: new BoxDecoration(
                  //color: kLightGrey,
                    border: Border.all(color: kLightGrey),
                    borderRadius: new BorderRadius.circular(
                        15.0)),
                child: TextFormField(
                  maxLines: 1,
                  onChanged: (value) {
                    //phone = value;
                  },
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: kDarkGrey,
                      fontWeight: FontWeight.w700),
                  cursorColor: kPrimaryOrange,
                  //autofocus: true,
                  decoration: InputDecoration(
                    prefixStyle: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: kDarkGrey,
                        fontWeight: FontWeight.w700),
                    isDense: true,
                    contentPadding:
                    EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                    prefixIcon: Icon(
                      Icons.account_box_outlined,

                      color:kLightGrey,
                      size: 20,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(
                          width: 1, color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(
                          width: 1, color: Colors.transparent),
                    ),
                    labelText: "Account Number",
                    labelStyle: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: kLightGrey,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(height: 22,),
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                height: 70.0,
                decoration: new BoxDecoration(
                  //color: kLightGrey,
                    border: Border.all(color: kLightGrey),
                    borderRadius: new BorderRadius.circular(
                        15.0)),
                child: TextFormField(
                  maxLines: 1,
                  onChanged: (value) {
                    //phone = value;
                  },
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: kDarkGrey,
                      fontWeight: FontWeight.w700),
                  cursorColor: kPrimaryOrange,
                  //autofocus: true,
                  decoration: InputDecoration(
                    prefixStyle: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: kDarkGrey,
                        fontWeight: FontWeight.w700),
                    isDense: true,
                    contentPadding:
                    EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                    prefixIcon: Icon(
                      Icons.vpn_key_outlined,
                      color:kLightGrey,
                      size: 20,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(
                          width: 1, color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(
                          width: 1, color: Colors.transparent),
                    ),
                    labelText: "IFSC Code",
                    labelStyle: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: kLightGrey,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(height: 22,),
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                height: 70.0,
                decoration: new BoxDecoration(
                  //color: kLightGrey,
                    border: Border.all(color: kLightGrey),
                    borderRadius: new BorderRadius.circular(
                        15.0)),
                child: TextFormField(
                  maxLines: 1,
                  onChanged: (value) {
                    //phone = value;
                  },
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: kDarkGrey,
                      fontWeight: FontWeight.w700),
                  cursorColor: kPrimaryOrange,
                  //autofocus: true,
                  decoration: InputDecoration(
                    prefixStyle: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: kDarkGrey,
                        fontWeight: FontWeight.w700),
                    isDense: true,
                    contentPadding:
                    EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                    prefixIcon: Icon(
                      Icons.account_balance_outlined,
                      color:kLightGrey,
                      size: 20,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(
                          width: 1, color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(
                          width: 1, color: Colors.transparent),
                    ),
                    labelText: "Bank Name",
                    labelStyle: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: kLightGrey,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(height: 29,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LinkUPI()));
                },
                child: Text("Use UPI ID instead",style: GoogleFonts.montserrat(
                  decoration: TextDecoration.underline,
                  fontSize:13,
                  fontWeight: FontWeight.w400,
                  color: kPrimaryOrange,
                ),textAlign: TextAlign.center,),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: InkWell(
                  onTap: (){
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => AccountSetup()));
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
                        child:  Text('Add Account',
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

            ],
          ),
        ),
      ),
    );
  }
}
