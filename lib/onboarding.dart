import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'theme.dart';
import 'package:nearlikes/login.dart';
import 'package:google_fonts/google_fonts.dart';


class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int _current=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 190,
              width: double.infinity,
              child: CarouselSlider(
                items: imageSliders,
                options: CarouselOptions(
                    height: 650.0,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }
                ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.map((url) {
                int index = imgList.indexOf(url);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? kPrimaryOrange
                        : Color(0xffc4c4c4),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
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
                      child: Text('Get Started',
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
    );
  }
}

final List<String> imgList = [
  'assets/ob1.png',
  'assets/ob2.png',
  'assets/ob3.png',
];


final List<Widget> imageSliders = imgList
    .map((item) => Container(
  child: Container(
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    '$item',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        )),
  ),
))
    .toList();