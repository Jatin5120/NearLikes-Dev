import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nearlikes/constants/constants.dart';
import 'package:nearlikes/services/services.dart';
import 'package:nearlikes/widgets/widgets.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "NearLikes’s  ",
          style: GoogleFonts.montserrat(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: kTextColor,
          ),
          textAlign: TextAlign.center,
        ),
        TapHandler(
          onTap: () => UrlLauncher.openLink(
              url: "https://nearlikes.com/privacy_policy.html"),
          child: Text(
            "Privacy",
            style: GoogleFonts.montserrat(
              decoration: TextDecoration.underline,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: kBlueColor,
            ),
          ),
        ),
        Text(
          " and  ",
          style: GoogleFonts.montserrat(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: kTextColor,
          ),
        ),
        TapHandler(
          onTap: () => UrlLauncher.openLink(
              url: "https://nearlikes.com/termsofservice.html"),
          child: Text(
            "Terms",
            style: GoogleFonts.montserrat(
              decoration: TextDecoration.underline,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: kBlueColor,
            ),
          ),
        ),
      ],
    );
  }
}
