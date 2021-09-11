import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static Future _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Cannot Launch $url");
    }
  }

  static Future openLink({required String url}) => _launchUrl(url);

  static Future openWhatsapp() async {
    const String url = 'https://wa.me/+919392708293';
    await _launchUrl(url);
  }

  static Future openMail() async {
    // final String sub =
    //     subject == null ? '' : "subject=${Uri.encodeFull(subject)}";
    // final String bod = body == null ? '' : "body=${Uri.encodeFull(body)}";
    // final String parameter = (sub == '' && bod == '') ? '' : '?$sub&$bod';
    // final String url = "mailto:$mail$parameter";

    const String mail = 'support@nearlikes.com';
    const String url = "mailto:$mail";

    await _launchUrl(url);
  }

  static Future openCall() async {
    const String url = 'tel:+919392708293';
    await _launchUrl(url);
  }
}
