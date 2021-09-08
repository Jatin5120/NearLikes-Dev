// ignore: implementation_imports
import 'package:flutter/src/widgets/actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nearlikes/choose_account.dart';
import 'package:nearlikes/setup_instructions.dart';
import 'package:url_launcher/link.dart';
import 'theme.dart';
import 'dart:convert'show json;
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';




class LinkAccount extends StatefulWidget {
  final phnum,name,age,location;
  LinkAccount({this.phnum,this.name,this.age,this.location});

  @override
  _LinkAccountState createState() => _LinkAccountState();
}

class _LinkAccountState extends State<LinkAccount> {
  final fb = FacebookLogin();

  String accessToken;
  String accessId;
  String igUserID;
  int stage = 0;
  String error='';
  bool loading=false;



  Fb_login()async{
    final result = await  FacebookAuth.instance.login(permissions: ["public_profile","email","instagram_basic","pages_show_list","instagram_manage_insights","pages_read_engagement"]);
    if(result.status == LoginStatus.success ){
      setState(() {
        accessToken= result.accessToken.token;
        accessId=result.accessToken.userId;
      });
    }
    else return 'error';
  }




  @override
  Widget build(BuildContext context) {
    return WillPopScope( onWillPop:(){
      print('0505050');
      print(widget.location);
      return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SetupInstructions(phnum: widget.phnum,name: widget.name,age:widget.age,location: widget.location,)));
    },
    child:Scaffold(

        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 90),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                          onTap: (){
                            print('09090909');
                            print(widget.location);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SetupInstructions(phnum: widget.phnum,name: widget.name,age:widget.age,location: widget.location,)));
                          },
                          child: Icon(Icons.arrow_back,color: kPrimaryOrange,size: 30,)),
                    ),
                    SizedBox(height: 22,),

                    //SizedBox(height: 15,),
                    SizedBox(height: 70,),
                    Image.asset('assets/logo.png', width: 65.54, height: 83),
                    SizedBox(height: 35,),
                    Center(
                      child: Text("Link Account", style: GoogleFonts.montserrat(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        color: kFontColor,
                      ),),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Text(
                        "Login to Facebook to finish setting \nup your account.",
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: kDarkGrey,
                        ), textAlign: TextAlign.center,),
                    ),
                    SizedBox(height: 40,),
                    // FlatButton(onPressed: (){
                    //   fb.logOut();}, child:Text('logout')),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: InkWell(

                        onTap: () async {
                          setState(() {error='';
                          loading=true;});
                          var status= await Fb_login();
                          if(status=='error'){
                            setState(() {error='Please login Properly!';loading=false;});
                          }
                          else{
                            //    var longtoken= await http.get(Uri.parse("https://graph.facebook.com/{graph-api-version}/oauth/access_token?grant_type=fb_exchange_token&client_id={app-id}&client_secret={app-secret}&fb_exchange_token={your-access-token}"));
                            var response = await http.get(Uri.parse('https://graph.facebook.com/v11.0/$accessId/accounts?access_token=$accessToken'));
                            print('inside facebook login');
                            print('the access token is $accessToken');
                            print('the id is $accessId');
                            print(response.body);
                            print(response.statusCode);
                            // print(response.statusCode);
                            if(response.statusCode == 200) {
                              var decoded = json.decode(response.body.toString()) ;

                              var data= decoded['data'] ;
                              var ig_pageid=data[0]['id'];
                              print('the data is $data');
                              print('the instagram page id is $ig_pageid');
                              var response2 = await http.get(Uri.parse('https://graph.facebook.com/v11.0/$ig_pageid?fields=instagram_business_account&access_token=$accessToken'));
                              print('kjkjkjkj ${response2.statusCode}');
                              print('sajhdjasgdjlasgd');
                              print({response2.body});
                              if(response2.statusCode==200){
                                print('_____________');

                                var decoded2= json.decode(response2.body);
                                var data=decoded2['instagram_business_account'];
                                if(data==null){setState(() {
                                  error='Error Occurred!! Kindly read the Help';
                                  loading=false;
                                });}
                                var ig_userId= data['id'];
                                print(response2.statusCode);
                                print('the asasas $ig_pageid');


                                var response3= await http.get(Uri.parse("https://graph.facebook.com/v11.0/$ig_userId?fields=name,profile_picture_url,username,followers_count,media_count&access_token=$accessToken"));
                                print('++++++++++++++');
                                print(response3.body);
                                print(response3.statusCode);
                                if(response2.statusCode==200){
                                  if(response3.statusCode==200){
                                    var decoded3= json.decode(response3.body);
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => ChooseAccount(ig_details: decoded3,phnum: widget.phnum,name: widget.name,ig_userId: ig_userId,location: widget.location,age: widget.age,accessToken: accessToken,)));
                                  }else setState(() {
                                    error='Your Internet might be Slow!';
                                  });

                                } else setState(() {
                                  error='Error Occurred!! Kindly read the Help';
                                });
                              }
                              else setState(() {
                                error='Error Occurred!! Kindly read the Help';
                              });

                            }
                            else setState(() {
                              error='Error Occurred!! Kindly read the Help';
                            });

                            setState(() {loading=false;});
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
                                    Color(0xff4D6AA6),
                                    Color(0xff4D6AA6),
                                  ],
                                )

                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/fb.png', width: 21,
                                      height: 21),
                                  SizedBox(width: 20,),
                                  Text('Login with Facebook',
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Colors.white,
                                        //letterSpacing: 1
                                      )),
                                ],
                              ),
                            )),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Have trouble logging in? ", style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: kDarkGrey,
                          ), textAlign: TextAlign.center,),
                          GestureDetector(
                            onTap: (){},
                            child: Text(" HELP", style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: kPrimaryOrange,
                            ), textAlign: TextAlign.center,),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25,),
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
                    SizedBox(height: MediaQuery.of(context).size.height-600,),
                    Text(error,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ),
            loading==true?Padding(
              padding:const EdgeInsets.only(top: 250,),
              child: Center(
                child: CircularProgressIndicator(
                  //valueColor: Colors.black,
                  //Color: Colors.black,
                  backgroundColor: Colors.white,
                ),
              ),
            ):Container(height: 0,),
          ],
        )
    ) ,
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
