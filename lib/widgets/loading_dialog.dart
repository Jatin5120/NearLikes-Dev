import 'package:flutter/material.dart';
import 'package:nearlikes/constants/constants.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key})
      : label = '',
        super(key: key);

  const LoadingDialog.withText(this.label, {Key? key}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height.tenPercent,
      child: Dialog(
        insetPadding: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kSecondaryColor),
                ),
                SizedBox(width: size.width.fivePercent),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
