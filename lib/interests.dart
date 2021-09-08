import 'package:flutter/material.dart';
import 'package:nearlikes/SuccessSample.dart';
import 'package:nearlikes/home_page.dart';
import 'package:nearlikes/page_guide.dart';
import 'package:nearlikes/theme.dart';
import 'package:confetti/confetti.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratcher/widgets.dart';
import 'dart:convert';
import 'package:grouped_checkbox/grouped_checkbox.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChooseInterests extends StatefulWidget {
  final ig_details,phnum,name,ig_userId,age,location,phoneNumber;
  ChooseInterests({this.age,this.location,this.ig_details,this.phnum,this.name,this.ig_userId,this.phoneNumber});
  @override
  _ChooseInterestsState createState() => _ChooseInterestsState();
}
List<String> foodDrink = [
 "North Indian",
 "South Indian",
 "Chinese",
 "Arabian",
 "Thali",
 "Afghan",
 "Sea Food",
"Snacks and Chats",
"Bakery and Confencerys",
 "Sweets",
];
List<String> entertainment = [
  "Movies and Tv",
  "Theatres and Shows",
  "Concert and Events",
  "Malls",
  "Experiences",
];
List<String> fashionBeauty = [
  "Cloths",
  "Shoes",
  "Make- Up",
  "Accessories",
  "Beauty Products",
  "Spa and Salons",
];
List<String> health = [
  'Exercise Equipments',
 'Exercise Classes',
 'Supplements',
  'Nutrition',
  'Mindfulness and Meditation',
  'Working Out',
];
List<String> hobbies = [
  'Arts and Craft',
  'Cooking',
  'Dancing',
  'Gardening',
  'Music and Musical Instruments',
  'Sports',
  'Travels',
];
List<String> electronics = [
  'Mobile Phones',
  'Accessories',
  'Computers and Laptops',
];
List<String> automobile = [
  'Cars and Motorbikes',
  'Buses and Trucks',
  'E.V. Vehicles',
];

List<String> checkedItemList;
List<String> selectedItemList;
List<String> selectedItemList1;
List<String> selectedItemList2;
List<String> selectedItemList3;
List<String> selectedItemList4;
List<String> selectedItemList5;
List<String> selectedItemList6;

class _ChooseInterestsState extends State<ChooseInterests> {
  var customer_id;


