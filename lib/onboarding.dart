import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:nearlikes/constants/constants.dart';

import '../login.dart';
import 'widgets/widgets.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int _current = 0;

  static List<String> imgList = [
    'assets/ob1.png',
    'assets/ob2.png',
    'assets/ob3.png',
  ];

  final List<Widget> imageSliders = imgList
      .map(
        (item) => Container(
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(item),
              fit: BoxFit.fill,
            ),
          ),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.8,
            width: double.maxFinite,
            child: CarouselSlider(
              items: imageSliders,
              options: CarouselOptions(
                height: size.height * 0.7,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.map((url) {
              int index = imgList.indexOf(url);
              return Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index ? kPrimaryColor : kDividerColor,
                ),
              );
            }).toList(),
          ),
          const Spacer(),
          LongButton(
            label: 'Get Started',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Login()));
            },
          ),
        ],
      ),
    );
  }
}
