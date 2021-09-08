import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme.dart';
import 'package:nearlikes/redeem_coupon.dart';
import 'package:nearlikes/models/get_customer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Customer _getCustomer;


class NotificationPage extends StatefulWidget {

  final cID;
  NotificationPage({this.cID});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}
Future<Customer> getCustomerID({phone}) async {
  print(".....");
  final String apiUrl = "https://nearlikes.com/v1/api/client/own/fetch";
  var body = {
    "id" : "$phone"
  };
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

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:40,vertical: 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back,color: kPrimaryOrange,size: 30,)),
              ),
              Image.asset('assets/logo.png',width:46.31,height:60),
              SizedBox(height: 25,),
              Center(
                child: Text("NOTIFICATIONS",style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: kFontColor,
                ),),
              ),
              FutureBuilder(
                  future: getCustomerID(phone: "${widget.cID}"),
                  //future: getCustomerID(phone: ""),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      print(snapshot.data);
                      return Center(child: CircularProgressIndicator());
                    }
                    return _getCustomer.customer.coupons.length==0? Padding(
                        padding: EdgeInsets.only(top: 180),
                        child:Text('No Notifications for now!!',style: TextStyle(
                        color: Colors.red,
                          fontSize: 15
                    ),)) :Container(
                        child:  ListView.builder(
                          reverse: true,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _getCustomer.customer.coupons.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return GestureDetector(
                                  onTap: () {
                                    setState(() {


                                    });
                                  },
                                  child:Column(
                                    children: [
                                      ListTile(
                                        contentPadding: EdgeInsets.all(1.2),
                                        tileColor: Colors.grey,
                                        //leading: Icon(Icons.add),
                                        title: Text(_getCustomer.customer.coupons[index].brand,style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: kFontColor,
                                        ),),
                                        trailing: Text("13:21",style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: kFontColor,
                                        ),),
                                        subtitle: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text("Enjoy ${_getCustomer.customer.coupons[index].discount} off on your next visit with code ${_getCustomer.customer.coupons[index].code}",style: GoogleFonts.montserrat(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: kFontColor,
                                          ),),
                                        ),
                                        selected: true,
                                      ),
                                      Divider(color: Colors.grey,)
                                    ],
                                  ),


                                  // child: Container(
                                  //
                                  //     // decoration: BoxDecoration(
                                  //     //   border: Border(
                                  //     //     bottom: BorderSide(
                                  //     //     color: Colors.grey,
                                  //     //     width: 0.5,
                                  //     //   ),),
                                  //     //
                                  //     //     ),
                                  //     child: Padding(
                                  //       padding: const EdgeInsets.only(top: 8,bottom: 8),
                                  //       child: ListTile(
                                  //         tileColor: Colors.grey,
                                  //         //leading: Icon(Icons.add),
                                  //         title: Text("Brand XYZ",style: GoogleFonts.montserrat(
                                  //           fontSize: 14,
                                  //           fontWeight: FontWeight.w500,
                                  //           color: kFontColor,
                                  //         ),),
                                  //         trailing: Text("13:21",style: GoogleFonts.montserrat(
                                  //           fontSize: 14,
                                  //           fontWeight: FontWeight.w500,
                                  //           color: kFontColor,
                                  //         ),),
                                  //         subtitle: Padding(
                                  //           padding: const EdgeInsets.all(2.0),
                                  //           child: Text("Enjoy 10% off on your next visit with code a3hiKuZsh2",style: GoogleFonts.montserrat(
                                  //             fontSize: 13,
                                  //             fontWeight: FontWeight.w400,
                                  //             color: kFontColor,
                                  //           ),),
                                  //         ),
                                  //         selected: true,
                                  //       ),
                                  //     ))
                              );
                            }));
                  }
              ),



            ],
          ),
        ),
      ),
    );
  }
}
