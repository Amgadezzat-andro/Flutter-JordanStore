// ignore_for_file: prefer_const_constructors, deprecated_member_use
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:generalshop/api/cart_api.dart';
import 'package:generalshop/product/product.dart';
import 'package:generalshop/screens/login.dart';
import 'package:generalshop/screens/utilities/screen_utilites.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingleProduct extends StatefulWidget {
  final Product product;

  SingleProduct(this.product);

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  CartApi cartApi = CartApi();
  bool _addingToCart = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.product_title),
      ),
      body: _drawScreen(context),
      floatingActionButton: FloatingActionButton(
        child: (_addingToCart)
            ? CircularProgressIndicator()
            : Icon(
                Icons.add_shopping_cart,
              ),
        onPressed: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          int userId = pref.getInt('user_id');
          if (userId == null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          } else {
            setState(() {
              _addingToCart = true;
            });
            await cartApi.addProductToCart(widget.product.product_id);
            setState(() {
              _addingToCart = false;
            });
            print(userId);
          }
        },
      ),
    );
  }

  Widget _drawScreen(BuildContext context) {
    return Stack(children: [
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
              child: _drawImageGallery(context),
            ),
            _drawTitle(context),
            _drawDetails(context),
          ],
        ),
      ),
      _drawLine(),
    ]);
  }

  Widget _drawImageGallery(BuildContext context) {
    return PageView.builder(
      itemCount: widget.product.images.length,
      itemBuilder: (context, int position) {
        return Container(
          padding: EdgeInsets.all(8.0),
          child: Image(
            fit: BoxFit.cover,
            image: NetworkImage(
              widget.product.images[position],
            ),
          ),
        );
      },
    );
  }

  Widget _drawTitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.product_title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  widget.product.productCategory.category_name,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${widget.product.product_price.toString()}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 16,
                ),
                (widget.product.product_discount > 0)
                    ? Text(
                        _calculateDiscount(),
                        style: Theme.of(context).textTheme.displayMedium,
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawDetails(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        widget.product.product_description,
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }

  String _calculateDiscount() {
    double discount = widget.product.product_discount;
    double price = widget.product.product_price;
    return (price * discount).toString();
  }

  Widget _drawLine() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Transform.translate(
        offset: Offset(0, -43),
        child: Container(
          margin: EdgeInsets.only(right: 20, left: 16),
          padding: EdgeInsets.only(left: 20),
          height: 1,
          color: ScreenUtilities.lightGrey,
        ),
      ),
    );
  }
}
