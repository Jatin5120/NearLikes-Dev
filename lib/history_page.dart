// import 'dart:math';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:nearlikes/LinkBank.dart';
// import 'package:nearlikes/page_guide.dart';
// import 'package:nearlikes/scratch_cards.dart';
// import 'package:nearlikes/select_brand.dart';
// import 'theme.dart';
// import 'package:google_fonts/google_fonts.dart';
// class HistoryPage extends StatefulWidget {
//
//   @override
//   _HistoryPageState createState() => _HistoryPageState();
// }
//
// class _HistoryPageState extends State<HistoryPage> {
//   @override
//   Widget build(BuildContext context) {
//     return
//       Scaffold(
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.only(top:70,left: 34,right: 34),
//             child: Container(
//               width: double.infinity,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: GestureDetector(
//                         onTap: (){
//                           Navigator.pop(context);
//                         },
//                         child: Icon(Icons.arrow_back,color: kPrimaryOrange,size: 30,)),
//                   ),
//                   Text('HISTORY',style: GoogleFonts.montserrat(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: kFontColor,
//                   )),
//                   Container(
//                     height: 200,
//                     width: double.infinity,
//                     child: Stack(
//                       children: [
//                         Positioned(
//                           top:70,
//                           left:MediaQuery.of(context).size.width*0.178,
//                           child: Container(
//                             height: 117,
//                             width: 186,
//                             decoration: BoxDecoration(
//                                 color: Color(0xfff2f2f2),
//                                 borderRadius: BorderRadius.all(Radius.circular(8))
//                             ),
//                             child: Column(
//                               children: [
//                                 SizedBox(height: 45,),
//                                 Text('TOTAL REWARDS',style: GoogleFonts.montserrat(
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w300,
//                                   color: Color(0xffB9B9B9),
//                                 )),
//                                 SizedBox(height: 8,),
//                                 Text("\$ 75.00",style: GoogleFonts.montserrat(
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.w600,
//                                   color: kBlack,
//                                 )),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           top:30,
//                           left:MediaQuery.of(context).size.width*0.325,
//                           child: Container(
//                             height: 72,
//                             width: 72,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               shape:BoxShape.circle,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.1),
//                                   offset: const Offset(
//                                     4, 8,
//                                   ),
//                                   blurRadius: 20.0,
//                                   spreadRadius: 0,
//                                 ), //BoxShadow//BoxShadow
//                               ],
//                             ),
//                             child:  Padding(
//                               padding: const EdgeInsets.all(15),
//                               child: Image.asset('assets/logo.png',width:32.48,height:42.28),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 50,),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Luxterior Design',style: GoogleFonts.montserrat(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: kBlack,
//                           )),
//                           Text('27/06/2021 1:00pm',style: GoogleFonts.montserrat(
//                             fontSize: 11,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xffB9B9B9),
//                           )),
//                         ],
//                       ),
//
//                       Text('\$ 30.00',style: GoogleFonts.montserrat(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: kBlack,
//                       )),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     child: Divider(color: Color(0xffDDDDDD)),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Aria Decor',style: GoogleFonts.montserrat(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: kBlack,
//                           )),
//                           Text('27/06/2021 1:00pm',style: GoogleFonts.montserrat(
//                             fontSize: 11,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xffB9B9B9),
//                           )),
//                         ],
//                       ),
//
//                       Text('\$ 25.00',style: GoogleFonts.montserrat(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: kBlack,
//                       )),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     child: Divider(color: Color(0xffDDDDDD)),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Gaia Haus',style: GoogleFonts.montserrat(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: kBlack,
//                           )),
//                           Text('27/06/2021 1:00pm',style: GoogleFonts.montserrat(
//                             fontSize: 11,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xffB9B9B9),
//                           )),
//                         ],
//                       ),
//
//                       Text('\$ 20.00',style: GoogleFonts.montserrat(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: kBlack,
//                       )),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     child: Divider(color: Color(0xffDDDDDD)),
//                   ),
//                   SizedBox(height: 15,),
//                   Text('Check out other brands and earn more.',style: GoogleFonts.montserrat(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w400,
//                     color: kDarkGrey,
//                   )),
//                   SizedBox(height: 15,),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 0),
//                     child: InkWell(
//                       onTap: (){
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => PageGuide(phoneNumber: widget.phoneNumber,)));
//                       },
//                       child: Container(
//                           height: 50,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               gradient: LinearGradient(
//                                 begin: Alignment.topRight,
//                                 end: Alignment.bottomLeft,
//                                 colors: [
//                                   kPrimaryPink,
//                                   kPrimaryOrange,
//                                 ],
//                               )
//                           ),
//                           child: Center(
//                             child:  Text('Dashboard',
//                                 style: GoogleFonts.montserrat(
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 14,
//                                   color: Colors.white,
//                                   //letterSpacing: 1
//                                 )),
//                           )),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//   }
// }
