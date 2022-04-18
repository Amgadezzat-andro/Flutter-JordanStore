// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'onboarding_model.dart';
import 'package:generalshop/screens/utilities/size_config.dart';

class SingleOnBoarding extends StatelessWidget {
  //const SingleOnBoarding({Key? key})// : super(key: key);
  final OnBoardingModel onBoardingModel;
  SingleOnBoarding(this.onBoardingModel);

  ScreenConfig screenConfig;
  WidgetSize widgetSize;

  @override
  Widget build(BuildContext context) {

    screenConfig = ScreenConfig(context);
    widgetSize = WidgetSize(screenConfig);

    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.35,
          child: Image(
            fit: BoxFit.cover,
            image: ExactAssetImage(onBoardingModel.image),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          onBoardingModel.title,
          style: TextStyle(
            fontSize: widgetSize.titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 22, right: 22),
          child: Text(
            onBoardingModel.description,
            textAlign: TextAlign.center,
            style: TextStyle(
                height: 1.5,
                fontSize: widgetSize.descriptionFontSize,
                fontWeight: FontWeight.w400,
                color: Colors.blueGrey),
          ),
        ),
      ],
    );
  }
}
