import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nearlikes/brand_stories.dart';
import 'package:nearlikes/controllers/controllers.dart';
import 'package:nearlikes/onboarding.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:nearlikes/page_guide.dart';

import 'globals.dart' as globals;
import 'select_brand.dart';
import 'splash_screen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  globals.appNaviagtor = GlobalKey<NavigatorState>();
  initializeControllers();
  runApp(GetMaterialApp(
    navigatorKey: globals.appNaviagtor,
    debugShowCheckedModeBanner: false,
    home: const Nearlikes(),
  ));
}

initializeControllers() {
  Get.lazyPut(() => StoryController());
}

class Nearlikes extends StatefulWidget {
  const Nearlikes({Key? key}) : super(key: key);

  @override
  _NearlikesState createState() => _NearlikesState();
}

class _NearlikesState extends State<Nearlikes> {
  @override
  void initState() {
    super.initState();
    configOneSignel();
  }

  void configOneSignel() async {
    //Remove this method to stop OneSignal Debugging
    await OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    await OneSignal.shared.setAppId("ab283812-2228-42c6-aed8-54f61ccb8f04");
    //     .whenComplete(() async {
    //   print('inside the getPlayerId');
    //   final status = await OneSignal.shared.getDeviceState();
    //   final String osUserID = status.userId;
    //   print('the player id is $osUserID');
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   await prefs.setString('playerId', osUserID).then((value) =>
    //       print('job done $value'));
    // });
  }

  @override
  Widget build(BuildContext context) {
    // return const PageGuide();
    return const SplashScreen();
  }
}
