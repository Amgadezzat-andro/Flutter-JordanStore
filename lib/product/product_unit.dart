import 'dart:convert';

import 'package:generalshop/exceptions/exceptions.dart';

class ProductUnit {
  int unit_id;
  String unit_name, unit_code;

  ProductUnit(this.unit_id, this.unit_name, this.unit_code);

  ProductUnit.fromJson(Map<String, dynamic> jsonObject) {
    // you can use assert but assert is only for development
    assert(jsonObject['unit_id'] != null, 'Unit ID is null');
    assert(jsonObject['unit_name'] != null, 'Unit Name is null');
    assert(jsonObject['unit_code'] != null, 'Unit Code is null');

    if (jsonObject['unit_id'] == null) {
      throw PropertyRequired('Unit ID');
    }
    if (jsonObject['unit_name'] == null) {
      throw PropertyRequired('Unit Name');
    }
    if (jsonObject['unit_code'] == null) {
      throw PropertyRequired('Unit Code');
    }
    this.unit_id = jsonObject['unit_id'];
    this.unit_name = jsonObject['unit_name'];
    this.unit_code = jsonObject['unit_code'];
  }
}
