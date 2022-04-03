import 'package:generalshop/exceptions/exceptions.dart';

class ProductTag {
  int tag_id;
  String tag_name;
  ProductTag(this.tag_id, this.tag_name);

  ProductTag.fromJson(Map<String, dynamic> jsonObject) {
    if (jsonObject['tag_id'] == null) {
      throw PropertyRequired('Tag Id');
    }
    if (jsonObject['tag_name'] == null) {
      throw PropertyRequired('Tag Name');
    }

    this.tag_id = jsonObject['tag_id'];
    this.tag_name = jsonObject['tag_name'];
  }
}
