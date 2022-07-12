import 'dart:convert';

import 'package:generalshop/api/api_util.dart';
import 'package:generalshop/cart/cart.dart';
import 'package:generalshop/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartApi {
// prepare the headers

  Future<Cart> fetchCart() async {
    await checkInternet();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.get('api_token');
    Map<String, String> authHeaders = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $apiToken',
    };
    print(apiToken);
    Uri url = Uri.parse(ApiUtil.CART);
    http.Response response = await http.get(url, headers: authHeaders);
    switch (response.statusCode) {
      case 200:
        var body = jsonDecode(response.body);
        return Cart.fromJson(body);
        break;
      default:
        throw ResourceNotFound('Cart');
        break;
    }
  }

  Future<bool> removeProductFromCart(int productID) async {
    await checkInternet();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.get('api_token');
    Uri url = Uri.parse(
        ApiUtil.REMOVE_FROM_CART + '/' + productID.toString() + '/remove');

    Map<String, String> authHeaders = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $apiToken',
    };

    Map<String, dynamic> body = {'product_id': productID.toString()};
    http.Response response =
        await http.post(url, headers: authHeaders, body: body);
    print(response.body);
    switch (response.statusCode) {
      case 200:
      case 201:
        return true;
        break;
      default:
        throw ResourceNotFound('Cart');
        break;
    }
  }

  Future<bool> addProductToCart(int productID) async {
    await checkInternet();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.get('api_token');
    Uri url = Uri.parse(ApiUtil.CART);

    Map<String, String> authHeaders = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $apiToken',
    };

    Map<String, dynamic> body = {
      'product_id': productID.toString(),
      'qty': 1.toString(),
    };
    http.Response response =
        await http.post(url, headers: authHeaders, body: body);

    switch (response.statusCode) {
      case 200:
      case 201:
        return true;
        break;
      default:
        throw ResourceNotFound('Cart');
        break;
    }
  }
}
