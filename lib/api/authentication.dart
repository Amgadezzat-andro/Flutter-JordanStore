import 'package:generalshop/customer/user.dart';
import 'package:http/http.dart' as http;
import 'api_util.dart';
import 'dart:convert';

class Authentication {
  Future<User> reigster(String first_name, String last_name, String email,
      String password) async {
    // define headers to make all what come are json
    Map<String, String> headers = {'Accept': 'application/json'};

    // define body with the needed info
    Map<String, String> body = {
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'password': password
    };

    // convert path to uri
    Uri auth_register = Uri.parse(ApiUtil.AUTH_REGISTER);

    // Wait for response by posting request defining path , headers , body
    http.Response response =
        await http.post(auth_register, headers: headers, body: body);

    // check response
    if (response.statusCode == 201) {
      // Success User Registered

      // body is text but in json form so we need to convert it to json
      var body = json.decode(response.body);

      // get data from body
      var data = body['data'];

      // make user with passing json object
      User user = User.fromJson(data);

      return user;
    }
    return null;
  }

  Future<User> login(String email, String password) async {
    Map<String, String> headers = {'Accept': 'application/json'};
    Map<String, String> body = {'email': email, 'password': password};

    Uri auth_login = Uri.parse(ApiUtil.AUTH_LOGIN);

    
    http.Response response =
        await http.post(auth_login, headers: headers, body: body);

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var data = body['data'];
      print(data);
      return User.fromJson(data);
    }
    print(response.body);
    return null;
  }
}
