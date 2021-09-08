import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nearlikes/otp_verification.dart';
import 'package:nearlikes/page_guide.dart';
import 'package:nearlikes/register.dart';
import 'theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'show json;
import 'package:shared_preferences/shared_preferences.dart';


class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  Uri backgroundAssetUri = Uri.parse("https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/2022-chevrolet-corvette-z06-1607016574.jpg?crop=0.737xw:0.738xh;0.181xw,0.218xh&resize=980:*");
  final TextEditingController _phoneNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  var phNum;
  String error='';
  bool loading= false;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:40,vertical: 90),
          child: Stack(
            children: [

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back,color: kPrimaryOrange,size: 30,)),
                  SizedBox(height: 22,),
                  Text("Login",style: GoogleFonts.montserrat(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: kFontColor,
                  ),),
                  SizedBox(height: 24,),
                  Text("Enter your phone number to get started.",style: GoogleFonts.montserrat(
                    fontSize:13,
                    fontWeight: FontWeight.w400,
                    color: kDarkGrey,
                  ),),
                  SizedBox(height: 22,),
                  Image.asset('assets/login.png',width:301,height:301),
                  SizedBox(height: 40,),

                  Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    height: 75.0,
                    decoration: new BoxDecoration(
                      //color: kLightGrey,
                        border: Border.all(color: kLightGrey),
                        borderRadius: new BorderRadius.circular(
                            15.0)),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _phoneNumberController,
                        maxLines: 1,
                        keyboardType: TextInputType.phone,
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: kDarkGrey,
                            fontWeight: FontWeight.w700),
                        cursorColor: kPrimaryOrange,
                        //autofocus: true,
                        decoration: InputDecoration(
                          prefixText: '+91 ',
                          prefixStyle: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: kDarkGrey,
                              fontWeight: FontWeight.w700),
                          isDense: true,
                          contentPadding:
                          EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                          prefixIcon: Icon(
                            Icons.phone_android,
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
                          labelText: "Phone Number",
                          labelStyle: GoogleFonts.montserrat(
                              fontSize: 15,
                              color: kLightGrey,
                              fontWeight: FontWeight.w400),
                        ),
                        validator: (val)=>(val.isEmpty)||(val.length<10)||(val.length>10)?'Enter Proper Phone Number':null,
                        onChanged: (val){
                          phNum=val;
                        },
                        onSaved: (val){
                          phNum=val;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Center(child: Text(error,style: TextStyle(fontSize: 15.5,fontWeight: FontWeight.bold,color: Colors.black87),)),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: InkWell(
                      onTap: ()async{
                        // SharedPreferences prefs = await SharedPreferences.getInstance();
                        // prefs.clear().then((value) => {print('shared preferences cleared!!!! $value')});

                        if(_formKey.currentState.validate())
                        {setState(() {loading=true;});
                        print('in');
                        var rand= (Random().nextInt(900000)+100000).toString();
                        print(rand);
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => OTPVerification(phNum)));
                        var response =  await http.get(Uri.parse('http://api.msg91.com/api/sendotp.php?authkey=363206AVR1coo96wc60d47698P1&mobile=91$phNum&message=Your%20otp%20is%20$rand&sender=smsind&otp=$rand'));
                        var decoded= json.decode(response.body);
                        print(response.body);
                        var type= decoded['type'];
                        //  if(phNum=='8888888888'){
                        //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Register(phNum)));
                        // }
                        if(type=='success'){
                          setState(() {loading=false;});
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OTPVerification(phNum)));
                        }
                        else setState(() {
                          error='Something went wrong, Try again!!';
                          loading=false;
                        });

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
                            child: Text('Continue',
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
          ),
        ),
      ),
    );
  }
}
