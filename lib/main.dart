// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:generalshop/product/product.dart';
import 'api/authentication.dart';
import 'api/products_api.dart';
import 'api/helpers_api.dart';
import 'product/product_category.dart';
import 'product/product_tag.dart';
import 'utility/country.dart';
import 'utility/country_city.dart';
import 'utility/country_state.dart';

void main() {
  runApp(GeneralShop());
}

class GeneralShop extends StatefulWidget {
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
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HelpersApi helpersApi = HelpersApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GeneralShop'),
      ),
      body: FutureBuilder(
        future: helpersApi.fetchStates(3,2),
        builder: (BuildContext context, AsyncSnapshot snapShot) {
          switch (snapShot.connectionState) {
            case ConnectionState.none:
              return _error('nothing happend');
              break;
            case ConnectionState.waiting:
              return _loading();
              break;
            case ConnectionState.active:
              return _loading();
              break;
            case ConnectionState.done:
              if (snapShot.hasError) {
                return _error(snapShot.error.toString());
              } else {
                if (!snapShot.hasData) {
                  return _error('no data');
                } else {
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int position) {
                      return _drawCard(snapShot.data[position]);
                    },
                    itemCount: snapShot.data.length,
                  );
                }
              }

              break;
          }
          return Container();
        },
      ),
    );
  }

  _drawCard(dynamic item) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(item.state_name),

      ),
    );
  }

  _drawProduct(Product product) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(product.product_title),
            (product.images.length > 0)
                ? Image(
                    image: NetworkImage(
                      product.images[0],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  _error(String error) {
    return Container(
      child: Center(
        child: Text(error),
      ),
    );
  }

  _loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
