// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nearlikes/widgets/widgets.dart';
import 'brand_stories.dart';
import 'coupon.dart';
import '../notifications.dart';
import '../scratch_cards.dart';
import '../select_brand.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'models/get_campaigns.dart';
import 'dart:convert';
import 'dart:async';
import '../models/get_customer.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'globals.dart' as globals;
import 'package:badges/badges.dart';
import '../constants/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

// void get()async{
//   await getCustomer();
// }

class _HomePageState extends State<HomePage> {
  int sum = 0;
  String? name = '';
  String? customerId;
  String? phonenumber;
  String? cID;

  GetCampaigns? _getCampaigns;
  Customer? _getCustomer;

  Future<GetCampaigns?> getAvailableCampaigns(
      {int? followers, String? location, int? age}) async {
    const String apiUrl = "https://nearlikes.com/v1/api/campaign/get/campaigns";
    final Map<String, dynamic> body = {
      "followers": followers,
      "location": "kolkata",
      "age": age
    };
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );
    print("statusCode --> ${response.statusCode}");
    final String responseString = response.body;

    print("Response --> $responseString");
    _getCampaigns = getCampaignsFromJson(responseString);
    return _getCampaigns;
  }

  Future<Customer?> getCustomer(String? customerId) async {
    print("customerId--> $customerId");
    const String apiUrl = "https://nearlikes.com/v1/api/client/own/fetch";
    var body = {"id": "$customerId"};
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );
    print("Response --> ${response.body}");
    final String responseString = response.body;
    _getCustomer = customerFromJson(responseString);
    print("Cashback --> ${_getCustomer!.customer!.cashback}");

    for (int i = 0; i < _getCustomer!.customer!.cashback!.length; i++) {
      if (_getCustomer!.customer!.cashback![i].used == true) {
        int a = int.parse(_getCustomer!.customer!.cashback![i].amount!);
        assert(a is int);
        sum = sum + a;
      }
    }

    print("sum --> $sum");
    print("Customer name ${_getCustomer!.customer!.name}");
    setState(() {
      name = _getCustomer!.customer!.name;
      cID = _getCustomer!.customer!.id;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', _getCustomer!.customer!.token!);
    return _getCustomer;
  }

  Future<void> getCustomerId(String? phonenumber) async {
    final Map<String, String> body = {"phone": "+91$phonenumber"};

    try {
      final http.Response response = await http.post(
        Uri.parse('https://nearlikes.com/v1/api/client/getid'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );
      var test = jsonDecode(response.body);
      print('the response is $test');
      getCustomer(test);
      addPlayer(test);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    customerId = prefs.getString('customer_id');
    phonenumber = prefs.getString('phonenumber');
    print('PhoneNumber --> $phonenumber');
    print('Customer Id --> $customerId');
    if (customerId == null) {
      getCustomerId(phonenumber);
    } else {
      getCustomer(customerId);
      addPlayer(customerId);
    }
  }

  Future<void> initPlatformState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? checkUser = prefs.getBool('checkuser');
    OneSignal.shared.setNotificationOpenedHandler(
      (openedResult) async {
        final Map<String, dynamic> data =
            openedResult.notification.additionalData!;
        final String id = openedResult.notification.notificationId;

        print('Data --> $data');
        print('Notification id --> $id');

        var postId = await data['post_id'];
        print('Post id --> $postId');

        if (checkUser == true) {
          if (postId == 'coupon') {
            globals.appNaviagtor!.currentState!.push(
              MaterialPageRoute(
                builder: (context) => Coupons(
                  cID: cID,
                ),
              ),
            );
          } else if (postId == 'campaign') {
            globals.appNaviagtor!.currentState!.push(
              MaterialPageRoute(
                builder: (context) => const SelectBrand(
                  showBackButton: true,
                ),
              ),
            );
          } else if (postId == 'cashback') {
            globals.appNaviagtor!.currentState!.push(
              MaterialPageRoute(
                builder: (context) => ScratchCards(
                  cID: cID!,
                ),
              ),
            );
          }
          //else  globals.appNaviagtor.currentState.push(MaterialPageRoute(builder: (context)=>HomePage()));
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    //get();
    getUserData();
  }

  Future<void> addPlayer(String? customerId) async {
    print('Inside AddPlayer');

    final OSDeviceState? status = await OneSignal.shared.getDeviceState();
    final String osUserID = status!.userId!;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs
        .setString('playerId', osUserID)
        .then((value) => print('job done $value'));
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    // var PlayerId= prefs.getString('playerId');
    print('Player id --> $osUserID');
    print('Customer id --> $customerId');
    const String url = 'https://nearlikes.com/v1/api/client/add/player';
    final Map<String, String> body = {
      "id": customerId!,
      "push": osUserID,
    };
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );
    print("Body --> ${response.body}");
    print("Status code --> ${response.statusCode}");
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width.sevenPointFivePercent,
            vertical: size.height.sevenPointFivePercent,
          ).copyWith(bottom: 0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Welcome,',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: kTextColor[300],
                      ),
                    ),
                    TapHandler(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationPage(cID: cID),
                          ),
                        );
                      },
                      child: Badge(
                        toAnimate: true,
                        animationType: BadgeAnimationType.scale,
                        badgeContent: Text(
                          '*',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        child: const Icon(
                          Icons.notifications_active,
                          color: Colors.black,
                          size: 25,
                        ),
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
                Text(
                  name ?? 'User',
                  style: GoogleFonts.montserrat(
                    fontSize: 29,
                    fontWeight: FontWeight.w700,
                    color: kTextColor[700],
                  ),
                ),
                RewardCard(sum: sum),
                const PostStoryButton(),
                SizedBox(height: size.height.fivePercent),
                Text(
                  'Brand Reward',
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
                      return const Center(child: CircularProgressIndicator());
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: size.width.fortyPercent,
                        childAspectRatio: 3 / 4,
                        crossAxisSpacing: size.width.fivePercent,
                        mainAxisSpacing: size.width.fivePercent,
                      ),
                      itemCount: _getCampaigns?.campaigns!.length ?? 0,
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  final Campaign campaign =
                                      _getCampaigns!.campaigns![index];
                                  return BrandStories(
                                    brand: campaign.brand!,
                                    id: campaign.ownerId!,
                                    campaignId: campaign.id!,
                                    brandMoto: campaign.text!,
                                    brandTag: campaign.username!,
                                  );
                                },
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: (_getCampaigns == null
                                      ? const AssetImage('assets/logo.png')
                                      : NetworkImage(_getCampaigns!
                                          .campaigns![index]
                                          .logo!) as ImageProvider<Object>),
                                  fit: BoxFit.cover,
                                ),
                                color: kDividerColor,
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          kOverlayColor,
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.height.twoPercent),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            _getCampaigns?.campaigns![index]
                                                    .brand! ??
                                                'Brand',
                                            style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
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
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String readTimestamp(int timestamp) {
  DateFormat format = DateFormat('d MMM h:mm a');
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  String diff = format.format(date);
  return diff;
}
