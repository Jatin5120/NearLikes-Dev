import 'package:flutter/material.dart';
import 'package:nearlikes/page_guide.dart';
import 'package:nearlikes/register.dart';
import 'package:nearlikes/setup_instructions.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:nearlikes/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart'as globals;
void main() async{
   // WidgetsFlutterBinding.ensureInitialized();
   // await Firebase.initializeApp();
   globals.appNaviagtor=GlobalKey<NavigatorState>();
   runApp(MaterialApp(
            navigatorKey: globals.appNaviagtor,
           debugShowCheckedModeBanner: false,
           home: Nearlikes()
       )
   );
}

class Nearlikes extends StatefulWidget {
  @override
  _NearlikesState createState() => _NearlikesState();
}

class _NearlikesState extends State<Nearlikes> {
  @override
  void initState() {
    super.initState();
    configOneSignel();
  }
  void configOneSignel()async
  {
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
    return SplashScreen();
  }
}


