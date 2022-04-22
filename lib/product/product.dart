import 'package:generalshop/exceptions/exceptions.dart';
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
    assert(jsonObject['product_id'] != null, 'Product ID is null');
    assert(jsonObject['product_title'] != null, 'Product Title is null');
    assert(jsonObject['product_description'] != null, 'Product DESC is null');
    assert(jsonObject['product_price'] != null, 'Product Price is null');

    if (jsonObject['product_id'] == null) {
      throw PropertyRequired('Product ID');
    }

    if (jsonObject['product_title'] == null) {
      throw PropertyRequired('Product Title');
    }
    if (jsonObject['product_description'] == null) {
      throw PropertyRequired('Product Description');
    }

    if (jsonObject['product_price'] == null) {
      throw PropertyRequired('Product Price');
    }
    this.product_id = jsonObject['product_id'];
    this.product_title = jsonObject['product_title'];
    this.product_description = jsonObject['product_description'];
    this.product_price = double.tryParse(jsonObject['product_price']);
    this.product_discount = double.tryParse(jsonObject['product_discount']);
    this.product_total = double.tryParse(jsonObject['product_total']);
    this.productCategory =
        ProductCategory.fromJson(jsonObject['product_category']);

    this.tags = [];
    if (jsonObject['product_tags'] != null) {
      _setTags(jsonObject['product_tags']);
    }

    this.images = [];
    if (jsonObject['product_images'] != null) {
      _setImages(jsonObject['product_images']);
    }

    this.reviews = [];
    if (jsonObject['product_reviews'] != null) {
      _setReviews(jsonObject['product_reviews']);
    }
  }

  void _setReviews(List<dynamic> jsonReviews) {
    if (jsonReviews.length > 0) {
      for (var item in jsonReviews) {
        if (item != null) {
          this.reviews.add(ProductReview.fromJson(item));
        }
      }
    }
  }

  void _setTags(List<dynamic> jsonTags) {
    if (jsonTags.length > 0) {
      for (var item in jsonTags) {
        if (item != null) {
          tags.add(ProductTag.fromJson(item));
        }
      }
    }
  }

  void _setImages(List<dynamic> jsonImages) {
    if (jsonImages.length > 0) {
      for (var image in jsonImages) {
        if (image != null) {
          this.images.add(image['image_url']);
        }
      }
    }
  }

  String featuredImage() {
    if (this.images.length > 0) {
      return this.images[0];
    }
    return 'https://skillz4kidzmartialarts.com/wp-content/uploads/2017/04/default-image.jpg';
  }
}
