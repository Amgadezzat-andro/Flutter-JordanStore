// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'api/authentication.dart';

void main() {
  runApp(GeneralShop());
}

class GeneralShop extends StatefulWidget {
  //GeneralApp({Key? key}) : super(key: key);

  @override
  State<GeneralShop> createState() => _GeneralShopState();
}

class _GeneralShopState extends State<GeneralShop> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GeneralShop',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  // const HomePage({ Key key }) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Authentication authentication = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GeneralShop'),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            future: authentication.login('megostar59@gmail.com', '123456789'),
            builder: (context, snapShot) {
              return Center();
            },
          ),
        ),
      ),
    );
  }
}
