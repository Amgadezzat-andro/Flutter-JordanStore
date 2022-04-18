// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'screens/onboarding/onboarding.dart';
import 'screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/utilities/size_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var pref = await SharedPreferences.getInstance();
  bool isSeen = pref.getBool('is_seen');
  Widget homePage = HomePage();
  if (isSeen == null || !isSeen) {
    homePage = OnBoarding();
  }
  runApp(GeneralShop(homePage));
}

class GeneralShop extends StatelessWidget {
  //const GeneralShop({Key? key}) : super(key: key);

  final Widget homePage;
  GeneralShop(this.homePage);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'General Shop',
      home: homePage,
      debugShowCheckedModeBanner: false,
    );
  }
}
