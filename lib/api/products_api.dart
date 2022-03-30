import 'api_util.dart';
import 'package:generalshop/product/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsApi {
  // define Headers
  Map<String, String> headers = {'Accept': 'application/json'};

  Future<List<Product>> fetchProducts(int page) async {
    // convert path to uri
    Uri api_products = Uri.parse(ApiUtil.PRODUCTS + '?page=' + page.toString());

    // make the request and have response
    http.Response response = await http.get(api_products, headers: headers);

    // define new list
    List<Product> products = [];

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      for (var item in body['data']) {
        // print(Product.fromJson(item));
        products.add(Product.fromJson(item));
      }
      return products;
    }

    return null;
  }

  Future<Product> fetchProduct(int product_id) async {
    Uri url = Uri.parse(ApiUtil.PRODUCT + product_id.toString());
    http.Response response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return Product.fromJson(body['data']);
    }
    return null;
  }



}
