import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nearlikes/constants/constants.dart';

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
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        margin: givePadding
            ? EdgeInsets.all(size.width.fivePercent)
            : EdgeInsets.zero,
        width: size.width,
        height: size.height.fivePercent,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          gradient: LinearGradient(
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
