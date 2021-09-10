import 'package:flutter/material.dart';
import 'package:nearlikes/constants/constants.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key})
      : isSmall = false,
        super(key: key);

  Logo.small({Key? key})
      : isSmall = true,
        super(key: key);

  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double imageSize =
        isSmall ? size.width.fifteenPercent : size.width.twentyPercent;
    return SizedBox(
      height: imageSize,
      width: imageSize,
      child: Image.asset('assets/logo.png'),
    );
  }
}
