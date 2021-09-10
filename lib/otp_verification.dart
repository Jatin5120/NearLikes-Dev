// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert' show json;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:nearlikes/constants/constants.dart';

import '../page_guide.dart';
import '../register.dart';

class OTPVerification extends StatefulWidget {
  final String? phNum;
  const OTPVerification(this.phNum, {Key? key}) : super(key: key);

  @override
  _OTPVerificationState createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  var error = '';
  bool otpresend = false;
  bool expire = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  // String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = const BoxDecoration(
    color: Colors.transparent,
    //borderRadius: BorderRadius.circular(10.0),
    border: Border(
      bottom: BorderSide(width: 1.5, color: kPrimaryColor),
    ),
  );
  final BoxDecoration pinPutDecoration1 = const BoxDecoration(
    color: Colors.transparent,
    //borderRadius: BorderRadius.circular(10.0),
    border: Border(
      bottom: BorderSide(width: 1.5, color: kDividerColor),
    ),
  );

  final interval = const Duration(seconds: 1);

  final int maxtime = 120;

  int currentSeconds = 0;

  String get timerText =>
      '${((maxtime - currentSeconds) ~/ 60).toString().padLeft(2, '0')}:${((maxtime - currentSeconds) % 60).toString().padLeft(2, '0')}';

  startTimeout([int? milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      if (mounted) {
        setState(() {
          // print(timer.tick);
          currentSeconds = timer.tick;
          if (timer.tick >= maxtime) timer.cancel();
        });
      }
    });
  }

  var veri;
  var otp;

  // verifyPhoneNum(String phnum)async{
  //   print("inside verfi func");
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //       phoneNumber: '+91${widget.phNum}',
  //       timeout:Duration(seconds: 120) ,
  //       verificationCompleted: (PhoneAuthCredential cred)async{
  //         await FirebaseAuth.instance.signInWithCredential(cred).then((value)
  //         {if(value.user!=null){
  //           print('Loggeddddd innnnn');
  //         }
  //         else print('nott loggedddd in');
  //         });
  //       },
  //       verificationFailed: (FirebaseAuthException e){setState(() {error='Something went wrong, try again!';});},
  //       codeSent: (String verficationID,int resendToken)async{
  //         setState(() {veri=verficationID;});
  //       },
  //       codeAutoRetrievalTimeout:(String verficationID)async{
  //         setState(() {veri=verficationID;});
  //       } );
  // }

  @override
  void initState() {
    //verifyPhoneNum(widget.phNum);
    startTimeout();
    super.initState();
    startTimeout();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: kPrimaryColor,
                    size: 30,
                  )),
              const SizedBox(
                height: 22,
              ),
              Text(
                "OTP\nVerification",
                style: GoogleFonts.montserrat(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: kTextColor[300],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Enter the OTP sent to +91 ${widget.phNum.toString()}",
                style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: kTextColor,
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Image.asset('assets/login.png', width: 301, height: 301),
              const SizedBox(
                height: 0,
              ),
              Form(
                key: _formKey,
                child: PinPut(
                    fieldsCount: 6,
                    textStyle:
                        const TextStyle(fontSize: 25.0, color: kPrimaryColor),
                    eachFieldWidth: 20.0,
                    eachFieldHeight: 55.0,
                    focusNode: _pinPutFocusNode,
                    controller: _pinPutController,
                    submittedFieldDecoration: pinPutDecoration1,
                    selectedFieldDecoration: pinPutDecoration,
                    followingFieldDecoration: pinPutDecoration1,
                    pinAnimationType: PinAnimationType.fade,
                    onSubmit: (pin) {},
                    validator: (val) => val!.isEmpty ? 'Enter Otp' : null,
                    onChanged: (val) {
                      setState(() {
                        otp = val;
                      });
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              timerText == '00:00'
                  ? Center(
                      child: expire == false
                          ? InkWell(
                              onTap: () async {
                                var response = await http.get(Uri.parse(
                                    'http://api.msg91.com/api/retryotp.php?authkey=363206AVR1coo96wc60d47698P1&mobile=91${widget.phNum}&retrytype=text'));
                                print(response.body);
                                var decoded = json.decode(response.body);
                                var type = decoded['type'];
                                // var message = decoded['message'];
                                if (type == 'success') {
                                  setState(() {
                                    error = 'OTP resent successfully';
                                    expire = true;
                                  });
                                }
                                // verifyPhoneNum(widget.phNum);
                                // setState(() {expire=true;});
                              },
                              child: Center(
                                child: Container(
                                  height: 30,
                                  width: 100,
                                  child: Center(
                                      child: Text('Resend OTP',
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: Colors.white,
                                            //letterSpacing: 1
                                          ))),
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
                                ),
                              ),
                            )
                          : const Text('Code sent again'))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Center(
                              child: Text(
                            'Resend code in ',
                            style: GoogleFonts.montserrat(
                                color: Colors.black45, fontSize: 13),
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Center(
                            child: Text(
                              timerText,
                              style: GoogleFonts.montserrat(
                                  color: Colors.black45, fontSize: 13),
                            ),
                          ),
                        ),
                      ],
                    ),
              const SizedBox(
                height: 30,
              ),
              Center(
                  child: Text(
                error,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              )),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      var response = await http.get(Uri.parse(
                          'http://api.msg91.com/api/verifyRequestOTP.php?authkey=363206AVR1coo96wc60d47698P1&mobile=91${widget.phNum}&otp=$otp'));
                      print(response.body);
                      var decoded = json.decode(response.body);
                      var type = decoded['type'];
                      // var message = decoded['message'];
                      //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Register(widget.phNum)));
                      if (type == 'success') {
                        print('the num is ${widget.phNum}');
                        //checking if old or new user
                        var body = {
                          "phone": "${widget.phNum}",
                        };

                        var checkuser = await http.post(
                          Uri.parse(
                              'https://nearlikes.com/v1/api/client/check'),
                          headers: {"Content-Type": "application/json"},
                          body: json.encode(body),
                        );
                        print('the body is ${checkuser.body}');
                        print(checkuser.statusCode);
                        if (checkuser.body == '1') {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setBool('checkuser', true);
                          prefs.setString('phonenumber', widget.phNum!);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PageGuide(
                                        phoneNumber: widget.phNum,
                                      )));
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Register(widget.phNum)));
                        }
                      } else if (type == 'error') {
                        setState(() {
                          error = 'OTP Invalid';
                        });
                      }
                    }

                    // if(_formKey.currentState.validate()){
                    //   await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(
                    //       verificationId: veri, smsCode: otp)).catchError((e){setState(() {
                    //         error=e.toString();
                    //       });}).then((user) async {
                    //         if(user!=null){
                    //
                    //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Register()));
                    //         }
                    //   });
                    //           Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                    //}
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
            ],
          ),
        ),
      ),
    );
  }
}
