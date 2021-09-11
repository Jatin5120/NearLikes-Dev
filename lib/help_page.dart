import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nearlikes/constants/constants.dart';
import 'package:nearlikes/services/services.dart';
import 'package:nearlikes/widgets/widgets.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  static final List<Map<String, dynamic>> _contactItems = [
    {
      'icon': const Icon(Icons.mail_outline, color: kPrimaryColor),
      'title': 'Email',
      'contact': 'support@nearlikes.com',
      'onTap': () => UrlLauncher.openMail(),
    },
    {
      'icon': Icon(Icons.phone_rounded, color: kPrimaryColor),
      'title': 'Phone',
      'contact': '+91 9392708293',
      'onTap': () => UrlLauncher.openCall(),
    },
    {
      'icon': SvgPicture.asset('assets/whatsapp.svg',
          color: kPrimaryColor, height: 24),
      'title': 'Message',
      'contact': '+91 9392708293',
      'onTap': () => UrlLauncher.openWhatsapp(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width.tenPercent,
          vertical: size.height.sevenPointFivePercent,
        ).copyWith(bottom: size.height.fivePercent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyBackButton(),
            SizedBox(height: size.height.fivePercent),
            Logo.small(),
            SizedBox(height: size.height.twoPointFivePercent),
            Text(
              "HELP",
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: kTextColor[300],
              ),
            ),
            SizedBox(height: size.height.twoPercent),
            Text(
              'We are happy to help you. \nFeel free to contact.',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: kTextColor[300],
              ),
            ),
            for (int i = 0; i < _contactItems.length; i++) ...[
              _ContactItem(_contactItems[i]),
            ],
            const Spacer(),
            Text(
              'Note: You can tap on any contact to reach us',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: kTextColor[300],
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  const _ContactItem(this._contact, {Key? key}) : super(key: key);

  final Map<String, dynamic> _contact;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: size.height.fivePercent),
        _contact['icon'],
        SizedBox(height: size.height.twoPercent),
        TapHandler(
          onTap: _contact['onTap'],
          child: Text(
            _contact['title'],
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: kTextColor[300],
            ),
          ),
        ),
        SizedBox(height: size.height.onePercent),
        TapHandler(
          onTap: _contact['onTap'],
          child: Text(
            _contact['contact'],
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 15,
              fontWeight: FontWeight.w300,
              color: kTextColor[300],
              letterSpacing: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
