// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:generalshop/screens/utilities/screen_utilites.dart';
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
      theme: ThemeData(
        textTheme: TextTheme(
          titleLarge: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: ScreenUtilities.textColor),
          titleMedium: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: ScreenUtilities.textColor),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: ScreenUtilities.textColor,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
          actionsIconTheme: IconThemeData(
            color: ScreenUtilities.textColor,
          ),
        ),
        primaryColor: Colors.white,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        tabBarTheme: TabBarTheme(
          labelColor: ScreenUtilities.textColor,
          labelStyle: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
          labelPadding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 12,
            top: 16,
          ),
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: ScreenUtilities.unselected,
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
