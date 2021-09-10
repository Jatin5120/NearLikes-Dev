// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:nearlikes/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../about_page.dart';
import '../faq.dart';
import '../help_page.dart';
import '../login.dart';
import '../models/get_customer.dart';
import '../scratch_cards.dart';
import 'constants/constants.dart';
import 'coupon.dart';
import 'link_upi_id.dart';

class ProfilePage extends StatefulWidget {
  final String? phoneNumber;
  const ProfilePage({Key? key, this.phoneNumber}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int sum = 0;

  Customer? _getCustomer;
  String? cID;

  String? name = '';
  String? phonenumber;
  String? customerId;

  late List<Map<String, dynamic>> _profileListItems;

  Future<Customer?> getCustomer(String? customerId) async {
    const String apiUrl = "https://nearlikes.com/v1/api/client/own/fetch";
    Map<String, String> body = {"id": "$customerId"};
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );

    print("StatusCode --> ${response.statusCode}");
    final String responseString = response.body;

    print(responseString);
    _getCustomer = customerFromJson(responseString);

    for (int i = 0; i < _getCustomer!.customer!.cashback!.length; i++) {
      if (_getCustomer!.customer!.cashback![i].used == true) {
        var a = int.parse(_getCustomer!.customer!.cashback![i].amount!);
        assert(a is int);

        sum = sum + a;
      }
    }

    print(sum);
    print("Name --> ${_getCustomer!.customer!.name}");
    setState(() {
      name = _getCustomer!.customer!.name;
      cID = _getCustomer!.customer!.id;
    });
    return _getCustomer;
  }

  Future<void> deleteAcc() async {
    print('Phone number --> $phonenumber');
    // var body = {
    //   "phone": "+91${phonenumber}"
    // };
    final Map<String, String> body = {"phone": "+91$phonenumber"};
    final http.Response response = await http.post(
      Uri.parse('https://nearlikes.com/v1/api/client/delete'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );
    print("StatusCode --> ${response.statusCode}");
    print(response.body);
  }

  Future<void> getCustomerId(String? phonenumber) async {
    final Map<String, String> body = {"phone": "+91$phonenumber"};

    try {
      final response = await http.post(
        Uri.parse('https://nearlikes.com/v1/api/client/getid'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );
      var test = jsonDecode(response.body);
      print('the response is $test');
      getCustomer(test);
    } catch (e) {
      print("Error--> $e");
    }
  }

  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      customerId = prefs.getString('customer_id');
      phonenumber = prefs.getString('phonenumber');
    });
    print('Phone number --> $phonenumber');
    print('Customer id --> $customerId');
    if (customerId == null) {
      getCustomerId(phonenumber);
    } else {
      getCustomer(customerId);
    }
  }

  @override
  void initState() {
    super.initState();
    //get();
    _profileListItems = [
      {'title': 'Cash Rewards', 'screen': ScratchCards(cID: cID)},
      {'title': 'Coupons', 'screen': Coupons(cID: cID)},
      {
        'title': 'Link UPI ID',
        'screen': LinkUPI(phoneNumber: widget.phoneNumber)
      },
      {'title': 'About', 'screen': const About()},
      {'title': 'FAQ', 'screen': const FAQ()},
      {
        'title': 'Help',
        'screen': const Help(),
      },
      {'title': 'LogOut', 'screen': const Login(), 'isLast': true}
    ];
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          height: size.height.ninetyFivePercent,
          child: Padding(
            padding: EdgeInsets.symmetric(
                    horizontal: size.width.sevenPointFivePercent,
                    vertical: size.height.sevenPointFivePercent)
                .copyWith(bottom: 0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    name!,
                    style: GoogleFonts.montserrat(
                      fontSize: 29,
                      fontWeight: FontWeight.w700,
                      color: kTextColor[700],
                    ),
                  ),
                  SizedBox(height: size.height.fivePercent),
                  RewardCard(sum: sum),
                  // Spacer(),
                  SizedBox(
                    height: size.height.fiftyPercent,
                    child: ListView.separated(
                      itemCount: _profileListItems.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        Map<String, dynamic> item = _profileListItems[index];
                        return InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            if (item['isLast'] != null) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.clear();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Login(),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => item['screen'],
                                ),
                              );
                            }
                          },
                          child: SizedBox(
                            height: size.height.fivePercent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item['title'],
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: item['isLast'] != null
                                        ? kPrimaryColor
                                        : kTextColor[700],
                                  ),
                                ),
                                Icon(
                                  item['isLast'] != null
                                      ? Icons.logout_outlined
                                      : Icons.arrow_forward_rounded,
                                  color: kSecondaryColor,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, index) => Divider(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
