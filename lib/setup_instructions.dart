// ignore: implementation_imports
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nearlikes/services/services.dart';
import 'package:nearlikes/widgets/back_button.dart';
import 'package:nearlikes/widgets/logo.dart';
import 'package:nearlikes/widgets/tap_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:nearlikes/constants/constants.dart';

import '../link_account.dart';
import 'widgets/widgets.dart';

class SetupInstructions extends StatefulWidget {
  final phnum, name, age, location;
  const SetupInstructions(
      {Key? key, this.phnum, this.name, this.age, this.location})
      : super(key: key);

  @override
  _SetupInstructionsState createState() => _SetupInstructionsState();
}

class _SetupInstructionsState extends State<SetupInstructions> {
  final String? videoId = YoutubePlayer.convertUrlToId(
      "https://www.youtube.com/watch?v=9rdnmbAp9k4");

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Padding(
            padding: pagePadding(size),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const MyBackButton(),
                const Logo.small(),
                SizedBox(height: size.height.twoPointFivePercent),
                Center(
                  child: Text(
                    "How to setup your instagram",
                    style: GoogleFonts.montserrat(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: kTextColor[300],
                    ),
                  ),
                ),
                SizedBox(height: size.height.onePercent),
                Text(
                  "Follow the steps below to setup your instagram account.",
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: kTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                YoutubePlayer(
                  controller: YoutubePlayerController(
                    initialVideoId: '$videoId', //Add videoID.
                    flags: const YoutubePlayerFlags(
                      hideControls: false,
                      controlsVisibleAtStart: true,
                      autoPlay: false,
                      mute: false,
                    ),
                  ),
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: kSecondaryColor,
                ),
                SizedBox(height: size.height.twoPointFivePercent),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Step wise guide  --> \t",
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: kTextColor,
                      ),
                    ),
                    TapHandler(
                      onTap: () {
                        ///TODO: Implement Navigation to Help Screen
                      },
                      child: Text(
                        "HELP",
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                LongButton(
                  label: 'Next',
                  givePadding: false,
                  onTap: () async {
                    print(widget.location);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LinkAccount(
                          phnum: widget.phnum,
                          name: widget.name,
                          age: widget.age,
                          location: widget.location,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: size.height.twoPercent),
                const TermsAndConditions(),
                SizedBox(height: size.height.twoPointFivePercent),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
