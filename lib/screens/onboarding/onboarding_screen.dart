// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'onboarding_model.dart';

class SingleOnBoarding extends StatelessWidget {
  //const SingleOnBoarding({Key? key})// : super(key: key);
  final OnBoardingModel onBoardingModel;

  SingleOnBoarding(this.onBoardingModel);
  @override
  Widget build(BuildContext context) {
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
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 22,right: 22),
          child: Text(
            onBoardingModel.description,
            textAlign: TextAlign.center,
            style: TextStyle(
                height: 1.5,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.blueGrey),
          ),
        ),
      ],
    );
  }
}
