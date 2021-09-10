// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nearlikes/constants/constants.dart';
import '../models/get_customer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/widgets.dart';

Customer? _getCustomer;
String? customerId;
String? phonenumber;

class LinkUPI extends StatefulWidget {
  final String? phoneNumber;
  const LinkUPI({Key? key, this.phoneNumber}) : super(key: key);

  @override
  _LinkUPIState createState() => _LinkUPIState();
}

Future<Customer?> getCustomerID({phone}) async {
  print("2222");
  const String apiUrl = "https://nearlikes.com/v1/api/client/own/fetch/phone";
  var body = {"phone": "$phone"};
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: json.encode(body),
  );

  print("2222");
  print(response.statusCode);
  final String responseString = response.body.toString();

  print(responseString);
  _getCustomer = customerFromJson(responseString);
  print(_getCustomer!.customer!.upi);
  return _getCustomer;
}

Future<String> updateUPI({String? id, String? upi, String? email}) async {
  print("1111");
  const String apiUrl = "https://nearlikes.com/v1/api/client/add/pay";
  var body = {"id": "$id", "upi": "$upi", "email": "$email"};
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: json.encode(body),
  );

  print("1111");
  print(response.statusCode);
  if (response.statusCode == 200) {
    print("Updated");
    return "Successfully Updated!";
  } else {
    return "try again later!";
  }
}

class _LinkUPIState extends State<LinkUPI> {
  String upierror = '';
  bool upiLinked = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String? upi;
  String? email;

  Future<Customer?> getCustomer(String? customerId) async {
    print(".....");
    print(customerId);
    const String apiUrl = "https://nearlikes.com/v1/api/client/own/fetch";
    var body = {"id": "$customerId"};
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );

    print("..111...");
    print(response.body);
    final String responseString = response.body.toString();

    print('----111-------');
    _getCustomer = customerFromJson(responseString);

    print(";;;");

    print(_getCustomer!.customer!.upi);
    if (_getCustomer!.customer!.upi != null) {
      setState(() {
        upierror = 'UPI ID already linked';
        upiLinked = true;
      });
    }

    return _getCustomer;
  }

  Future getCustomerId(String? phonenumber) async {
    // var body = {
    //   "phone" : "+91$phonenumber"
    // };
    var body = {"phone": "+91$phonenumber"};
    final response = await http.post(
      Uri.parse('https://nearlikes.com/v1/api/client/getid'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );
    var test = jsonDecode(response.body);
    print('the response is $test');

    setState(() {
      customerId = test;
    });
    getCustomer(test);
    print('.,.111,.,.,$customerId');
  }

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // customerId= prefs.getString('customer_id');
    // phonenumber=prefs.getString('phonenumber');
    setState(() {
      customerId = prefs.getString('customer_id');
      phonenumber = prefs.getString('phonenumber');
    });
    print('the phone number is $phonenumber');
    print('user acc id is $customerId');
    if (customerId == null) {
      print('test');
      getCustomerId(phonenumber);
    } else {
      getCustomer(customerId);
    }
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //getCustomerID({phone})
    //getCustomerID(phone: "+917044065200");

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyBackButton(),
              Logo.small(),
              const SizedBox(
                height: 25,
              ),
              Center(
                child: Text(
                  "LINK UPI ID",
                  style: GoogleFonts.montserrat(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: kTextColor[300],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "You need to link your UPI for instant withdrawal of money.",
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: kTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      height: 75.0,
                      decoration: BoxDecoration(
                          //color: kDividerColor,
                          border: Border.all(color: kDividerColor),
                          borderRadius: BorderRadius.circular(15.0)),
                      child: TextFormField(
                        maxLines: 1,
                        onChanged: (value) {
                          upi = value;
                        },
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: kTextColor,
                            fontWeight: FontWeight.w700),
                        cursorColor: kPrimaryColor,
                        //autofocus: true,
                        decoration: InputDecoration(
                          prefixStyle: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: kTextColor,
                              fontWeight: FontWeight.w700),
                          isDense: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                          prefixIcon: const Icon(
                            Icons.person_outline_sharp,
                            color: kDividerColor,
                            size: 20,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.transparent),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.transparent),
                          ),
                          labelText: "UPI ID",
                          labelStyle: GoogleFonts.montserrat(
                              fontSize: 15,
                              color: kDividerColor,
                              fontWeight: FontWeight.w400),
                        ),
                        validator: (val) => (val!.isEmpty) ||
                                (val.length < 10) ||
                                (val.length > 10)
                            ? 'Enter valid UPI ID'
                            : null,
                        onSaved: (val) {
                          upi = val;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      height: 75.0,
                      decoration: BoxDecoration(
                          //color: kDividerColor,
                          border: Border.all(color: kDividerColor),
                          borderRadius: BorderRadius.circular(15.0)),
                      child: TextFormField(
                        maxLines: 1,
                        onChanged: (value) {
                          email = value;
                        },
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: kTextColor,
                            fontWeight: FontWeight.w700),
                        cursorColor: kPrimaryColor,
                        //autofocus: true,
                        decoration: InputDecoration(
                          prefixStyle: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: kTextColor,
                              fontWeight: FontWeight.w700),
                          isDense: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                          prefixIcon: const Icon(
                            Icons.mail_outline,
                            color: kDividerColor,
                            size: 20,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.transparent),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.transparent),
                          ),
                          labelText: "Email",
                          labelStyle: GoogleFonts.montserrat(
                              fontSize: 15,
                              color: kDividerColor,
                              fontWeight: FontWeight.w400),
                        ),
                        validator: (val) => (val!.isEmpty) ||
                                (val.length < 10) ||
                                (val.length > 10)
                            ? 'Enter valid email ID'
                            : null,
                        onSaved: (val) {
                          email = val;
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 200,
              ),
              // GestureDetector(
              //   onTap: (){
              //     Navigator.pop(context);
              //   },
              //   child: Text("Use Bank Details instead",style: GoogleFonts.montserrat(
              //     decoration: TextDecoration.underline,
              //     fontSize:13,
              //     fontWeight: FontWeight.w400,
              //     color: kPrimaryColor,
              //   ),textAlign: TextAlign.center,),
              // ),
              const SizedBox(
                height: 25,
              ),
              Text(
                upierror,
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: kPrimaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: InkWell(
                  onTap: () {
                    if (!upiLinked) {
                      setState(() async {
                        String response = await updateUPI(
                            upi: upi, email: email, id: "$customerId");
                        SnackBar snackBar = SnackBar(content: Text(response));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                      //updateUPI(upi: upi,email: email,id: _getCustomer.id);
                      Navigator.pop(context);
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => AccountSetup()));
                    } else {
                      SnackBar snackBar = const SnackBar(
                          content: Text('UPI ID Already linked'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                          upiLinked ? kDividerColor : kSecondaryColor,
                          upiLinked ? kDividerColor : kPrimaryColor,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Add Account',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.white,
                          //letterSpacing: 1
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }

  void showInSnackBar(String value) => ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(value)));
}
