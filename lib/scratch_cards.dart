// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:nearlikes/link_upi_id.dart';
import 'package:nearlikes/page_guide.dart';
import 'package:confetti/confetti.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratcher/widgets.dart';
import 'package:nearlikes/models/get_customer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/constants.dart';

Customer? _getCustomer;
String? customerId;
String? phonenumber;
String? cashbackId;

Future<String> cashbackScratched(String couponId) async {
  print('the customer id is $customerId');
  print("..8989..");
  print('the coupon id is $couponId');
  const String apiUrl = "https://nearlikes.com/v1/api/client/cashback/scratch";
  var body = {"id": couponId, "ownerId": "$customerId"};
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: json.encode(body),
  );

  print(".....");
  print(response.statusCode);
  print('----');
  final String responseString = response.body.toString();
  print(']||/*/');
  print(responseString);
  print('232323');
  return responseString;
  // _getCustomer = customerFromJson(responseString);
  // print(";;;");
  // print(_getCustomer.customer.name);
  // return _getCustomer;
}

class ScratchCards extends StatefulWidget {
  final String cID;
  const ScratchCards({Key? key, required this.cID}) : super(key: key);

  @override
  _ScratchCardsState createState() => _ScratchCardsState();
}

getCustomerId(String phonenumber) async {
  var body = {"phone": "+91$phonenumber"};

  final response = await http.post(
    Uri.parse('https://nearlikes.com/v1/api/client/getid'),
    headers: {"Content-Type": "application/json"},
    body: json.encode(body),
  );
  var test = jsonDecode(response.body);
  print('the response is $test');
}

