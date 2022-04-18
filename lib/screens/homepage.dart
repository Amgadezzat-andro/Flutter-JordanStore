// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:generalshop/screens/utilities/screen_utilites.dart';
import 'package:generalshop/screens/utilities/size_config.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScreenConfig screenConfig;

  @override
  Widget build(BuildContext context) {
    screenConfig = ScreenConfig(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Page',
          style: TextStyle(),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.teal,
      ),
    );
  }
}
