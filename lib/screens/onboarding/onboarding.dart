// ignore_for_file: deprecated_member_use
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'onboarding_model.dart';
import 'onboarding_screen.dart';
import 'package:generalshop/screens/utilities/screen_utilites.dart';

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
    return Container(
      child: Transform.translate(
        offset: Offset(0, -(screenHeigth * 0.1)),
        child: SizedBox(
          width: screenWidth * 0.75,
          height: 60,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(34),
            ),
            color: ScreenUtilities.mainBlue,
            onPressed: () {},
            child: Text(
              'Start',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
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
          width: 35,
          height: 6,
          margin: (i == qty)
              ? EdgeInsets.only(right: 0)
              : EdgeInsets.only(right: 24),
        ),
      );
    }
    return widgets;
  }
}
