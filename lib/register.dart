import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nearlikes/choose_account.dart';
import 'package:nearlikes/link_account.dart';
import 'package:nearlikes/otp_verification.dart';
import 'theme.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';
import 'package:nearlikes/setup_instructions.dart';
import 'package:url_launcher/url_launcher.dart';

class Register extends StatefulWidget {
  var phNum;
  Register(this.phNum);


  @override
  _RegisterState createState() => _RegisterState();
}
Position position;
String error='';
String error1='';





class _RegisterState extends State<Register> {
  void getLocation()async{
    position= await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).catchError((e){
      setState(() {
        error=e.toString();
      });

      print(e.toString());});
    print(position);
   var address= await GeocodingPlatform.instance.placemarkFromCoordinates(position.latitude, position.longitude);
   print(address);
 print(address.first.locality);
 setState(() {
   location=address.first.locality;
 });

  }



  static final kInitialPosition = LatLng(15.9129,79.7400);
  PickResult selectedPlace;
  String name;
  String location;
  String dob;

  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  @override
  void initState() {
    getLocation();
    super.initState();
  }
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:40,vertical: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back,color: kPrimaryOrange,size: 30,)),
              SizedBox(height: 22,),
              GestureDetector(
                onTap: (){

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => PlacePicker(
                  //       desiredLocationAccuracy: LocationAccuracy.high,
                  //       apiKey: "AIzaSyCYgbMnw_D36TBv4gmyC8Lq0o-02MTEInU",   // Put YOUR OWN KEY here.
                  //       onPlacePicked: (result) {
                  //         print(result.formattedAddress);
                  //         location=result.formattedAddress;
                  //         print('the name is ${result.name}');
                  //         print(result.adrAddress);
                  //         //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNaviBar()));
                  //       },
                  //       initialPosition: kInitialPosition,
                  //       useCurrentLocation: true,
                  //     ),
                  //   ),
                  // );



                },
                child: Text("Register",style: GoogleFonts.montserrat(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: kFontColor,
                ),),
              ),
              SizedBox(height: 24,),
              Text("Enter your details to get started.",style: GoogleFonts.montserrat(
                fontSize:13,
                fontWeight: FontWeight.w400,
                color: kDarkGrey,
              ),),
              SizedBox(height: 5,),
              Image.asset('assets/login.png',width:301,height:301),
              SizedBox(height: 30,),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      height: 75.0,
                      decoration: new BoxDecoration(
                        //color: kLightGrey,
                          border: Border.all(color: kLightGrey),
                          borderRadius: new BorderRadius.circular(
                              15.0)),
                      child: TextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          name = value;
                        },
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: kDarkGrey,
                            fontWeight: FontWeight.w700),
                        cursorColor: kPrimaryOrange,
                        //autofocus: true,
                        decoration: InputDecoration(
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
                          labelText: "Full Name",
                          labelStyle: GoogleFonts.montserrat(
                              fontSize: 15,
                              color: kLightGrey,
                              fontWeight: FontWeight.w400),
                        ),
                        //validator: (val)=>(val.isEmpty)?'Enter Your Name':null,
                        onSaved: (val){
                          name=val;
                        },
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      height: 75.0,
                      decoration: new BoxDecoration(
                        //color: kLightGrey,
                          border: Border.all(color: kLightGrey),
                          borderRadius: new BorderRadius.circular(
                              15.0)),
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
                            color: kDarkGrey,
                            fontWeight: FontWeight.w700),
                        cursorColor: kPrimaryOrange,
                        //autofocus: true,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                          EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                          prefixIcon: Icon(
                            Icons.calendar_today_outlined,
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
                          labelText: "Date of Birth(dd/mm/yyyy)",
                          labelStyle: GoogleFonts.montserrat(
                              fontSize: 15,
                              color: kLightGrey,
                              fontWeight: FontWeight.w400),
                        ),
                        //validator: (val)=>(val.isEmpty)?'Enter your Date of Birth':null,
                        onTap: (){
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950, 1),
                              lastDate: DateTime(2021,12),
                              builder: (context,picker){
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    colorScheme: ColorScheme.dark(
                                      primary:kPrimaryOrange,
                                      onPrimary: Colors.white,
                                      surface: Colors.pink,
                                      onSurface: kDarkGrey,
                                    ),
                                    //dialogBackgroundColor:Colors.green[900],
                                  ),
                                  child: picker,);
                              })
                              .then((selectedDate) {
                            //TODO: handle selected date
                            if(selectedDate!=null){
                               print('the format is $selectedDate');

                              final DateFormat formatter = DateFormat('dd/MM/yyyy');
                              final String formatted = formatter.format(selectedDate);
                              print(formatted);
                              dob= formatted.toString();
                              _controller.text = formatted.toString();

                              //_controller.text = selectedDate.toString();



                            }
                          });
                        },
                        onSaved: (val){
                          dob=val;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15,),

              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("By clicking \"Register\", you agree to our ", style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: kDarkGrey,
                    ), textAlign: TextAlign.center,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                      ],),

                  ],
                ),
              ),
              //SizedBox(height: 20,),
              Center(child: Text(error,style: TextStyle(color: Colors.red),)),
              Center(child: Text(error1,style: TextStyle(color: Colors.red),)),
              //SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: InkWell(
                  onTap: ()async {

                    // await Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => PlacePicker(
                    //       desiredLocationAccuracy: LocationAccuracy.high,
                    //       apiKey: "AIzaSyCYgbMnw_D36TBv4gmyC8Lq0o-02MTEInU",   // Put YOUR OWN KEY here.
                    //       onPlacePicked: (result) {
                    //         print(result.formattedAddress);
                    //         location=result.formattedAddress;
                    //         print('the name is ${result.name}');
                    //         print(result.adrAddress);
                    //         Navigator.pop(context);
                    //   //      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LinkAccount(phnum:widget.phNum ,age:dob ,name: name,location:result.formattedAddress ,)));
                    //       },
                    //       initialPosition: kInitialPosition,
                    //       useCurrentLocation: true,
                    //     ),
                    //   ),
                    // );

                    String datePattern = "dd/MM/yyyy";
                    print("asdasd $dob");
                    DateTime birthDate = DateFormat(datePattern).parse(dob);
                    DateTime today = DateTime.now();

                    int age = today.year - birthDate.year;
                    // int monthDiff = today.month - birthDate.month;
                    // int dayDiff = today.day - birthDate.day;
                    print(age);
                    print(location);
                    if(_formKey.currentState.validate()){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SetupInstructions(phnum: widget.phNum,name: name,age:age,location: location,)));
                     //Navigator.push(context, MaterialPageRoute(builder: (context) => LinkAccount(phnum: widget.phNum, name: name,age:age,location: location,)));
                    }
                    else{setState(() {error1="Please fill the above details";});}
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
                        child: Text('Register',
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
