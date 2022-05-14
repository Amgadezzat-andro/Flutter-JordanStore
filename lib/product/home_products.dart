// ignore_for_file: prefer_final_fields, non_constant_identifier_names, prefer_initializing_formals

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:generalshop/contracts/contracts.dart';
import 'package:generalshop/api/products_api.dart';
import 'package:generalshop/api/helpers_api.dart';
import 'package:generalshop/product/product.dart';

class HomeProductBloc implements Disposable {
  
  List<Product> products;
  ProductsApi productsApi;

  final StreamController<List<Product>> _productController =
      StreamController<List<Product>>.broadcast();

  final StreamController<int> _categoryController =
      StreamController<int>.broadcast();

  // OUTPUT THE DATA FROM PRODUCT CONTROLLER
  Stream<List<Product>> get productsStream => _productController.stream;

  //INPUT THE ID FOR CATEGORY CONTROLLER
  StreamSink<int> get fetchProducts => _categoryController.sink;

  //OUTPUT THE ID FROM CATEGORY CONTROLLER
  Stream<int> get category => _categoryController.stream;

  int categoryID;

  HomeProductBloc() {
    //  this.categoryID = categoryID;
    this.products = [];
    productsApi = ProductsApi();
    _productController.add(this.products);
    _categoryController.add(this.categoryID);
    _categoryController.stream.listen(_fetchCategoriesFromApi);
  }

  Future<void> _fetchCategoriesFromApi(int category) async {
    //API
    this.products = await productsApi.fetchProductsByCategory(category, 1);
    _productController.add(this.products);
    //print(products[0].product_id);
    //Update Products
    // print(category);
  }

  @override
  void dispose() {
    _productController.close();
    _categoryController.close();
  }


}
