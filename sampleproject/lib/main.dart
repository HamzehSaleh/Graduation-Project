// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sampleproject/User/screens/chargingPoints/MapPage.dart';
import 'package:sampleproject/features/splash/presentation/splash.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';
import 'package:sampleproject/sharedPrefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'splash.dart';

SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey:
          "AAAAfEJLHTk:APA91bGXZ6ux_SEvLmlko8ZQn-52T7s3NwJbs0sX2ECNdfPa9AhuRZFuL_9g9QCW4fyFciEUwQbpWZlvRVAtYhrLsNQCYcFCugUXs_9Ba87HTyRVZs6UVlTJ_ab1WCktJgiSXwntQNYn",
      appId: "1:533688163641:android:98776ad2dc7fb6251b9ce8",
      messagingSenderId: "533688163641",
      projectId: "gradproj1-a52b5",
    ),
  );
  // await Firebase.initializeApp();
  runApp(MyApp());
  prefs = await SharedPreferences.getInstance();
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          //    AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [Locale("ar", "AE")],
        locale: Locale("ar", "AE"),
        // home: MapPage());
        home: splashClass());
  }
}
