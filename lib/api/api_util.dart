// ignore_for_file: constant_identifier_names

import 'package:connectivity/connectivity.dart';
import 'package:generalshop/exceptions/exceptions.dart';

class ApiUtil {
// Define Api Routes
// static : means i dont need to make copy of class
// i can access it immediately

// LOCAL URLS
// CHANGE TO IT REAL URLs IN THE RELEASE

  static const String MAIN_API_URL = 'https://206e-197-63-251-130.ngrok.io/api/';

  static const String AUTH_REGISTER = MAIN_API_URL + 'auth/register/';

  static const String AUTH_LOGIN = MAIN_API_URL + 'auth/login/';

  static const String PRODUCTS = MAIN_API_URL + 'products';

  static const String PRODUCT = MAIN_API_URL + 'products/';

  static String CATEGORY_PRODUCT(int id, int page) {
    return MAIN_API_URL +
        'categories/' +
        id.toString() +
        '/products?page=' +
        page.toString();
  }

  static const String COUNTRIES = MAIN_API_URL + 'countries/';

  static String CITIES(int id) {
    return MAIN_API_URL + 'countries/' + id.toString() + '/cities';
  }

  static String STATES(int id) {
    return MAIN_API_URL + 'countries/' + id.toString() + '/states';
  }

  static const String CATEGORIES = MAIN_API_URL + 'categories';

  static const String TAGS = MAIN_API_URL + 'tags';
}

Future<void> checkInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  // I am not  connected to a mobile network or wifi.
  if (connectivityResult != ConnectivityResult.mobile &&
      connectivityResult != ConnectivityResult.wifi) {
    throw NoInternetConnection();
  }
}
