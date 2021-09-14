// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:nearlikes/constants/constants.dart';

import '../brand_stories.dart';
import 'models/get_campaigns.dart';
import 'services/services.dart';

class SelectBrand extends StatelessWidget {
  final String? id; //owner id
  final String? brand;
  final String? campaignId;
  final bool showBackButton;

  const SelectBrand(
      {Key? key,
      this.id,
      this.brand,
      this.campaignId,
      this.showBackButton = false})
      : super(key: key);

  static GetCampaigns? _getCampaigns;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40, top: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              showBackButton == true
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: kPrimaryColor,
                          size: 30,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              Image.asset('assets/logo.png', width: 46.31, height: 60),
              const SizedBox(
                height: 25,
              ),
              Center(
                child: Text(
                  "SELECT A BRAND",
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: kTextColor[300],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: getAvailableCampaigns(
                    followers: 500, location: "kolkata", age: 40),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    print(snapshot.data);
                    return const Center(child: CircularProgressIndicator());
                  }
                  print(snapshot.data);
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 4,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: _getCampaigns?.campaigns!.length ?? 1,
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  final Campaign campaign =
                                      _getCampaigns!.campaigns![index];
                                  return BrandStories(
                                    brand: campaign.brand!,
                                    id: campaign.ownerId!,
                                    campaignId: campaign.id!,
                                    brandMoto: campaign.text!,
                                  );
                                },
                              ),
                            );
                          },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: (_getCampaigns == null
                                    ? const AssetImage('assets/logo.png')
                                    : NetworkImage(_getCampaigns!
                                        .campaigns![index]
                                        .logo!) as ImageProvider<Object>),
                                fit: BoxFit.cover,
                              ),
                              color: kDividerColor,
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        kOverlayColor,
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: size.height.twoPercent),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          _getCampaigns
                                                  ?.campaigns![index].brand! ??
                                              'Brand',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                        // Text(
                                        //   "${_getCampaigns.campaigns[index].text}",
                                        //   style: GoogleFonts.montserrat(
                                        //     fontSize: 14,
                                        //     fontWeight: FontWeight.w400,
                                        //     color: Colors.white,
                                        //   ),),
                                        // Text(
                                        //   "${readTimestamp(_getCampaigns.campaigns[index].start)}",style: GoogleFonts.montserrat(
                                        //     fontSize: 11,
                                        //     fontWeight: FontWeight.w500,
                                        //     color:Colors.white
                                        // ),),
                                        // Text(
                                        //   "to ${readTimestamp(_getCampaigns.campaigns[index].end)}",style: GoogleFonts.montserrat(
                                        //     fontSize: 11,
                                        //     fontWeight: FontWeight.w500,
                                        //     color: Colors.white
                                        // ),),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
