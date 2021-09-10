// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:scratcher/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:nearlikes/constants/constants.dart';

import '../models/get_customer.dart';
import '../redeem_coupon.dart';
import 'widgets/widgets.dart';

Customer? _getCustomer;
String? customerId;
String? phonenumber;

class Coupons extends StatefulWidget {
  final cID;
  const Coupons({Key? key, this.cID}) : super(key: key);

  @override
  _CouponsState createState() => _CouponsState();
}

Future<Customer?> getCustomerID({phone}) async {
  print(".....");
  const String apiUrl = "https://nearlikes.com/v1/api/client/own/fetch";
  var body = {"id": "$phone"};
  // var body = {
  //   "id" : "610d8bc622eefa4db0aeed0b"
  // };
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: json.encode(body),
  );

  print(".....");
  print(response.statusCode);
  final String responseString = response.body.toString();

  print(responseString);
  _getCustomer = customerFromJson(responseString);

  return _getCustomer;
}

// Future<Customer> couponScratched(String couponId) async {
Future<void> couponScratched(String? couponId) async {
  print(".....");
  const String apiUrl = "https://nearlikes.com/v1/api/client/coupon/scratch";
  var body = {"id": "$couponId"};
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: json.encode(body),
  );

  print(".....");
  print(response.statusCode);
  final String responseString = response.body.toString();

  print(responseString);

  // _getCustomer = customerFromJson(responseString);
  // print(";;;");
  // print(_getCustomer.customer.name);
  // return _getCustomer;
}

class _CouponsState extends State<Coupons> {
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

  Future<Customer?> getCustomer(String? customerId) async {
    print(".....");
    const String apiUrl = "https://nearlikes.com/v1/api/client/own/fetch";
    // var body = {
    //   "id" : "610d8bc622eefa4db0aeed0b"
    // };
    var body = {"id": "$customerId"};
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );

    print(".....");
    print(response.statusCode);
    final String responseString = response.body.toString();

    print(responseString);
    _getCustomer = customerFromJson(responseString);

    print(";;;");
    //print(sum);
    print(_getCustomer!.customer!.name);

