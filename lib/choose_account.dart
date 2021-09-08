import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nearlikes/SuccessSample.dart';
import 'package:nearlikes/interests.dart';
import 'package:nearlikes/low_followers.dart';
import 'package:nearlikes/otp_verification.dart';
import 'package:nearlikes/page_guide.dart';
import 'package:http/http.dart' as http;
import 'theme.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class ChooseAccount extends StatefulWidget {
  final ig_details,phnum,name,ig_userId,age,location,accessToken;
  ChooseAccount({this.age,this.location,this.ig_details,this.phnum,this.name,this.ig_userId,this.accessToken});
  @override
  _ChooseAccountState createState() => _ChooseAccountState();
}

class _ChooseAccountState extends State<ChooseAccount> {

  // addPlayer(String customerId)async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var PlayerId= prefs.getString('playerId');
  //   print('the player id inside chooseacc is $PlayerId');
  //   print('the customer id inside chooseacc is $customerId');
  //   var url = 'https://nearlikes.com/v1/api/client/add/player';
  //   var body=
  //     {
  //       "id": "$customerId",
  //       "push":"$PlayerId",
  //     };
  //   var response= await  http.post(Uri.parse(url),
  //       headers:{"Content-Type": "application/json"},
  //       body: json.encode(body));
  //   print(response.body);
  //   print(response.statusCode);
  //
  // }

  uploadUserData(String accessToken)async{
    print('innn');
    print(accessToken);
    //String accesstoken='EAAG9VBauCocBALeqX0Owqm8ZCibZAb2UKe0vTL0VjRvCt7aNbLgab6kGh6AtLinwiWnz33d2A14CUX8ZB2G2BoGLMjQsr3hShBSN0FZBG6H1sQZCPumi2ZBR5R9hX6jVX2ZAl5mraAeZBCTy9a89nEyP9yUpkS4hALD5oYQakkugDTxZBobgH858ZC';
    var url = 'https://nearlikes.com/v1/api/client/add';
    var body={
      "name": "${widget.name}",
      "age": widget.age,
      "insta": "${widget.ig_userId}",
      "followers": 500,
      "location": "${widget.location}",
      "phone": "+91${widget.phnum}", // should contain +91,
      "token": "$accessToken", //insta access token
    };
    var response= await  http.post(Uri.parse(url),
        headers:{"Content-Type": "application/json"},
        body: json.encode(body));
    print(response.statusCode);
    print(';;;;;;');
    print(response.body);
    var decoded= json.decode(response.body);
    var customer_id = decoded['customer_id'] ;
    print('azazaz $customer_id');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('customer_id', customer_id);
    print(';;;;;;;;;;;; $customer_id');
    print(response.body);
    //addPlayer( customer_id);
    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    int followers_count= widget.ig_details['followers_count'];
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
              SizedBox(height: 22,),

              //SizedBox(height: 15,),
              SizedBox(height: 70,),
              Image.asset('assets/logo.png',width:65.54,height:83),
              SizedBox(height: 35,),
              Center(
                child: Text("Choose Account",style: GoogleFonts.montserrat(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: kFontColor,
                ),),
              ),
              SizedBox(height: 20,),
              Center(
                child: Text("Select the instagram account you \nwould like to associate with \nNearLikes.",style: GoogleFonts.montserrat(
                  fontSize:13,
                  fontWeight: FontWeight.w400,
                  color: kDarkGrey,
                ),textAlign: TextAlign.center,),
              ),
              SizedBox(height: 40,),
              Container(
                height: 83,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10),),
                    border: Border.all(color: Color(0xffEBEAEA))
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Image.network(widget.ig_details["profile_picture_url"],width:55,height:55),
                    ),
                    SizedBox(width: 20,),
                    Text(widget.ig_details['username'],style: GoogleFonts.montserrat(
                      fontSize:15,
                      fontWeight: FontWeight.w500,
                      color: kDarkGrey,
                    ),),

                  ],
                ),
              ),
              SizedBox(height: 30,),
              Text('followers count: ${followers_count.toString()}',style: GoogleFonts.montserrat(
                fontSize:15,
                fontWeight: FontWeight.w500,
                color: kDarkGrey,
              ),),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: InkWell(
                  onTap: ()async{
                    if(followers_count<100){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LowFollowers()));
                    }
                    else if(followers_count>100){
                      var response = await uploadUserData(widget.accessToken);
                      print(response);
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setBool('checkuser', true );
                      prefs.setString('phonenumber', widget.phnum);
                      print(widget.name.toString());
                      print(widget.phnum.toString());
                      print(widget.ig_userId.toString());
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseInterests(phoneNumber:widget.phnum,ig_details: widget.ig_details,phnum: widget.phnum,name: widget.name,ig_userId: widget.ig_userId,location: widget.location,age: widget.age,)));



                    }
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
                        child:  Text('Confirm',
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