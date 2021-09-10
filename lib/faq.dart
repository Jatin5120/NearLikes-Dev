import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants/constants.dart';
import 'widgets/widgets.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  _FAQState createState() => _FAQState();
}

List<String> questions = [
  '1.Where can I download the app?',
  '2. How can I register?',
  '3. What is the cost of registration?',
  '4. How can I link my Instagram account to Nearlikes account?',
  '5. What criteria should I fulfill in order to have a Nearlikes account?',
  '6. How do I post a story?',
  '7. What guidelines should I follow while creating my story?',
  '8. What rewards will I receive?',
  '9. How can I redeem my coupons and for how long are they valid?',
  '10. How to link my bank account or UPI ID with Nearlikes account?',
];
List<String> answers = [
  'You can download the Nearlikes app onto your mobile using play store.',
  'Once you download the app, you enter your mobile number. Then, enter the OTP sent to your mobile number. Enter your user name and then link your Instagram account to your Nearlikes account. The registration process is then complete and you will be redirected to your dashboard.',
  'The registration process is absolutely free. On the contrary you will receive rewards for signing up. This offer is only limited to the first 100 customers.',
  'Once you enter your user name, the app asks you to link to your Instagram account. Click on the connect to instagram bar and enter your account name. Our app will successfully link your accounts.',
  'Your Instagram should have a minimum of 300 followers and you should be a social media enthusiast. You should be willing to share stories about your favourite brands and you should be able to pump up your stories to receive more shares, likes and views.',
  'Select a brand of your choice and pick up a media file (either image or video) from the brand’s gallery. Post this as your story. You need to post one story of one brand on a daily basis. There is no option of posting multiple stories or using multiple brands per day.',
  'Use the #nearlikes on all your stories and get creative with your story visuals. Choose from various instagram features and create a stunning story that invites more likes, shares and views.',
  'You will first receive an instant reward after registering (exciting offers awaiting the first 100 customers).After you have posted your story, our AI will track analytics that cover your story’s likes, shares and views. You will be rewarded with instant cash prizes that will be transferred to your bank account and you will win exciting offers and deals from your favourite brands.',
  '''A)You can redeem your coupons in two ways:
It can be done at the business premise of the brand
Or
It can be redeemed by clicking the link which you will receive on your phone.
The coupons have a validity of one week. Redeem them before the validity expires.
You can redeem as many coupons as you can collect before the end of validity. ''',
  '''
After you post your first story and you receive cash rewards, you will be redirected to the account screen. Here you can choose any one of two options:
1.You can link your bank account by submitting your account number and IFSC code.
2.You can link to your UPI account by adding your UPI ID.
''',
];

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 90)
              .copyWith(bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyBackButton(),
              Logo.small(),
              SizedBox(height: size.height.twoPercent),
              Text(
                "FAQ",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: kTextColor[300],
                ),
              ),
              SizedBox(height: size.height.fivePercent),
              SizedBox(
                height: size.height.seventyPercent,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount: questions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ExpansionTile(
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          questions[index],
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      children: <Widget>[
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              answers[index],
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: kTextColor[300],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
