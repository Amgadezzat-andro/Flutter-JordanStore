import 'dart:convert';

import 'package:generalshop/exceptions/exceptions.dart';

class CountryCity {
  int city_id;
  String city_name;
  CountryCity(this.city_name, this.city_id);

  CountryCity.fromJson(Map<String, dynamic> jsonObject) {
    assert(jsonObject['city_id'] != null, 'City ID is Null');
    assert(jsonObject['city_name'] != null, 'City Name is null');
    if (jsonObject['city_id'] == null) {
      throw PropertyRequired('City ID');
    }
    if (jsonObject['city_name'] == null) {
      throw PropertyRequired('City Name');
    }

    this.city_id = jsonObject['city_id'];
    this.city_name = jsonObject['city_name'];
  }
}
