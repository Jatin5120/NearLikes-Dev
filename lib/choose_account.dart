// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:nearlikes/constants/constants.dart';

import '../interests.dart';
import '../low_followers.dart';

class ChooseAccount extends StatefulWidget {
  final igDetails, phnum, name, igUserId, age, location, accessToken;
  const ChooseAccount(
      {Key? key,
      this.age,
      this.location,
      this.igDetails,
      this.phnum,
      this.name,
      this.igUserId,
      this.accessToken})
      : super(key: key);
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

  uploadUserData(String? accessToken) async {
    print('innn');
    print(accessToken);
    //String accesstoken='EAAG9VBauCocBALeqX0Owqm8ZCibZAb2UKe0vTL0VjRvCt7aNbLgab6kGh6AtLinwiWnz33d2A14CUX8ZB2G2BoGLMjQsr3hShBSN0FZBG6H1sQZCPumi2ZBR5R9hX6jVX2ZAl5mraAeZBCTy9a89nEyP9yUpkS4hALD5oYQakkugDTxZBobgH858ZC';
    var url = 'https://nearlikes.com/v1/api/client/add';
    var body = {
      "name": "${widget.name}",
      "age": widget.age,
      "insta": "${widget.igUserId}",
      "followers": 500,
      "location": "${widget.location}",
      "phone": "+91${widget.phnum}", // should contain +91,
      "token": "$accessToken", //insta access token
    };
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: json.encode(body));
    print(response.statusCode);
    print(';;;;;;');
    print(response.body);
    var decoded = json.decode(response.body);
    var customerId = decoded['customer_id'];
    print('azazaz $customerId');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('customer_id', customerId);
    print(';;;;;;;;;;;; $customerId');
    print(response.body);
    //addPlayer( customer_id);
    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    int? followersCount = widget.igDetails['followers_count'];
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
                  ),
                ),
              ),
              const SizedBox(height: 22),
              const SizedBox(height: 70),
              Image.asset('assets/logo.png', width: 65.54, height: 83),
              const SizedBox(height: 35),
              Center(
                child: Text(
                  "Choose Account",
                  style: GoogleFonts.montserrat(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: kTextColor[300],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  "Select the instagram account you \nwould like to associate with \nNearLikes.",
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: kTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              Container(
                height: 83,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    border: Border.all(color: const Color(0xffEBEAEA))),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Image.network(
                          widget.igDetails["profile_picture_url"],
                          width: 55,
                          height: 55),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      widget.igDetails['username'],
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: kTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'followers count: ${followersCount.toString()}',
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: kTextColor,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: InkWell(
                  onTap: () async {
                    if (followersCount! < 100) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LowFollowers(),
                        ),
                      );
                    } else if (followersCount > 100) {
                      var response = await uploadUserData(widget.accessToken);
                      print(response);
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('checkuser', true);
                      prefs.setString('phonenumber', widget.phnum);
                      print(widget.name.toString());
                      print(widget.phnum.toString());
                      print(widget.igUserId.toString());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChooseInterests(
                                    phoneNumber: widget.phnum,
                                    igDetails: widget.igDetails,
                                    phnum: widget.phnum,
                                    name: widget.name,
                                    igUserId: widget.igUserId,
                                    location: widget.location,
                                    age: widget.age,
                                  )));
                    }
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
                        child: Text('Confirm',
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
    const url = "https://nearlikes.com/privacy_policy.html";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchTerms() async {
    const url = "https://nearlikes.com/termsofservice.html";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
