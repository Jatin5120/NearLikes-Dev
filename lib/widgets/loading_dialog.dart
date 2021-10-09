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
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: size.height.tenPercent,
          child: Center(
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: size.height.onePercent,
              children: [
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kSecondaryColor),
                ),
                SizedBox(width: size.width.fivePercent),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  softWrap: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
