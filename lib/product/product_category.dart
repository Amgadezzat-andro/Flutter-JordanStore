import 'package:generalshop/exceptions/exceptions.dart';

class ProductCategory {
  int category_id;
  String category_name;
  String image_direction;
  String image_url;

  ProductCategory(this.category_id, this.category_name, this.image_direction,
      this.image_url);

  ProductCategory.fromJson(Map<String, dynamic> jsonObject) {
    assert(jsonObject['category_id'] != null, 'Category ID is Null');
    assert(jsonObject['category_name'] != null, 'Category Name is Null');
    assert(jsonObject['image_direction'] != null, 'Category Direction is Null');
    assert(jsonObject['image_url'] != null, 'Category URL is Null');

    if (jsonObject['category_id'] == null) {
      throw PropertyRequired('Category ID');
    }
    if (jsonObject['category_name'] == null) {
      throw PropertyRequired('Category Name');
    }
    if (jsonObject['image_direction'] == null) {
      throw PropertyRequired('Image Direction');
    }
    if (jsonObject['image_url'] == null) {
      throw PropertyRequired('Image URL');
    }
    this.category_id = jsonObject['category_id'];
    this.category_name = jsonObject['category_name'];
    this.image_direction = jsonObject['image_direction'];
    this.image_url = jsonObject['image_url'];
  }
}
