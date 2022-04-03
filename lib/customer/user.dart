// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:generalshop/exceptions/exceptions.dart';

class User {
  int user_id;
  String first_name;
  String last_name;
  String email;
  String api_token;
  // []  means optional
  User(this.first_name, this.last_name, this.email,
      [this.api_token, this.user_id]);

  User.fromJson(Map<String, dynamic> jsonObject) {
    assert( jsonObject['user_id'] != null, 'User Id is Null' );
    assert( jsonObject['first_name'] != null, 'First Name is Null' );
    assert( jsonObject['last_name'] != null, 'Last Name is Null' );
    assert( jsonObject['email'] != null, 'Email is Null' );
    assert( jsonObject['api_token'] != null, 'Api Token is Null' );

    if( jsonObject['user_id'] == null ){
      throw PropertyRequired('User ID');
    }
    if( jsonObject['first_name'] == null ){
      throw PropertyRequired('First Name');
    }
    if( jsonObject['last_name'] == null ){
      throw PropertyRequired('Last Name');
    }
    if( jsonObject['email'] == null ){
      throw PropertyRequired('Email');
    }
    if( jsonObject['api_token'] == null ){
      throw PropertyRequired('API Token');
    }

    this.user_id = jsonObject['user_id'];
    this.first_name = jsonObject['first_name'];
    this.last_name = jsonObject['last_name'];
    this.email = jsonObject['email'];
    this.api_token = jsonObject['api_token'];
  }
}
