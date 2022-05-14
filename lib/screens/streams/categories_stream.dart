import 'dart:async';

import 'package:flutter/material.dart';
import 'package:generalshop/api/helpers_api.dart';
import 'package:generalshop/product/product_category.dart';

import '../../contracts/contracts.dart';

class CategoriesStream implements Disposable {
  List<ProductCategory> categories;
  StreamController<List<ProductCategory>> _categoriesStream;

  Stream<List<ProductCategory>> get categoriesStream =>
      _categoriesStream.stream;
  StreamSink<List<ProductCategory>> get categoriesSink =>
      _categoriesStream.sink;

  HelpersApi helpersApi = HelpersApi();

  CategoriesStream() {
    _categoriesStream = StreamController<List<ProductCategory>>.broadcast(
        onListen: _fetchFirstTime);
    categories = [];
    _categoriesStream.add(categories);
    // _fetchCategories(categories);
    _categoriesStream.stream.listen(_fetchCategories);
  }

  Future<void> _fetchFirstTime() async {
    categories = await helpersApi.fetchCategories();
  }

  Future<void> _fetchCategories(List<ProductCategory> categories) async {
   this.categories = await helpersApi.fetchCategories();
    _categoriesStream.add(this.categories);
  }

  @override
  void dispose() {
    _categoriesStream.close();
  }
}
