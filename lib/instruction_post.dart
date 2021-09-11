import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructionPost extends StatefulWidget {
  const InstructionPost({Key? key}) : super(key: key);

  @override
  _InstructionPostState createState() => _InstructionPostState();
}

class _InstructionPostState extends State<InstructionPost> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(
            'Post Story-Help',
            style: GoogleFonts.roboto(),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: const [
                Texts(txt1: 'Step 1', txt2: 'Select on post a story'),
                Imagess(images: "assets/p22.png"),
                Texts(txt1: 'Step 2', txt2: 'Select a brand '),
                Imagess(images: "assets/p23.jpg"),
                Texts(txt1: 'Step 3', txt2: 'Select media '),
                Imagess(images: "assets/p24.jpg"),
                Texts(
                    txt1: 'Step 4',
                    txt2:
                        'Post a Creative story to win exclusive coupons and rewards.  '),
                Imagess(images: "assets/p25.jpg"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Imagess extends StatelessWidget {
  final String images;
  const Imagess({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Material(
        elevation: 15,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Container(
          height: 400,
          width: 280,
          child: Image(
            image: AssetImage(images),
            fit: BoxFit.contain,
          ),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
        ),
      ),
    );
  }
}

class Texts extends StatelessWidget {
  final String txt1;
  final String txt2;
  const Texts({Key? key, required this.txt1, required this.txt2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$txt1: ',
              style: GoogleFonts.poppins(
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87),
            ),
            Text(
              txt2,
              maxLines: 3,
              softWrap: true,
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Colors.red.shade500,
                  fontWeight: FontWeight.w500),
              //  style: TextStyle(fontSize: 20, color: Colors.black54),
            ),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
