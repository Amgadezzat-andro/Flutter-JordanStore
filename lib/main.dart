// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:generalshop/product/product.dart';
import 'api/authentication.dart';
import 'api/products_api.dart';

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
  ProductsApi productsApi = ProductsApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GeneralShop'),
      ),
      body: FutureBuilder(
        future: productsApi.fetchProducts(1),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapShot) {
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
                      return _drawProduct(snapShot.data[position]);
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

  _drawProduct(Product product) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(product.product_title),
            (product.images.length>0) ?
            Image(
              image: NetworkImage(
                product.images[0],
              ),
            ):Container(),
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