  // uploadUserData(tag)async{
  //   String accesstoken='EAAG9VBauCocBALeqX0Owqm8ZCibZAb2UKe0vTL0VjRvCt7aNbLgab6kGh6AtLinwiWnz33d2A14CUX8ZB2G2BoGLMjQsr3hShBSN0FZBG6H1sQZCPumi2ZBR5R9hX6jVX2ZAl5mraAeZBCTy9a89nEyP9yUpkS4hALD5oYQakkugDTxZBobgH858ZC';
  //   var url = 'https://nearlikes.com/v1/api/client/add';
  //   var body={
  //     "name": "${widget.name}",
  //     "age": widget.age,
  //     "insta": "${widget.ig_userId}",
  //     "followers": 500,
  //     "location": "${widget.location}",
  //     "phone": "+91${widget.phnum}", // should contain +91,
  //     "token": "$accesstoken", //insta access token
  //     "tag": tag
  //   };
  //   var response= await  http.post(Uri.parse(url),
  //       headers:{"Content-Type": "application/json"},
  //       body: json.encode(body));
  //   print(response.statusCode);
  //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('user_acc_id', response.body);
  //   print('the body is ${response.body}');
  //   var decoded= json.decode(response.body);
  //   print(response.body);
  //    customer_id= decoded['customer_id'] ;
  //    print('the id is ${customer_id}');
  //   return response.statusCode;
  // }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
        return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Cannot go back at this stage!'),
            content: Text('Select at least one from each category to continue.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('OK'),
              ),
              // TextButton(
              //   onPressed: () => Navigator.of(context).pop(true),
              //   child: new Text('Yes'),
              // ),
            ],
          ),
        )) ?? false;
      },
      child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:40,vertical: 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: GestureDetector(
              //       onTap: (){
              //         Navigator.pop(context);
              //       },
              //       child: Icon(Icons.arrow_back,color: kPrimaryOrange,size: 30,)),
              // ),


              //SizedBox(height: 10,),
              Center(child: Image.asset('assets/logo.png',width:45,height:45)),
              SizedBox(height: 25,),
              Center(
                child: Text("Tell us your interests",style: GoogleFonts.montserrat(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: kFontColor,
                ),textAlign: TextAlign.center,),
              ),
              SizedBox(height: 20,),
              Center(
                child: Text("Add your interests so we can begin to personalize your suggestions.",style: GoogleFonts.montserrat(
                  fontSize:13,
                  fontWeight: FontWeight.w400,
                  color: kDarkGrey,
                ),textAlign: TextAlign.center,),
              ),
              SizedBox(height: 15,),
              Center(
                child: Text("Please select atleast one from each category",style: GoogleFonts.montserrat(
                  fontSize:13,
                  fontWeight: FontWeight.w500,
                  color: kPrimaryOrange,
                ),textAlign: TextAlign.center,),
              ),

              SizedBox(height: 30,),
              Text("  FOOD AND DRINKS",style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: kFontColor,
              ),textAlign: TextAlign.center,),
              SizedBox(height: 10,),
              GroupedCheckbox(
                  itemList: foodDrink,
                  checkedItemList: checkedItemList,
                  onChanged: (itemList) {
                    setState(() {
                      selectedItemList = itemList;
                      print('SELECTED ITEM LIST $itemList');
                    });
                  },
                  orientation: CheckboxOrientation.VERTICAL,
                  checkColor: Colors.white,
                  activeColor: kPrimaryPink
              ),
              SizedBox(height: 30,),
              Text("  ENTERTAINMENT",style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: kFontColor,
              ),textAlign: TextAlign.center,),
              SizedBox(height: 10,),
              GroupedCheckbox(
                  itemList: entertainment,
                  checkedItemList: checkedItemList,
                  onChanged: (itemList) {
                    setState(() {
                      selectedItemList1 = itemList;
                      print('SELECTED ITEM LIST $itemList');
                    });
                  },
                  orientation: CheckboxOrientation.VERTICAL,
                  checkColor: Colors.white,
                  activeColor: kPrimaryPink
              ),
              SizedBox(height: 30,),
              Text("  FASHION AND BEAUTY",style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: kFontColor,
              ),textAlign: TextAlign.center,),
              SizedBox(height: 10,),
              GroupedCheckbox(
                  itemList: fashionBeauty,
                  checkedItemList: checkedItemList,
                  onChanged: (itemList) {
                    setState(() {
                      selectedItemList2 = itemList;
                      print('SELECTED ITEM LIST $itemList');
                    });
                  },
                  orientation: CheckboxOrientation.VERTICAL,
                  checkColor: Colors.white,
                  activeColor: kPrimaryPink
              ),
              SizedBox(height: 30,),
              Text("  HEALTH AND WELL-BEING",style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: kFontColor,
              ),textAlign: TextAlign.center,),
              SizedBox(height: 10,),
              GroupedCheckbox(
                  itemList:health,
                  checkedItemList: checkedItemList,
                  onChanged: (itemList) {
                    setState(() {
                      selectedItemList3 = itemList;
                      print('SELECTED ITEM LIST $itemList');
                    });
                  },
                  orientation: CheckboxOrientation.VERTICAL,
                  checkColor: Colors.white,
                  activeColor: kPrimaryPink
              ),
              SizedBox(height: 30,),
              Text("  HOBBIES AND ACTIVITIES",style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: kFontColor,
              ),textAlign: TextAlign.center,),
              SizedBox(height: 10,),
              GroupedCheckbox(
                  itemList: hobbies,
                  checkedItemList: checkedItemList,
                  onChanged: (itemList) {
                    setState(() {
                      selectedItemList4 = itemList;
                      print('SELECTED ITEM LIST $itemList');
                    });
                  },
                  orientation: CheckboxOrientation.VERTICAL,
                  checkColor: Colors.white,
                  activeColor: kPrimaryPink
              ),
              SizedBox(height: 30,),
              Text("  ELECTRONICS",style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: kFontColor,
              ),textAlign: TextAlign.center,),
              SizedBox(height: 10,),
              GroupedCheckbox(
                  itemList: electronics,
                  checkedItemList: checkedItemList,
                  onChanged: (itemList) {
                    setState(() {
                      selectedItemList5 = itemList;
                      print('SELECTED ITEM LIST $itemList');
                    });
                  },
                  orientation: CheckboxOrientation.VERTICAL,
                  checkColor: Colors.white,
                  activeColor: kPrimaryPink
              ),
              SizedBox(height: 30,),
              Text("  AUTOMOBILE",style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: kFontColor,
              ),textAlign: TextAlign.center,),
              SizedBox(height: 10,),
              GroupedCheckbox(
                  itemList: automobile,
                  checkedItemList: checkedItemList,
                  onChanged: (itemList) {
                    setState(() {
                      selectedItemList6 = itemList;
                      print('SELECTED ITEM LIST $itemList');
                    });
                  },
                  orientation: CheckboxOrientation.VERTICAL,
                  checkColor: Colors.white,
                  activeColor: kPrimaryPink
              ),
              SizedBox(height: 20,),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: InkWell(
                  onTap: ()async{
                    print('1');
                    if((selectedItemList==null)||(selectedItemList1==null)||(selectedItemList2==null)||(selectedItemList3==null)||(selectedItemList4==null)||(selectedItemList5==null)||(selectedItemList6==null))
                    {
                     return showDialog(
                       context: context,
                       builder: (context) => new AlertDialog(
                         title: new Text('Select at least one category '),
                         content: Text('Please do select one sub category from each category to continue'),
                         actions: <Widget>[
                           TextButton(
                             onPressed: () => Navigator.of(context).pop(false),
                             child: new Text('OK'),
                           ),
                           // TextButton(
                           //   onPressed: () => Navigator.of(context).pop(true),
                           //   child: new Text('Yes'),
                           // ),
                         ],
                       ),
                     );
                    }
                    else{
                      var interestList = selectedItemList + selectedItemList1 + selectedItemList2+selectedItemList3+selectedItemList4+selectedItemList5+selectedItemList6;

                      print('the interest list is !|!');
                      print(interestList);

                      // var response = await uploadUserData(interestList);
                      //print(response);
                      //Navigator.pop(context,interestList);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SuccessSample(phoneNumber: widget.phoneNumber,
                          interests: interestList
                      )));
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
                        child:  Text('Next',
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
    ),);
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