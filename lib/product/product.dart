import 'package:generalshop/review/product_review.dart';

import 'product_category.dart';
import 'product_tag.dart';
import 'product_unit.dart';

class Product {
  int product_id;

  String product_title, product_description;

  ProductUnit productUnit;

  double product_price, product_total, product_discount;

  ProductCategory productCategory;

  List<ProductTag> tags;

  List<String> images;

  List<ProductReview> reviews;
  Product(
    this.product_id,
    this.product_title,
    this.product_description,
    this.productUnit,
    this.product_price,
    this.product_total,
    this.product_discount,
    this.productCategory,
    this.tags,
    this.images,
    this.reviews,
  );

  Product.fromJson(Map<String, dynamic> jsonObject) {
    this.product_id = jsonObject['product_id'];
    this.product_title = jsonObject['product_title'];
    this.product_description = jsonObject['product_description'];
    this.product_price = double.tryParse(jsonObject['product_price']);
    this.product_discount = double.tryParse(jsonObject['product_discount']);
    this.product_total = double.tryParse(jsonObject['product_total']);
    this.productCategory =
        ProductCategory.fromJson(jsonObject['product_category']);
    _setTags(jsonObject['product_tags']);
    _setImages(jsonObject['product_images']);
    _setReviews(jsonObject['product_reviews']);
  }

  void _setReviews(List<dynamic> jsonReviews) {
    this.reviews = [];
    if (jsonReviews.length > 0) {
      for (var item in jsonReviews) {
        if (item != null) {
          this.reviews.add(ProductReview.fromJson(item));
        }
      }
    }
  }

  void _setTags(List<dynamic> jsonTags) {
    this.tags = [];
    if (jsonTags.length > 0) {
      for (var item in jsonTags) {
        if (item != null) {
          tags.add(ProductTag.fromJson(item));
        }
      }
    }
  }

  void _setImages(List<dynamic> jsonImages) {
    images = [];
    if (jsonImages.length > 0) {
      for (var image in jsonImages) {
        if (image != null) {
          this.images.add(image['image_url']);
        }
      }
    }
  }
}
