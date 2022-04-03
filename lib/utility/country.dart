import 'package:generalshop/exceptions/exceptions.dart';

class Country {
  int country_id;
  String country_name;
  String captial;
  String currency;
  Country(this.country_id, this.country_name, this.captial, this.currency);

  Country.fromJson(Map<String, dynamic> jsonObject) {
    assert(jsonObject['country_id'] != null, 'Country ID is null');
    assert(jsonObject['country_name'] != null, 'Country Name is null');
    assert(jsonObject['currency'] != null, 'Country Currency is null');
    assert(jsonObject['capital'] != null, 'Country Capital is null');

    if (jsonObject['country_id'] == null) {
      throw PropertyRequired('Country ID');
    }

    if (jsonObject['country_name'] == null) {
      throw PropertyRequired('Country Name');
    }
    if (jsonObject['currency'] == null) {
      throw PropertyRequired('Currency');
    }
    if (jsonObject['capital'] == null) {
      throw PropertyRequired('Capital');
    }

    
    this.country_id = jsonObject['country_id'];
    this.country_name = jsonObject['country_name'];
    this.currency = jsonObject['currency'];
    this.captial = jsonObject['capital'];
  }
}
