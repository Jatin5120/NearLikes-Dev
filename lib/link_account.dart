// ignore_for_file: avoid_print

import 'dart:convert' show json;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:nearlikes/widgets/back_button.dart';
import 'package:nearlikes/widgets/logo.dart';
import 'package:nearlikes/widgets/tap_handler.dart';
import 'package:nearlikes/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../choose_account.dart';
import '../setup_instructions.dart';
import 'constants/constants.dart';
import 'services/services.dart';

class LinkAccount extends StatefulWidget {
  final phnum, name, age, location;
  const LinkAccount({Key? key, this.phnum, this.name, this.age, this.location})
      : super(key: key);

  @override
  _LinkAccountState createState() => _LinkAccountState();
}

class _LinkAccountState extends State<LinkAccount> {
  final fb = FacebookLogin();

  String? accessToken;
  String? accessId;
  String? igUserID;
  int stage = 0;
  String error = '';
  bool loading = false;

  fbLogin() async {
    final result = await FacebookAuth.instance.login(permissions: [
      "public_profile",
      "email",
      "instagram_basic",
      "pages_show_list",
      "instagram_manage_insights",
      "pages_read_engagement"
    ]);
    if (result.status == LoginStatus.success) {
      setState(() {
        accessToken = result.accessToken!.token;
        accessId = result.accessToken!.userId;
      });
    } else {
      return 'error';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        print(widget.location);
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SetupInstructions(
              phnum: widget.phnum,
              name: widget.name,
              age: widget.age,
              location: widget.location,
            ),
          ),
        ).then((value) => value as bool);
      },
      child: Scaffold(
          body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: size.height,
              child: Padding(
                padding: pagePadding(size),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const MyBackButton(),
                    const Logo.small(),
                    SizedBox(height: size.height.tenPercent),
                    Text(
                      "Link Account",
                      style: GoogleFonts.montserrat(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        color: kTextColor[300],
                      ),
                    ),
                    SizedBox(height: size.height.twoPointFivePercent),
                    Text(
                      "Login to Facebook to finish setting up your account.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: kTextColor,
                      ),
                    ),
                    const Spacer(),
                    TapHandler(
                      onTap: () async {
                        setState(() {
                          error = '';
                          loading = true;
                        });
                        var status = await fbLogin();
                        if (status == 'error') {
                          setState(() {
                            error = 'Please login Properly!';
                            loading = false;
                          });
                        } else {
                          //    var longtoken= await http.get(Uri.parse("https://graph.facebook.com/{graph-api-version}/oauth/access_token?grant_type=fb_exchange_token&client_id={app-id}&client_secret={app-secret}&fb_exchange_token={your-access-token}"));
                          var response = await http.get(Uri.parse(
                              'https://graph.facebook.com/v11.0/$accessId/accounts?access_token=$accessToken'));
                          print('inside facebook login');
                          print('the access token is $accessToken');
                          print('the id is $accessId');
                          print(response.body);
                          print(response.statusCode);
                          // print(response.statusCode);
                          if (response.statusCode == 200) {
                            var decoded = json.decode(response.body.toString());

                            var data = decoded['data'];
                            var igPageid = data[0]['id'];
                            print('the data is $data');
                            print('the instagram page id is $igPageid');
                            var response2 = await http.get(Uri.parse(
                                'https://graph.facebook.com/v11.0/$igPageid?fields=instagram_business_account&access_token=$accessToken'));
                            print('kjkjkjkj ${response2.statusCode}');
                            print('sajhdjasgdjlasgd');
                            print({response2.body});
                            if (response2.statusCode == 200) {
                              print('_____________');

                              var decoded2 = json.decode(response2.body);
                              var data = decoded2['instagram_business_account'];
                              if (data == null) {
                                setState(() {
                                  error =
                                      'Error Occurred!! Kindly read the Help';
                                  loading = false;
                                });
                              }
                              var igUserId = data['id'];
                              print(response2.statusCode);
                              print('the asasas $igPageid');

                              var response3 = await http.get(Uri.parse(
                                  "https://graph.facebook.com/v11.0/$igUserId?fields=name,profile_picture_url,username,followers_count,media_count&access_token=$accessToken"));
                              print('++++++++++++++');
                              print(response3.body);
                              print(response3.statusCode);
                              if (response2.statusCode == 200) {
                                if (response3.statusCode == 200) {
                                  var decoded3 = json.decode(response3.body);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChooseAccount(
                                        igDetails: decoded3,
                                        phnum: widget.phnum,
                                        name: widget.name,
                                        igUserId: igUserId,
                                        location: widget.location,
                                        age: widget.age,
                                        accessToken: accessToken,
                                      ),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    error = 'Your Internet might be Slow!';
                                  });
                                }
                              } else {
                                setState(() {
                                  error =
                                      'Error Occurred!! Kindly read the Help';
                                });
                              }
                            } else {
                              setState(() {
                                error = 'Error Occurred!! Kindly read the Help';
                              });
                            }
                          } else {
                            setState(() {
                              error = 'Error Occurred!! Kindly read the Help';
                            });
                          }

                          setState(() {
                            loading = false;
                          });
                        }
                      },
                      child: Container(
                        height: max(size.height.fivePercent, 48),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xff4D6AA6),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: Image.asset('assets/fb.png'),
                            ),
                            SizedBox(width: size.width.fivePercent),
                            Text(
                              'Login with Facebook',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: size.height.twoPercent),
                    Text(
                      error,
                      style: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Have trouble logging in? ",
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: kTextColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        TapHandler(
                          onTap: () {},
                          child: Text(
                            " HELP",
                            style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height.fivePercent),
                    const TermsAndConditions(),
                    SizedBox(height: size.height.twoPointFivePercent),
                  ],
                ),
              ),
            ),
          ),
          if (loading == true) const LoadingDialog()
        ],
      )),
    );
  }
}
