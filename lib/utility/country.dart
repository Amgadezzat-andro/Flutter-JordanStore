class Country {
  int country_id;
  String country_name;
  String captial;
  String currency;
  Country(this.country_id, this.country_name, this.captial, this.currency);

  Country.fromJson(Map<String, dynamic> jsonObject) {
    this.country_id = jsonObject['country_id'];
    this.country_name = jsonObject['country_name'];
    this.currency = jsonObject['currency'];
    this.captial = jsonObject['capital'];
  }
}