    // setState(() {
    //   name=_getCustomer.customer.name;
    // });
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
    getCustomer(test);
  }

  late ConfettiController _controllerTopCenter;
  List? mySelTeams;
  String animationName = "celebrationstart";

  void _playAnimation() {
    setState(() {
      if (animationName == "celebrationstart") {
        animationName = "celebrationstop";
      } else {
        animationName = "celebrationstart";
      }
    });
  }

  @override
  void initState() {
    print("customer id is --->${widget.cID}");
    getUserData();
    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerTopCenter.play();
    _playAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyBackButton(),
              Logo.small(),
              const SizedBox(
                height: 35,
              ),
              Center(
                child: Text(
                  "MY COUPONS",
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: kTextColor[300],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                  future: getCustomerID(phone: "${widget.cID}"),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      print(snapshot.data);
                      return const Center(child: CircularProgressIndicator());
                    }
                    return _getCustomer!.customer!.coupons!.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.only(top: 180),
                            child: Text(
                              'Post a story to get coupon',
                              style: TextStyle(color: Colors.red, fontSize: 15),
                            ))
                        : GridView.builder(
                            reverse: true,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 3 / 2,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 20),
                            itemCount: _getCustomer!.customer!.coupons!.length,
                            itemBuilder: (BuildContext ctx, index) {
                              if (_getCustomer!
                                  .customer!.coupons![index].used!) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => RedeemCoupon(
                                                code: _getCustomer!.customer!
                                                    .coupons![index].code,
                                                brand: _getCustomer!.customer!
                                                    .coupons![index].brand,
                                                link: _getCustomer!.customer!
                                                    .coupons![index].link,
                                                discount: _getCustomer!
                                                    .customer!
                                                    .coupons![index]
                                                    .discount,
                                                expiry: _getCustomer!.customer!
                                                    .coupons![index].expiry)));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, left: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                        border: Border.all(
                                          color: kDividerColor,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          Image.asset(
                                            "assets/trophy.png",
                                            width: 30,
                                            height: 30,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          const Text(
                                            "You've won",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            _getCustomer!.customer!
                                                .coupons![index].code!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: kPrimaryColor),
                                          ),
                                          Text(
                                            _getCustomer!.customer!
                                                .coupons![index].brand!,
                                            // ignore: prefer_const_constructors
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                                color: kTextColor[300]),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                      //child: Center(child: Text("Rs. "+_getCustomer.customer.cashback[index].amount,)),
                                    ),
                                  ),
                                );
                              } else {
                                return GestureDetector(
                                    onTap: () async {
                                      await goToDialog(
                                          _getCustomer!
                                              .customer!.coupons![index].code,
                                          _getCustomer!
                                              .customer!.coupons![index].brand,
                                          _getCustomer!
                                              .customer!.coupons![index].id);
                                      print("tapped");

                                      // setState(() {
                                      //   couponScratched(_getCustomer.customer.coupons[index].id);
                                      // });
                                      await couponScratched(_getCustomer!
                                          .customer!.coupons![index].id);
                                      setState(() {
                                        print("tapped");
                                      });

                                      //Navigator.push(context, MaterialPageRoute(builder: (context) => BrandStories()));
                                    },
                                    child:
                                        Image.asset('assets/scratch_card.png'));
                              }
                            });
                  }),
              // Container(
              //   height: 500,
              //   child:
              // ),

              // GridView.builder(
              //     physics: NeverScrollableScrollPhysics(),
              //     shrinkWrap: true,
              //     gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              //         maxCrossAxisExtent: 200,
              //         childAspectRatio: 3 / 2,
              //         crossAxisSpacing: 0,
              //         mainAxisSpacing: 20),
              //     itemCount: _getCustomer.customer.coupons.length,
              //     itemBuilder: (BuildContext ctx, index) {
              //       if(_getCustomer.customer.coupons[index].used)
              //       {
              //         return GestureDetector(
              //           onTap: (){
              //             Navigator.push(context, MaterialPageRoute(builder: (context) =>RedeemCoupon(code:_getCustomer.customer.coupons[index].code,brand: _getCustomer.customer.coupons[index].brand,link: _getCustomer.customer.coupons[index].link,discount: _getCustomer.customer.coupons[index].discount,expiry:_getCustomer.customer.coupons[index].expiry)));
              //           },
              //           child: Padding(
              //             padding: const EdgeInsets.only(right: 8,left: 8),
              //             child: Container(
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.all(Radius.circular(5)),
              //                 border: Border.all(color: kTextColor[300].withOpacity(0.2)),
              //               ),
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: <Widget>[
              //                   SizedBox(height: 7,),
              //                   Image.asset(
              //                     "assets/trophy.png",width: 30,height: 30,),
              //                   SizedBox(height: 8,),
              //                   Text(
              //                     "You've won",
              //                     style: TextStyle(
              //                         fontWeight: FontWeight.bold,
              //                         fontSize: 12,
              //                         color: Colors.black),
              //                   ),
              //                   SizedBox(height: 2,),
              //                   Text(
              //                     _getCustomer.customer.coupons[index].code,
              //                     style: TextStyle(
              //                         fontWeight: FontWeight.bold,
              //                         fontSize: 15,
              //                         color: kPrimaryColor),
              //                   ),
              //                   Text(
              //                     _getCustomer.customer.coupons[index].brand,
              //                     style: TextStyle(
              //                         fontWeight: FontWeight.bold,
              //                         fontSize: 13,
              //                         color: kTextColor[300]),
              //                   ),
              //                   SizedBox(height: 5,),
              //
              //                 ],
              //               ),
              //               //child: Center(child: Text("Rs. "+_getCustomer.customer.cashback[index].amount,)),
              //             ),
              //           ),
              //         );
              //       }
              //       else
              //         return GestureDetector(
              //             onTap: () async{
              //               await goToDialog(_getCustomer.customer.coupons[index].code,_getCustomer.customer.coupons[index].brand);
              //               print("tapped");
              //               print(_getCustomer.customer.coupons[index].id);
              //               setState(() async{
              //                 await couponScratched(_getCustomer.customer.coupons[index].id);
              //               });
              //               // await couponScratched(_getCustomer.customer.coupons[index].id);
              //               // setState(() {
              //               //   print("tapped");
              //               // });
              //
              //               //Navigator.push(context, MaterialPageRoute(builder: (context) => BrandStories()));
              //             },
              //             child: Image.asset('assets/scratch_card.png'));
              //     }),
              // Container(
              //   height: 500,
              //   child: GridView.builder(
              //       physics: NeverScrollableScrollPhysics(),
              //       shrinkWrap: true,
              //       gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              //           maxCrossAxisExtent: 200,
              //           childAspectRatio: 3 / 2,
              //           crossAxisSpacing: 0,
              //           mainAxisSpacing: 20),
              //       itemCount: _getCustomer.customer.coupons.length,
              //       itemBuilder: (BuildContext ctx, index) {
              //         if(_getCustomer.customer.coupons[index].used)
              //         {
              //           return GestureDetector(
              //             onTap: (){
              //               Navigator.push(context, MaterialPageRoute(builder: (context) =>RedeemCoupon(code:_getCustomer.customer.coupons[index].code,brand: _getCustomer.customer.coupons[index].brand,link: _getCustomer.customer.coupons[index].link,discount: _getCustomer.customer.coupons[index].discount,expiry:_getCustomer.customer.coupons[index].expiry)));
              //             },
              //             child: Padding(
              //               padding: const EdgeInsets.only(right: 8,left: 8),
              //               child: Container(
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.all(Radius.circular(5)),
              //                   border: Border.all(color: kTextColor[300].withOpacity(0.2)),
              //                 ),
              //                 child: Column(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   children: <Widget>[
              //                     SizedBox(height: 7,),
              //                     Image.asset(
              //                       "assets/trophy.png",width: 30,height: 30,),
              //                     SizedBox(height: 8,),
              //                     Text(
              //                       "You've won",
              //                       style: TextStyle(
              //                           fontWeight: FontWeight.bold,
              //                           fontSize: 12,
              //                           color: Colors.black),
              //                     ),
              //                     SizedBox(height: 2,),
              //                     Text(
              //                       _getCustomer.customer.coupons[index].code,
              //                       style: TextStyle(
              //                           fontWeight: FontWeight.bold,
              //                           fontSize: 15,
              //                           color: kPrimaryColor),
              //                     ),
              //                     Text(
              //                       _getCustomer.customer.coupons[index].brand,
              //                       style: TextStyle(
              //                           fontWeight: FontWeight.bold,
              //                           fontSize: 13,
              //                           color: kTextColor[300]),
              //                     ),
              //                     SizedBox(height: 5,),
              //
              //                   ],
              //                 ),
              //                 //child: Center(child: Text("Rs. "+_getCustomer.customer.cashback[index].amount,)),
              //               ),
              //             ),
              //           );
              //         }
              //         else
              //           return GestureDetector(
              //               onTap: () async{
              //                 await goToDialog(_getCustomer.customer.coupons[index].code,_getCustomer.customer.coupons[index].brand);
              //                 print("tapped");
              //                 print(_getCustomer.customer.coupons[index].id);
              //                 setState(() {
              //                   couponScratched(_getCustomer.customer.coupons[index].id);
              //                 });
              //                 // await couponScratched(_getCustomer.customer.coupons[index].id);
              //                 // setState(() {
              //                 //   print("tapped");
              //                 // });
              //
              //                 //Navigator.push(context, MaterialPageRoute(builder: (context) => BrandStories()));
              //               },
              //               child: Image.asset('assets/scratch_card.png'));
              //       }),
              // ),

              // Container(
              //   height: 500,
              //   child: FutureBuilder(
              //       future: getCustomer("$customerId"),
              //       builder: (context, AsyncSnapshot snapshot) {
              //         if (!snapshot.hasData) {
              //           print(snapshot.data);
              //           return Center(child: CircularProgressIndicator());
              //         }
              //         return GridView.builder(
              //             gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              //                 maxCrossAxisExtent: 200,
              //                 childAspectRatio: 3 / 2,
              //                 crossAxisSpacing: 0,
              //                 mainAxisSpacing: 20),
              //             itemCount: _getCustomer.customer.coupons.length,
              //             itemBuilder: (BuildContext ctx, index) {
              //               if(_getCustomer.customer.coupons[index].used)
              //               {
              //                 return GestureDetector(
              //                   onTap: (){
              //                     Navigator.push(context, MaterialPageRoute(builder: (context) =>RedeemCoupon(code:_getCustomer.customer.coupons[index].code,brand: _getCustomer.customer.coupons[index].brand,link: _getCustomer.customer.coupons[index].link,discount: _getCustomer.customer.coupons[index].discount,expiry:_getCustomer.customer.coupons[index].expiry)));
              //                   },
              //                   child: Padding(
              //                     padding: const EdgeInsets.only(right: 8,left: 8),
              //                     child: Container(
              //                       decoration: BoxDecoration(
              //                         borderRadius: BorderRadius.all(Radius.circular(5)),
              //                         border: Border.all(color: kTextColor[300].withOpacity(0.2)),
              //                       ),
              //                       child: Column(
              //                         mainAxisAlignment: MainAxisAlignment.center,
              //                         children: <Widget>[
              //                           SizedBox(height: 7,),
              //                           Image.asset(
              //                             "assets/trophy.png",width: 30,height: 30,),
              //                           SizedBox(height: 8,),
              //                           Text(
              //                             "You've won",
              //                             style: TextStyle(
              //                                 fontWeight: FontWeight.bold,
              //                                 fontSize: 12,
              //                                 color: Colors.black),
              //                           ),
              //                           SizedBox(height: 2,),
              //                           Text(
              //                             _getCustomer.customer.coupons[index].code,
              //                             style: TextStyle(
              //                                 fontWeight: FontWeight.bold,
              //                                 fontSize: 15,
              //                                 color: kPrimaryColor),
              //                           ),
              //                           Text(
              //                             _getCustomer.customer.coupons[index].brand,
              //                             style: TextStyle(
              //                                 fontWeight: FontWeight.bold,
              //                                 fontSize: 13,
              //                                 color: kTextColor[300]),
              //                           ),
              //                           SizedBox(height: 5,),
              //
              //                         ],
              //                       ),
              //                       //child: Center(child: Text("Rs. "+_getCustomer.customer.cashback[index].amount,)),
              //                     ),
              //                   ),
              //                 );
              //               }
              //               else
              //                 return GestureDetector(
              //                     onTap: () async{
              //                       await goToDialog(_getCustomer.customer.coupons[index].code,_getCustomer.customer.coupons[index].brand);
              //                       print("tapped");
              //                       // setState(() {
              //                       //   couponScratched(_getCustomer.customer.coupons[index].id);
              //                       // });
              //                       await couponScratched(_getCustomer.customer.coupons[index].id);
              //                       setState(() {
              //                         print("tapped");
              //                       });
              //
              //                       //Navigator.push(context, MaterialPageRoute(builder: (context) => BrandStories()));
              //                     },
              //                     child: Image.asset('assets/scratch_card.png'));
              //             });
              //       }
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  goToDialog(amount, brand, couponId) {
    showDialog(
      //barrierColor: Colors.black.withOpacity(0.2),
      context: context,
      //barrierDismissible: true,
      builder: (context) => Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              successTicket(amount, brand, couponId),
              const SizedBox(
                height: 10.0,
              ),
              FloatingActionButton(
                backgroundColor: Colors.black54,
                child: const Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  successTicket(amount, brand, couponId) => Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: Material(
              clipBehavior: Clip.antiAlias,
              elevation: 2.0,
              borderRadius: BorderRadius.circular(4.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            _controllerTopCenter.play();
                          },
                          child: Text(
                            "Congratulations!",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              color: kTextColor[300],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "You have won a scratch card.",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal,
                            color: kTextColor[300],
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: ConfettiWidget(
                                confettiController: _controllerTopCenter,
                                blastDirection: 0,
                                emissionFrequency: 0.1,
                                numberOfParticles: 90,
                                maxBlastForce: 15,
                                minBlastForce: 9,
                                //  maxBlastForce: 10,
                                //shouldLoop: true,
                                minimumSize: const Size(2,
                                    5), // set the minimum potential size for the confetti (width, height)
                                maximumSize: const Size(10, 10),
                                //colors: [kPrimaryColor,kPrimaryPink,kLightGrey]
                              ),
                            ),
                            Card(
                              elevation: 6.0,
                              //margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 10,
                                        spreadRadius: 0,
                                        offset: Offset(0, 0))
                                  ],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ScratchCardW(
                                    brand: brand,
                                    value: amount,
                                    docId: "ddd",
                                    uId: couponId),
                              ),
                            ),
                          ],
                        ),
                        // ScratchCardView(
                        //                                           value: paidAmount.round(), docId: docId, uId: userId
                        //                                             ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
}

class ScratchCardW extends StatefulWidget {
  final String? brand;
  final String? value;
  final String? docId, uId;
  const ScratchCardW({Key? key, this.value, this.docId, this.uId, this.brand})
      : super(key: key);

  @override
  _ScratchCardWState createState() => _ScratchCardWState();
}

class _ScratchCardWState extends State<ScratchCardW> {
  double _opacity = 0.0;
  double brush = 50;

  // Future<bool> _mockCheckForSession() async {
  //   await Future.delayed(Duration(milliseconds: 1000), () {});
  //   return true;
  // }

  @override
  Widget build(BuildContext context) {
    return Scratcher(
      onScratchEnd: () {
        setState(() async {
          await couponScratched(widget.uId);
        });
      },
      accuracy: ScratchAccuracy.low,
      threshold: 35,
      brushSize: brush,
      onThreshold: () {
        print("Threshold reached, you won!");
        setState(() {
          _opacity = 1;
          brush = 500;
        });
      },
      color: Colors.greenAccent.shade700,
      image: Image.asset("assets/scratchcard.png"),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: _opacity,
        child: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/trophy.png",
                  width: 100,
                  height: 95,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "You've won",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "${widget.value}".toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: kPrimaryColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.brand!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: kTextColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
