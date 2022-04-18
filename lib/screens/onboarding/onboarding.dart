// ignore_for_file: deprecated_member_use
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utilities/size_config.dart';
import 'onboarding_model.dart';
import 'onboarding_screen.dart';
import 'package:generalshop/screens/utilities/screen_utilites.dart';
import 'package:generalshop/screens/homepage.dart';

class OnBoarding extends StatefulWidget {
  //const OnBoarding({ Key? key }) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  double screenWidth;
  double screenHeigth;
  int currentIndex = 0;
  bool lastPage = false;

  PageController _pageController;

  List<OnBoardingModel> screens = [
    OnBoardingModel(
      image: "assets/images/onboarding1.jpg",
      title: "Welcome !",
      description:
          " Maxime mollitia molestiae quas vel sint commodi repudiandae consequuntur voluptatum. ",
    ),
    OnBoardingModel(
      image: "assets/images/onboarding2.jpg",
      title: "Add to Cart",
      description:
          " Maxime mollitia molestiae quas vel sint commodi repudiandae consequuntur voluptatum. ",
    ),
    OnBoardingModel(
      image: "assets/images/onboarding3.jpg",
      title: "Enjoy Purchase",
      description:
          " Maxime mollitia molestiae quas vel sint commodi repudiandae consequuntur voluptatum. ",
    ),
  ];

  ScreenConfig screenConfig;
  WidgetSize widgetSize;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenConfig = ScreenConfig(context);
    widgetSize = WidgetSize(screenConfig);

    screenHeigth = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    double _mt = MediaQuery.of(context).size.height * 0.2;
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.only(top: _mt),
              color: Colors.white,
              height: screenHeigth,
              width: screenWidth,
              child: PageView.builder(
                controller: _pageController,
                itemCount: screens.length,
                itemBuilder: (BuildContext context, int position) {
                  return SingleOnBoarding(screens[position]);
                },
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                    if (index == screens.length - 1) {
                      lastPage = true;
                    } else {
                      lastPage = false;
                    }
                  });
                },
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, -(screenHeigth * 0.15)),
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _drawDots(screens.length),
              ),
            ),
          ),
          (lastPage) ? _showButton() : Container(),
        ],
      ),
    );
  }

  Widget _showButton() {
    double offset = (screenConfig.screenType == ScreenType.SMALL) ? 0.05 : 0.1;

    return Container(
      child: Transform.translate(
        offset: Offset(0, -(screenHeigth * offset)),
        child: SizedBox(
          width: screenWidth * 0.75,
          height: widgetSize.buttonHeight,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(34),
            ),
            color: ScreenUtilities.mainBlue,
            onPressed: () async {
              var pref = await SharedPreferences.getInstance();
              pref.setBool('is_seen', true);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            child: Text(
              'Start',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: widgetSize.buttonFontSize,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _drawDots(int qty) {
    List<Widget> widgets = [];
    for (int i = 0; i < qty; i++) {
      widgets.add(
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: (i == currentIndex)
                ? ScreenUtilities.mainBlue
                : ScreenUtilities.lightGrey,
          ),
          width: widgetSize.pagerDotsWidth,
          height: widgetSize.pagerDotsHeight,
          margin: (i == qty)
              ? EdgeInsets.only(right: 0)
              : EdgeInsets.only(right: 24),
        ),
      );
    }
    return widgets;
  }
}
