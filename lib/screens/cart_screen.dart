// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:generalshop/api/cart_api.dart';
import 'package:generalshop/product/product.dart';
import 'package:generalshop/screens/utilities/helpers_widgets.dart';

import '../cart/cart.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartApi cartApi = CartApi();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.monetization_on),
        onPressed: () {
          //TODO GO TO CHECK OUT SCREEN
        },
      ),
      body: (isLoading)
          ? _showLoding()
          : FutureBuilder(
              future: cartApi.fetchCart(),
              builder: (BuildContext context, AsyncSnapshot<Cart> snapShot) {
                switch (snapShot.connectionState) {
                  case ConnectionState.none:
                    return Text('No Connection');
                    break;
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                    break;
                  case ConnectionState.done:
                    if (snapShot.hasError) {
                      return Text('error');
                    } else {
                      if (snapShot.hasData) {
                        return ListView.builder(
                          itemCount: snapShot.data.cartItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _drawProductRow(
                                snapShot.data.cartItems[index]);
                          },
                        );
                      } else {
                        return Text('no Data');
                      }
                    }
                    break;
                  default:
                    return Container();
                    break;
                }
                return Container();
              }),
    );
  }

  Widget _showLoding() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _drawProductRow(CartItem cartItem) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        cartItem.product.featuredImage(),
                      ),
                    ),
                  ),
                ),
                Text(cartItem.product.product_title),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await cartApi
                      .removeProductFromCart(cartItem.product.product_id);
                  setState(() {
                    isLoading = false;
                  });
                },
                icon: Icon(Icons.remove),
              ),
              Text(
                cartItem.qty.toString(),
              ),
              IconButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await cartApi.addProductToCart(cartItem.product.product_id);
                  setState(() {
                    isLoading = false;
                  });
                },
                icon: Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
