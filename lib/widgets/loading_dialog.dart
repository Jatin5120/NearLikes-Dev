import 'package:flutter/material.dart';
import 'package:nearlikes/constants/constants.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Dialog(
        insetPadding: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(kSecondaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
