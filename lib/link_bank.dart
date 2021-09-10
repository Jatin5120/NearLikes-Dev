import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nearlikes/constants/constants.dart';
import 'link_upi_id.dart';

class LinkBank extends StatefulWidget {
  const LinkBank({Key? key}) : super(key: key);

  @override
  _LinkBankState createState() => _LinkBankState();
}

class _LinkBankState extends State<LinkBank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: kPrimaryColor,
                      size: 30,
                    )),
              ),
              const SizedBox(
                height: 0,
              ),
              Image.asset('assets/logo.png', width: 46.31, height: 60.28),
              const SizedBox(
                height: 25,
              ),
              Center(
                child: Text(
                  "LINK BANK ACCOUNT",
                  style: GoogleFonts.montserrat(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: kTextColor[300],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "You need to link your bank account for instant withdrawal of money.",
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: kTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                height: 70.0,
                decoration: BoxDecoration(
                    //color: kDividerColor,
                    border: Border.all(color: kDividerColor),
                    borderRadius: BorderRadius.circular(15.0)),
                child: TextFormField(
                  maxLines: 1,
                  onChanged: (value) {
                    //phone = value;
                  },
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: kTextColor,
                      fontWeight: FontWeight.w700),
                  cursorColor: kPrimaryColor,
                  //autofocus: true,
                  decoration: InputDecoration(
                    prefixStyle: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: kTextColor,
                        fontWeight: FontWeight.w700),
                    isDense: true,
                    contentPadding:
                        const EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                    prefixIcon: const Icon(
                      Icons.person_outline_sharp,
                      color: kDividerColor,
                      size: 20,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide:
                          BorderSide(width: 1, color: Colors.transparent),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide:
                          BorderSide(width: 1, color: Colors.transparent),
                    ),
                    labelText: "Payee Name",
                    labelStyle: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: kDividerColor,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                height: 70.0,
                decoration: BoxDecoration(
                    //color: kDividerColor,
                    border: Border.all(color: kDividerColor),
                    borderRadius: BorderRadius.circular(15.0)),
                child: TextFormField(
                  maxLines: 1,
                  onChanged: (value) {
                    //phone = value;
                  },
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: kTextColor,
                      fontWeight: FontWeight.w700),
                  cursorColor: kPrimaryColor,
                  //autofocus: true,
                  decoration: InputDecoration(
                    prefixStyle: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: kTextColor,
                        fontWeight: FontWeight.w700),
                    isDense: true,
                    contentPadding:
                        const EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                    prefixIcon: const Icon(
                      Icons.account_box_outlined,
                      color: kDividerColor,
                      size: 20,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide:
                          BorderSide(width: 1, color: Colors.transparent),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide:
                          BorderSide(width: 1, color: Colors.transparent),
                    ),
                    labelText: "Account Number",
                    labelStyle: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: kDividerColor,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                height: 70.0,
                decoration: BoxDecoration(
                    //color: kDividerColor,
                    border: Border.all(color: kDividerColor),
                    borderRadius: BorderRadius.circular(15.0)),
                child: TextFormField(
                  maxLines: 1,
                  onChanged: (value) {
                    //phone = value;
                  },
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: kTextColor,
                      fontWeight: FontWeight.w700),
                  cursorColor: kPrimaryColor,
                  //autofocus: true,
                  decoration: InputDecoration(
                    prefixStyle: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: kTextColor,
                        fontWeight: FontWeight.w700),
                    isDense: true,
                    contentPadding:
                        const EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                    prefixIcon: const Icon(
                      Icons.vpn_key_outlined,
                      color: kDividerColor,
                      size: 20,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide:
                          BorderSide(width: 1, color: Colors.transparent),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide:
                          BorderSide(width: 1, color: Colors.transparent),
                    ),
                    labelText: "IFSC Code",
                    labelStyle: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: kDividerColor,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                height: 70.0,
                decoration: BoxDecoration(
                    //color: kDividerColor,
                    border: Border.all(color: kDividerColor),
                    borderRadius: BorderRadius.circular(15.0)),
                child: TextFormField(
                  maxLines: 1,
                  onChanged: (value) {
                    //phone = value;
                  },
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: kTextColor,
                      fontWeight: FontWeight.w700),
                  cursorColor: kPrimaryColor,
                  //autofocus: true,
                  decoration: InputDecoration(
                    prefixStyle: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: kTextColor,
                        fontWeight: FontWeight.w700),
                    isDense: true,
                    contentPadding:
                        const EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                    prefixIcon: const Icon(
                      Icons.account_balance_outlined,
                      color: kDividerColor,
                      size: 20,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide:
                          BorderSide(width: 1, color: Colors.transparent),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide:
                          BorderSide(width: 1, color: Colors.transparent),
                    ),
                    labelText: "Bank Name",
                    labelStyle: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: kDividerColor,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(
                height: 29,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const LinkUPI()));
                },
                child: Text(
                  "Use UPI ID instead",
                  style: GoogleFonts.montserrat(
                    decoration: TextDecoration.underline,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: kPrimaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: InkWell(
                  onTap: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => AccountSetup()));
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          kSecondaryColor,
                          kPrimaryColor,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Add Account',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.white,
                          //letterSpacing: 1
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
