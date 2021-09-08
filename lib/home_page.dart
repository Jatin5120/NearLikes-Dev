import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nearlikes/Coupons.dart';
import 'package:nearlikes/brand_stories.dart';
import 'package:nearlikes/notifications.dart';
import 'package:nearlikes/profile_page.dart';
import 'package:nearlikes/scratch_cards.dart';
import 'package:nearlikes/select_brand.dart';
import 'theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'models/get_campaigns.dart';
import 'dart:convert';
import 'dart:async';
import 'package:nearlikes/models/get_customer.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'globals.dart' as globals;
import 'package:badges/badges.dart';

GetCampaigns _getCampaigns;
Customer _getCustomer;

String name='';
String customerId;
String phonenumber;
String CID;



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


Future<GetCampaigns> getAvailableCampaigns(
    {int followers, String location, int age}) async {
  print("data..");
  final String apiUrl = "https://nearlikes.com/v1/api/campaign/get/campaigns";
  var body = {"followers": followers, "location": "kolkata", "age": age};
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: json.encode(body),
  );

  print("data");
  print(response.statusCode);
  final String responseString = response.body.toString();

  print(responseString);
  _getCampaigns = getCampaignsFromJson(responseString);
  return _getCampaigns;
}

// void get()async{
//   await getCustomer();
// }

class _HomePageState extends State<HomePage> {
  int sum=0;

