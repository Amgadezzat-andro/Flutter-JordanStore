// ignore_for_file: unnecessary_this, constant_identifier_names, prefer_initializing_formals

import 'package:flutter/material.dart';

enum ScreenType { SMALL, MEDIUM, LARGE }

class ScreenConfig {
  BuildContext context;

  double screenWidth;
  double screenHeight;
  ScreenType screenType;

  ScreenConfig(this.context) {
    this.screenWidth = MediaQuery.of(context).size.width;
    this.screenHeight = MediaQuery.of(context).size.height;
    _setScreen();
  }

  void _setScreen() {
    if (this.screenWidth >= 320 && this.screenWidth < 375) {
      this.screenType = ScreenType.SMALL;
    }
    if (this.screenWidth >= 375 && this.screenWidth < 414) {
      this.screenType = ScreenType.MEDIUM;
    }
    if (this.screenWidth >= 414) {
      this.screenType = ScreenType.LARGE;
    }
  }
}

class WidgetSize {
  double titleFontSize;
  double descriptionFontSize;
  double pagerDotsWidth;
  double pagerDotsHeight;
  ScreenConfig screenConfig;
  double buttonHeight;
  double buttonFontSize;

  WidgetSize(ScreenConfig screenConfig) {
    this.screenConfig = screenConfig;
    _init();
  }

  void _init() {
    switch (this.screenConfig.screenType) {
      case ScreenType.SMALL:
        this.titleFontSize = 16;
        this.descriptionFontSize = 14;
        this.pagerDotsWidth = 25;
        this.pagerDotsHeight = 4;
        this.buttonFontSize = 16;
        this.buttonHeight = 40;

        break;
      case ScreenType.MEDIUM:
        this.titleFontSize = 28;
        this.descriptionFontSize = 20;
        this.pagerDotsWidth = 35;
        this.pagerDotsHeight = 6;
        this.buttonFontSize = 22;
        this.buttonHeight = 60;

        break;
      case ScreenType.LARGE:
        this.titleFontSize = 28;
        this.descriptionFontSize = 20;
        this.pagerDotsWidth = 35;
        this.pagerDotsHeight = 6;
        this.buttonFontSize = 22;
        this.buttonHeight = 60;

        break;
      default:
        this.titleFontSize = 28;
        this.descriptionFontSize = 20;
        this.pagerDotsWidth = 35;
        this.pagerDotsHeight = 6;
        this.buttonFontSize = 22;
        this.buttonHeight = 60;

        break;
    }
  }
}
