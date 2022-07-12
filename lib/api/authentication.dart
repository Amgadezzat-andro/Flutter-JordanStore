import 'package:generalshop/customer/user.dart';
import 'package:generalshop/exceptions/login_failed.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'api_util.dart';
import 'dart:convert';
import 'package:generalshop/exceptions/exceptions.dart';

class Authentication {
  // define headers to make all what come are json
  Map<String, String> headers = {'Accept': 'application/json'};

  Future<User> reigster(String first_name, String last_name, String email,
      String password) async {
    // checking internet Connection
    await checkInternet();

    // define body with the needed info
    Map<String, String> body = {
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'password': password
    };

    // convert path to uri
    Uri url = Uri.parse(ApiUtil.AUTH_REGISTER);

    // Wait for response by posting request defining path , headers , body
    http.Response response = await http.post(url, headers: headers, body: body);

    switch (response.statusCode) {
      case 201: // Success User Registered

        // body is text but in json form so we need to convert it to json
        var body = json.decode(response.body);

        // get data from body
        var data = body['data'];

        // make user with passing json object
        User user = User.fromJson(data);

        return user;

        break;
      case 422:
        throw UnproccedEntity();
        break;
      default:
        return null;
        break;
    }
  }

  Future<User> login(String email, String password) async {
    await checkInternet();

    Map<String, String> body = {'email': email, 'password': password};

    Uri url = Uri.parse(ApiUtil.AUTH_LOGIN);

    http.Response response = await http.post(url, headers: headers, body: body);

    switch (response.statusCode) {
      case 200:
        var body = jsonDecode(response.body);
        print(body);
        var data = body['data'];
        User user = User.fromJson(data);
        await _saveUser(user.user_id, user.api_token);
        return user;
        break;
      case 404:
        throw ResourceNotFound('User');
        break;
      case 401:
        throw LoginFailed();
        break;
      case 422:
        throw UnproccedEntity();
        break;
      default:
        return null;
    }
  }

  Future<void> _saveUser(int userId, String apiToken) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('user_id', userId);
    sharedPreferences.setString('api_token', apiToken);
  }
}