Future<Customer?> getCustomerID({required String phone}) async {
  print(".....");
  const String apiUrl = "https://nearlikes.com/v1/api/client/own/fetch";
  var body = {"id": phone};
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

class _ScratchCardsState extends State<ScratchCards> {
  Future<Customer?> getCustomer(String customerId) async {
    print(".....");
    const String apiUrl = "https://nearlikes.com/v1/api/client/own/fetch";
    var body = {"id": customerId};
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
    print(_getCustomer!.customer!.name);
    return _getCustomer;
  }

  Future getCustomerId(String phonenumber) async {
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
  }

  late ConfettiController _controllerTopCenter;
  late List mySelTeams;
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
      getCustomerId(phonenumber!);
    } else {
      getCustomer(customerId!);
    }
  }

  @override
  void initState() {
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
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: kPrimaryColor,
                      size: 30,
                    )),
              ),
              Image.asset('assets/logo.png', width: 46.31, height: 60),
              const SizedBox(
                height: 35,
              ),
              Center(
                child: Text(
                  "MY CASH REWARDS",
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
                  return _getCustomer!.customer!.cashback!.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.only(top: 180),
                          child: Text(
                            'Post a story to get cash reward',
                            style: TextStyle(color: Colors.red, fontSize: 15),
                          ))
                      : GridView.builder(
                          reverse: true,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 220,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 20,
                          ),
                          itemCount: _getCustomer!.customer!.cashback!.length,
                          itemBuilder: (BuildContext ctx, index) {
                            if (_getCustomer!
                                .customer!.cashback![index].used!) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(right: 8, left: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    border:
                                        Border.all(color: kDividerColor[300]!),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Image.asset(
                                        "assets/trophy.png",
                                        width: 40,
                                        height: 40,
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
                                        "Rs. " +
                                            _getCustomer!.customer!
                                                .cashback![index].amount!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: kPrimaryColor),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                  //child: Center(child: Text("Rs. "+_getCustomer.customer.cashback[index].amount,)),
                                ),
                              );
                            } else {
                              return GestureDetector(
                                  onTap: () async {
                                    await goToDialog(
                                        "Rs. " +
                                            _getCustomer!.customer!
                                                .cashback![index].amount!,
                                        "");
                                    print("tapped");

                                    setState(() {
                                      cashbackId = _getCustomer!
                                          .customer!.cashback![index].id;
                                    });
                                    // upi=await cashbackScratched(_getCustomer.customer.cashback[index].id);
                                    // print('2323 $upi');

                                    // setState(() {
                                    //   cashbackScratched(_getCustomer.customer.cashback[index].id);
                                    // });

                                    // await Future.delayed(const Duration(milliseconds: 500), () {
                                    //   setState(() async{
                                    //     await  cashbackScratched(_getCustomer.customer.cashback[index].id);
                                    //   });
                                    //
                                    // });

                                    // setState(() {
                                    //   print("tapped");
                                    // });

                                    //Navigator.push(context, MaterialPageRoute(builder: (context) => BrandStories()));
                                  },
                                  child:
                                      Image.asset('assets/scratch_card.png'));
                            }
                          },
                        );
                },
              ),

              // Container(
              //   height: 200,
              //   child: FutureBuilder(
              //       future: getCustomerID(phone:'+919790984081'),
              //       builder: (context, AsyncSnapshot snapshot) {
              //         // if (!snapshot.hasData) {
              //         //   print(snapshot.data);
              //         //   return Center(child: CircularProgressIndicator());
              //         // }
              //         return GridView.builder(
              //             gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              //                 maxCrossAxisExtent: 200,
              //                 childAspectRatio: 3 / 2,
              //                 crossAxisSpacing: 20,
              //                 mainAxisSpacing: 20),
              //             itemCount: _getCustomer.customer.coupons.length,
              //             itemBuilder: (BuildContext ctx, index) {
              //               return GestureDetector(
              //                   onTap: () {
              //                     goToDialog(_getCustomer.customer.coupons[index].code,_getCustomer.customer.coupons[index].brand);
              //                     //Navigator.push(context, MaterialPageRoute(builder: (context) => BrandStories()));
              //                   },
              //                   child: Image.asset('assets/scratch_card.png'));
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

  goToDialog(amount, brand) {
    showDialog(
      //barrierColor: Colors.black.withOpacity(0.2),
      context: context,
      //barrierDismissible: true,
      builder: (context) => Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              successTicket(amount, brand),
              const SizedBox(
                height: 10.0,
              ),
              // FloatingActionButton(
              //   backgroundColor: Colors.black54,
              //   child: Icon(
              //     Icons.clear,
              //     color: Colors.white,
              //   ),
              //   onPressed: () {
              //     Navigator.pop(context);
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }

  successTicket(amount, brand) => Stack(
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
                                  uId: "dddd",
                                ),
                              ),
                            ),
                          ],
                        ),
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
  final String brand;
  final String value;
  final String docId, uId;

  const ScratchCardW(
      {Key? key,
      required this.value,
      required this.docId,
      required this.uId,
      required this.brand})
      : super(key: key);

  @override
  _ScratchCardWState createState() => _ScratchCardWState();
}

class _ScratchCardWState extends State<ScratchCardW> {
  double _opacity = 0.0;
  double brush = 50;
  Future<bool> _mockCheckForSession() async {
    await Future.delayed(const Duration(milliseconds: 000), () {});
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scratcher(
      accuracy: ScratchAccuracy.low,
      threshold: 5,
      brushSize: brush,
      onChange: (value) {
        print('sadasd$value');
      },
      onThreshold: () {
        print("Threshold reached, you won!");
        setState(() {
          _opacity = 1;
          brush = 500;
        });
        _mockCheckForSession().then(
          (value) async {
            String upi = await cashbackScratched(cashbackId!);
            print('2323 $upi');

            return showDialog(
              context: context,
              builder: (context) {
                return upi == 'true'
                    ? AlertDialog(
                        title: const Text('Congratulations'),
                        content: const Text('your cash reward has been sent!'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PageGuide(),
                                ),
                              );
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      )
                    : AlertDialog(
                        title: const Text('Add UPI'),
                        content: const Text(
                            'Please add your upi for getting the cash reward '),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LinkUPI(),
                                ),
                              );
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
              },
            );
          },
        );
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
                  widget.value.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: kPrimaryColor),
                ),
                const SizedBox(
                  height: 2,
                ),
                // Text(
                //   "${widget.brand}"==""?"":widget.brand,
                //   style: TextStyle(
                //       fontWeight: FontWeight.w600,
                //       fontSize: 22,
                //       color:kDarkGrey),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
