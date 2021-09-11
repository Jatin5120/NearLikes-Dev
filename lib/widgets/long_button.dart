import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nearlikes/constants/constants.dart';

import 'widgets.dart';

class LongButton extends StatelessWidget {
  const LongButton(
      {Key? key,
      required this.label,
      required this.onTap,
      this.givePadding = true})
      : super(key: key);

  final String label;
  final VoidCallback onTap;
  final bool givePadding;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    print(size.height.fivePercent);
    return TapHandler(
      onTap: onTap,
      child: Container(
        margin: givePadding
            ? EdgeInsets.all(size.width.fivePercent)
            : EdgeInsets.zero,
        width: size.width,
        height: max(size.height.fivePercent, 48),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: const LinearGradient(
            colors: [kSecondaryColor, kPrimaryColor],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: kWhiteColor,
            //letterSpacing: 1
          ),
        ),
      ),
    );
  }
}