  Future<Customer> getCustomer(String customerId) async {
    print(".....");
    print(customerId);
    final String apiUrl = "https://nearlikes.com/v1/api/client/own/fetch";
    var body = {
      "id" : "$customerId"
    };
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
    print('----222-----');
    print(_getCustomer.customer.cashback);
    // for(int i=0;i<_getCustomer.customer.cashback.length;i++)
    // {
    //   print(_getCustomer.customer.cashback[i].amount);
    //   var a=int.parse(_getCustomer.customer.cashback[i].amount);
    //   assert(a is int);
    //
    //   sum=sum + a;
    // }

    for(int i=0;i<_getCustomer.customer.cashback.length;i++)
    {
      if(_getCustomer.customer.cashback[i].used==true){
        var a=int.parse(_getCustomer.customer.cashback[i].amount);
        assert(a is int);

        sum=sum + a;
      }

    }

    print(sum);
    print(";;;");
    print(_getCustomer.customer.name);
    setState(() {
      name=_getCustomer.customer.name;
      CID=_getCustomer.customer.id;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', _getCustomer.customer.token);
    return _getCustomer;
  }

  // Future<Customer> getCustomer(String customerId) async {
  //   print(".....");
  //   print(customerId);
  //   final String apiUrl = "https://nearlikes.com/v1/api/client/own/fetch";
  //   var body = {
  //     "id" : "$customerId"
  //   };
  //   final response = await http.post(
  //     Uri.parse(apiUrl),
  //     headers: {"Content-Type": "application/json"},
  //     body: json.encode(body),
  //   );
  //
  //   print(".....");
  //   print(response.body);
  //   final String responseString = response.body.toString();
  //
  //   print('-----------');
  //   _getCustomer = customerFromJson(responseString);
  //
  //   for(int i=0;i<_getCustomer.customer.cashback.length;i++)
  //   { if(_getCustomer.customer.cashback[i].used)
  //   {
  //     print(_getCustomer.customer.cashback[i].amount);
  //     var a = int.parse(_getCustomer.customer.cashback[i].amount);
  //     assert(a is int);
  //
  //     sum = sum + a;
  //   }
  //   }
  //   print(sum);
  //   print(";;;");
  //   print(_getCustomer.customer.name);
  //   setState(() {
  //     name=_getCustomer.customer.name;
  //   });
  //   return _getCustomer;
  // }


  getCustomerId(String phonenumber)async{
    var body = {
      "phone" : "+91$phonenumber"
    };

    final response = await http.post(
      Uri.parse('https://nearlikes.com/v1/api/client/getid'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );
    var test=jsonDecode(response.body);
    print('the response is ${test}');
    getCustomer(test);
    addPlayer(test);
  }
  String user_acc_id;
  getUserData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    customerId= prefs.getString('customer_id');
    phonenumber=prefs.getString('phonenumber');
    print('the phone number is $phonenumber');
    print('user acc id is $customerId');
    if(customerId==null){
      print('test');
      getCustomerId(phonenumber);
    }
    else {getCustomer(customerId);
    addPlayer(customerId);}
  }

  Future<void> initPlatformState() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
   bool checkUser = prefs.getBool('checkuser');
    OneSignal.shared.setNotificationOpenedHandler((openedResult) async {
      var data= openedResult.notification.additionalData;
      var id= openedResult.notification.notificationId;

      print('the additional data ${data.toString()}');
      print('the notification id ${id.toString()}');

      var postId=await data['post_id'];
      print('the post id is $postId');
      if(checkUser==true){
      if(postId=='coupon'){globals.appNaviagtor.currentState.push(MaterialPageRoute(builder: (context)=>Coupons(cID: CID,)));}
      else if(postId=='campaign'){globals.appNaviagtor.currentState.push(MaterialPageRoute(builder: (context)=>SelectBrand(value: true,)));}
      else if(postId=='cashback'){globals.appNaviagtor.currentState.push(MaterialPageRoute(builder: (context)=>ScratchCards(cID: CID,)));}
      //else  globals.appNaviagtor.currentState.push(MaterialPageRoute(builder: (context)=>HomePage()));
        }
    });
  }


  @override
  void initState() {
    initPlatformState();
    //get();
    getUserData();
    super.initState();
  }

  addPlayer(String customerId)async{
    print('inside the getPlayerId');
    final status = await OneSignal.shared.getDeviceState();
    final String osUserID = status.userId;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('playerId', osUserID).then((value) =>
        print('job done $value'));
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    // var PlayerId= prefs.getString('playerId');
    print('the player id inside is $osUserID');
    print('the customer id inside is $customerId');
    var url = 'https://nearlikes.com/v1/api/client/add/player';
    var body=
    {
      "id": "$customerId",
      "push":"$osUserID",
    };
    var response= await  http.post(Uri.parse(url),
        headers:{"Content-Type": "application/json"},
        body: json.encode(body));
    print(response.body);
    print(response.statusCode);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 65, left: 34, right: 34),
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Welcome,',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: kFontColor,
                        )),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage(cID:CID)));
                      },
                      child: Badge(
                        toAnimate: true,
                        animationType: BadgeAnimationType.scale,
                        badgeContent: Text('*',style: GoogleFonts.montserrat(
                          //badgeContent: Text('13',style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        )),
                        child: Icon(Icons.notifications_active,color: Colors.black,size: 25,),
                      ),
                    ),

                  ],
                ),

                // GestureDetector(
                //   onTap: () async {
                //     _getCampaigns = await getAvailableCampaigns(
                //         followers: 500, location: "hyderabad", age: 40);
                //     print(_getCampaigns.campaigns[1].age);
                //   },
                //  Text(_getCustomer.customer.name,
                Text(name,
                    style: GoogleFonts.montserrat(
                      fontSize: 29,
                      fontWeight: FontWeight.w700,
                      color: kBlack,
                    )),
                Container(
                  height: 200,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 60,
                        left: MediaQuery.of(context).size.width * 0.178,
                        child: Container(
                          height: 117,
                          width: 186,
                          decoration: BoxDecoration(
                              color: Color(0xfff2f2f2),
                              borderRadius:
                              BorderRadius.all(Radius.circular(8))),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 45,
                              ),
                              Text('TOTAL REWARDS',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xffB9B9B9),
                                  )),
                              SizedBox(
                                height: 8,
                              ),
                              // Text("Rs. "+_getCustomer.customer.cashback[0].amount,
                              Text("Rs. $sum",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: kBlack,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: MediaQuery.of(context).size.width * 0.325,
                        child: Container(
                          height: 72,
                          width: 72,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(4,8,),
                                blurRadius: 20.0,
                                spreadRadius: 0,
                              ), //BoxShadow//BoxShadow
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Image.asset('assets/logo.png',
                                width: 32.48, height: 42.28),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 60, vertical: 0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SelectBrand(value: true,)));
                    },
                    child: Container(
                      height: 35,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              kPrimaryPink,
                              kPrimaryOrange,
                            ],
                          )),
                      child: Center(
                        child: Text('Post a story',
                            style: GoogleFonts.montserrat(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text('Brand Reward',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                FutureBuilder(
                    future: getAvailableCampaigns(
                        followers: 500, location: "kolkata", age: 40),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        print(snapshot.data);
                        return Center(child: CircularProgressIndicator());
                      }
                      print(snapshot.data);
                      return Container(
                          //height:(MediaQuery.of(context).size.height / 4)*_getCampaigns.campaigns.length.toDouble(),
                          child:  GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio:  3/4,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                              ),
                              itemCount: _getCampaigns.campaigns.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return GestureDetector(
                                  // onTap: () {
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) => BrandStories(brand:_getCampaigns.campaigns[index].brand,id:_getCampaigns.campaigns[index].ownerId,campaign_id:_getCampaigns.campaigns[index].id ,)));
                                  // },
                                  //child: Image.asset('assets/brands.png'));
                                    child: ShaderMask(
                                      shaderCallback: (bounds){
                                        return LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [Colors.transparent,Colors.black]
                                        ).createShader(bounds);
                                      },
                                      blendMode: BlendMode.color,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                // image: AssetImage('assets/scratch_card.png'),
                                                  image: NetworkImage(
                                                      '${_getCampaigns.campaigns[index].logo}'
                                                  ),
                                                  fit: BoxFit.cover
                                              ),
                                              color: Color(0xffaaaaaa),
                                              borderRadius:
                                              BorderRadius.all(Radius.circular(5))),
                                          child: Stack(
                                            children: [
                                              Container(
                                                decoration:BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.white.withOpacity(0.0),
                                                        Colors.black.withOpacity(0.9)
                                                      ],
                                                      begin: Alignment.topCenter,
                                                      end: Alignment.bottomCenter,
                                                    )
                                                ),
                                              ),
                                              Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(top:8.0,bottom: 15),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        "${_getCampaigns.campaigns[index].brand}",
                                                        style: GoogleFonts.montserrat(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.white
                                                        ),),
                                                      SizedBox(height: 8,),
                                                      // Text(
                                                      //   "${_getCampaigns.campaigns[index].text}",
                                                      //   style: GoogleFonts.montserrat(
                                                      //     fontSize: 14,
                                                      //     fontWeight: FontWeight.w400,
                                                      //     color: Colors.white,
                                                      //   ),),
                                                      // Text(
                                                      //   "${readTimestamp(_getCampaigns.campaigns[index].start)}",style: GoogleFonts.montserrat(
                                                      //     fontSize: 11,
                                                      //     fontWeight: FontWeight.w500,
                                                      //     color:Colors.white
                                                      // ),),
                                                      // Text(
                                                      //   "to ${readTimestamp(_getCampaigns.campaigns[index].end)}",style: GoogleFonts.montserrat(
                                                      //     fontSize: 11,
                                                      //     fontWeight: FontWeight.w500,
                                                      //     color: Colors.white
                                                      // ),),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                            ],
                                          )),
                                    ));
                              }));

                      //return Container();
                    }),
                // Container(
                //   height: 350,
                //   child:FutureBuilder(
                //       future: getAvailableCampaigns(
                //           followers: 500, location: "kolkata", age: 40),
                //       builder: (context, AsyncSnapshot snapshot) {
                //         if (!snapshot.hasData) {
                //           print(snapshot.data);
                //           return Center(child: CircularProgressIndicator());
                //         }
                //         print(snapshot.data);
                //         return Container(
                //             child:  GridView.builder(
                //                 gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                //                     maxCrossAxisExtent: 200,
                //                     childAspectRatio: 3/ 4,
                //                     crossAxisSpacing: 20,
                //                     mainAxisSpacing: 20),
                //                 itemCount: _getCampaigns.campaigns.length,
                //                 itemBuilder: (BuildContext ctx, index) {
                //                   return GestureDetector(
                //                     // onTap: () {
                //                     //   Navigator.push(
                //                     //       context,
                //                     //       MaterialPageRoute(
                //                     //           builder: (context) => BrandStories(brand:_getCampaigns.campaigns[index].brand,id:_getCampaigns.campaigns[index].ownerId,campaign_id:_getCampaigns.campaigns[index].id ,)));
                //                     // },
                //                     //child: Image.asset('assets/brands.png'));
                //                       child: ShaderMask(
                //                         shaderCallback: (bounds){
                //                           return LinearGradient(
                //                               begin: Alignment.topCenter,
                //                               end: Alignment.bottomCenter,
                //                               colors: [Colors.transparent,Colors.black]
                //                           ).createShader(bounds);
                //                         },
                //                         blendMode: BlendMode.color,
                //                         child: Container(
                //                             decoration: BoxDecoration(
                //                                 image: DecorationImage(
                //                                   // image: AssetImage('assets/scratch_card.png'),
                //                                     image: NetworkImage(
                //                                         '${_getCampaigns.campaigns[index].logo}'
                //                                     ),
                //                                     fit: BoxFit.cover
                //                                 ),
                //                                 color: Color(0xffaaaaaa),
                //                                 borderRadius:
                //                                 BorderRadius.all(Radius.circular(5))),
                //                             child: Stack(
                //                               children: [
                //                                 Container(
                //                                   decoration:BoxDecoration(
                //                                       gradient: LinearGradient(
                //                                         colors: [
                //                                           Colors.white.withOpacity(0.0),
                //                                           Colors.black.withOpacity(0.9)
                //                                         ],
                //                                         begin: Alignment.topCenter,
                //                                         end: Alignment.bottomCenter,
                //                                       )
                //                                   ),
                //                                 ),
                //                                 Center(
                //                                   child: Padding(
                //                                     padding: const EdgeInsets.only(top:8.0,bottom: 15),
                //                                     child: Column(
                //                                       mainAxisAlignment: MainAxisAlignment.end,
                //                                       children: [
                //                                         Text(
                //                                           "${_getCampaigns.campaigns[index].brand}",
                //                                           style: GoogleFonts.montserrat(
                //                                               fontSize: 16,
                //                                               fontWeight: FontWeight.w500,
                //                                               color: Colors.white
                //                                           ),),
                //                                         SizedBox(height: 8,),
                //                                         // Text(
                //                                         //   "${_getCampaigns.campaigns[index].text}",
                //                                         //   style: GoogleFonts.montserrat(
                //                                         //     fontSize: 14,
                //                                         //     fontWeight: FontWeight.w400,
                //                                         //     color: Colors.white,
                //                                         //   ),),
                //                                         // Text(
                //                                         //   "${readTimestamp(_getCampaigns.campaigns[index].start)}",style: GoogleFonts.montserrat(
                //                                         //     fontSize: 11,
                //                                         //     fontWeight: FontWeight.w500,
                //                                         //     color:Colors.white
                //                                         // ),),
                //                                         // Text(
                //                                         //   "to ${readTimestamp(_getCampaigns.campaigns[index].end)}",style: GoogleFonts.montserrat(
                //                                         //     fontSize: 11,
                //                                         //     fontWeight: FontWeight.w500,
                //                                         //     color: Colors.white
                //                                         // ),),
                //                                       ],
                //                                     ),
                //                                   ),
                //                                 ),
                //
                //                               ],
                //                             )),
                //                       ));
                //                 }));
                //
                //         //return Container();
                //       }),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String readTimestamp(int timestamp) {
  var now = new DateTime.now();
  var format = new DateFormat('d MMM h:mm a');
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var diff = format.format(date);
  return diff;
}