// ignore_for_file: avoid_print

import 'dart:convert' show json;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:nearlikes/widgets/long_button.dart';

import '../otp_verification.dart';
import 'constants/constants.dart';
import 'widgets/widgets.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Uri backgroundAssetUri = Uri.parse(
      "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/2022-chevrolet-corvette-z06-1607016574.jpg?crop=0.737xw:0.738xh;0.181xw,0.218xh&resize=980:*");
  final TextEditingController _phoneNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? phNum;
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width.tenPercent,
              vertical: size.height.fivePercent,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MyBackButton(),
                    SizedBox(height: size.height.twoPointFivePercent),
                    Text(
                      "Login",
                      style: GoogleFonts.montserrat(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: kTextColor[300],
                      ),
                    ),
                    SizedBox(height: size.height.onePercent),
                    Text(
                      "Enter your phone number to get started.",
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: kTextColor,
                      ),
                    ),
                    SizedBox(height: size.height.onePercent),
                    SizedBox(
                      width: double.maxFinite,
                      child: Image.asset('assets/login.png'),
                    ),
                    SizedBox(height: size.height.onePercent),
                    Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: kDividerColor),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _phoneNumberController,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: kTextColor,
                            fontWeight: FontWeight.w700,
                          ),
                          cursorColor: kPrimaryColor,
                          autofocus: true,
                          decoration: InputDecoration(
                            prefixText: '+91 ',
                            prefixStyle: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: kTextColor,
                              fontWeight: FontWeight.w700,
                            ),
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                            prefixIcon: const Icon(
                              Icons.phone_android,
                              color: kDividerColor,
                              size: 20,
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            labelText: "Mobile Number",
                            labelStyle: GoogleFonts.montserrat(
                                fontSize: 15,
                                color: kDividerColor,
                                fontWeight: FontWeight.w400),
                          ),
                          validator: (val) => (val!.isEmpty)
                              ? "Phone number can't be Empty"
                              : (val.length < 10)
                                  ? 'Enter Proper Phone Number'
                                  : null,
                          onChanged: (val) {
                            phNum = val;
                          },
                          onSaved: (val) {
                            phNum = val;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: size.height.twoPointFivePercent),
                    Center(
                      child: Text(
                        error,
                        style: const TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height.twoPointFivePercent),
                    LongButton(
                      label: 'Continue',
                      givePadding: false,
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          var rand =
                              (Random().nextInt(900000) + 100000).toString();
                          print(rand);
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => OTPVerification(phNum)));
                          final http.Response response = await http.get(Uri.parse(
                              'https://api.msg91.com/api/sendotp.php?authkey=363206AVR1coo96wc60d47698P1&mobile=91$phNum&message=Your%20otp%20is%20$rand&sender=smsind&otp=$rand'));
                          var decoded = json.decode(response.body);
                          print(response.body);
                          var type = decoded['type'];

                          if (type == 'success') {
                            setState(() {
                              loading = false;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OTPVerification(phNum),
                              ),
                            );
                          } else {
                            setState(() {
                              error = 'Something went wrong, Try again!';
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                  ],
                ),
                if (loading == true) const LoadingDialog()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
