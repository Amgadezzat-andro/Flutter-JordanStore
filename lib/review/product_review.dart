import 'reviewer.dart';
import 'package:generalshop/exceptions/exceptions.dart';

class ProductReview {
  int review_id;
  int stars;
  String review;
  Reviewer reviewer;

  ProductReview(this.review_id, this.stars, this.review, this.reviewer);
  ProductReview.fromJson(Map<String, dynamic> jsonObject) {
    assert(jsonObject['review_id'] != null, 'Review ID is Null');
    assert(jsonObject['stars'] != null, 'Stars is Null');
    assert(jsonObject['review'] != null, 'Review is Null');
    assert(jsonObject['reviewer'] != null, 'Reviewer is Null');

    if (jsonObject['review_id'] == null) {
      throw PropertyRequired('Review ID');
    }
       if (jsonObject['stars'] == null) {
      throw PropertyRequired('Stars');
    }
       if (jsonObject['review'] == null) {
      throw PropertyRequired('Review');
    }
       if (jsonObject['reviewer'] == null) {
      throw PropertyRequired('Reviewer');
    }

    this.review_id = jsonObject['review_id'];
    this.stars = jsonObject['stars'];
    this.review = jsonObject['review'];
    this.reviewer = Reviewer.fromJson(jsonObject['reviewer']);
  }
}
