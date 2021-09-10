import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nearlikes/constants/constants.dart';
import 'package:nearlikes/constants/extensions.dart';

class RewardCard extends StatelessWidget {
  const RewardCard({
    Key? key,
    required this.sum,
  }) : super(key: key);

  final int sum;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.25,
      width: double.maxFinite,
      child: Stack(
        children: [
          Positioned(
            top: 60,
            left: size.width.fifteenPercent,
            right: size.width.fifteenPercent,
            child: Container(
              height: size.height.fifteenPercent,
              decoration: BoxDecoration(
                color: kDividerColor[300]!,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Column(
                children: [
                  Spacer(flex: 3),
                  Text(
                    'TOTAL REWARDS',
                    style: GoogleFonts.montserrat(
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xffB9B9B9),
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Rs. $sum",
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: kTextColor[700],
                    ),
                  ),
                  Spacer(flex: 2),
                ],
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: size.width.thirtyPercent,
            right: size.width.thirtyPercent,
            child: Container(
              decoration: BoxDecoration(
                color: kWhiteColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: kShadowColor,
                    offset: const Offset(0, 8),
                    blurRadius: 15.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: size.width.fifteenPercent,
                  height: size.width.fifteenPercent,
                  child: Image.asset('assets/logo.png'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
