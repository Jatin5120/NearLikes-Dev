import 'package:flutter/material.dart';
import 'package:nearlikes/constants/constants.dart';

import 'widgets.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TapHandler(
        onTap: () => Navigator.pop(context),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          child: Icon(
            Icons.arrow_back,
            color: kPrimaryColor,
            size: 30,
          ),
        ),
      ),
    );
  }
}
