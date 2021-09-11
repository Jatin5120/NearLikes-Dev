// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:intl/intl.dart';
import 'package:nearlikes/widgets/back_button.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:nearlikes/constants/constants.dart';

import '../setup_instructions.dart';
import 'widgets/widgets.dart';

class Register extends StatefulWidget {
  final String? phNum;
  const Register(this.phNum, {Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

Position? position;
String error = '';
String error1 = '';

class _RegisterState extends State<Register> {
  void getLocation() async {
    position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .catchError((e) {
      setState(() {
        error = e.toString();
      });

      print(e.toString());
    });
    print(position);
    var address = await GeocodingPlatform.instance
        .placemarkFromCoordinates(position!.latitude, position!.longitude);
    print(address);
    print(address.first.locality);
    setState(() {
      location = address.first.locality;
    });
  }

  // static final kInitialPosition = LatLng(15.9129, 79.7400);
  PickResult? selectedPlace;
  String? name;
  String? location;
  String? dob;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    getLocation();
    super.initState();
  }

  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: pagePadding(size),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MyBackButton(),
              Text(
                "Register",
                style: GoogleFonts.montserrat(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: kTextColor[300],
                ),
              ),
              SizedBox(height: size.height.onePercent),
              Text(
                "Enter your details to get started.",
                style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: kTextColor,
                ),
              ),
              SizedBox(height: size.height.onePercent),
              SizedBox(
                height: size.height.fortyPercent,
                child: Image.asset('assets/login.png'),
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
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          name = value;
                        },
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: kTextColor,
                            fontWeight: FontWeight.w700),
                        cursorColor: kPrimaryColor,
                        //autofocus: true,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                          prefixIcon: const Icon(
                            Icons.person_outline_sharp,
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
                          labelText: "Full Name",
                          labelStyle: GoogleFonts.montserrat(
                              fontSize: 15,
                              color: kDividerColor,
                              fontWeight: FontWeight.w400),
                        ),
                        //validator: (val)=>(val.isEmpty)?'Enter Your Name':null,
                        onSaved: (val) {
                          name = val;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
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
                        controller: _controller,
                        maxLines: 1,
                        //keyboardType: TextInputType.datetime,
                        onChanged: (value) {
                          dob = value;
                          print(dob);
                        },
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: kTextColor,
                            fontWeight: FontWeight.w700),
                        cursorColor: kPrimaryColor,
                        //autofocus: true,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                          prefixIcon: const Icon(
                            Icons.calendar_today_outlined,
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
                          labelText: "Date of Birth(dd/mm/yyyy)",
                          labelStyle: GoogleFonts.montserrat(
                              fontSize: 15,
                              color: kDividerColor,
                              fontWeight: FontWeight.w400),
                        ),
                        //validator: (val)=>(val.isEmpty)?'Enter your Date of Birth':null,
                        onTap: () {
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950, 1),
                              lastDate: DateTime(2021, 12),
                              builder: (context, picker) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    colorScheme: const ColorScheme.dark(
                                      primary: kPrimaryColor,
                                      onPrimary: Colors.white,
                                      surface: Colors.pink,
                                      onSurface: kTextColor,
                                    ),
                                    //dialogBackgroundColor:Colors.green[900],
                                  ),
                                  child: picker!,
                                );
                              }).then((selectedDate) {
                            //TODO: handle selected date
                            if (selectedDate != null) {
                              print('the format is $selectedDate');

                              final DateFormat formatter =
                                  DateFormat('dd/MM/yyyy');
                              final String formatted =
                                  formatter.format(selectedDate);
                              print(formatted);
                              dob = formatted.toString();
                              _controller.text = formatted.toString();

                              //_controller.text = selectedDate.toString();

                            }
                          });
                        },
                        onSaved: (val) {
                          dob = val;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'By clicking "Register", you agree to ',
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: kTextColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const TermsAndConditions(),
                ],
              ),
              Center(
                child: Text(
                  error,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              Center(
                child: Text(
                  error1,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              LongButton(
                label: 'Register',
                givePadding: false,
                onTap: () async {
                  String datePattern = "dd/MM/yyyy";
                  print("asdasd $dob");
                  DateTime birthDate = DateFormat(datePattern).parse(dob!);
                  DateTime today = DateTime.now();

                  int age = today.year - birthDate.year;

                  print(age);
                  print(location);
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SetupInstructions(
                          phnum: widget.phNum,
                          name: name,
                          age: age,
                          location: location,
                        ),
                      ),
                    );
                  } else {
                    setState(() {
                      error1 = "Please fill the above details";
                    });
                  }
                },
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
