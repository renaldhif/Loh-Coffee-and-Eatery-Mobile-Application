import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/review_model.dart';

class ReviewService{
  final CollectionReference _reviewCollection = FirebaseFirestore.instance.collection('reviews');

  // add review from add review page
  Future<ReviewModel> addReview({
    required String? name,
    required String? email,
    required String review,
    required double rating,
    required Timestamp timestamp,
  }) async {
    try {
      _reviewCollection.add({
        'name' : name,
        'email' : email,
        'review' : review,
        'rating' : rating,
        'timestamp' : timestamp,
      });
      return ReviewModel(
        id: '',
        name: name,
        email: email,
        review: review,
        rating: rating,
        timestamp: timestamp,
      );
    } catch (e) {
      throw e;
    }
  }

  // get review from review page
  Future<List<ReviewModel>> getReviews() async {
    try {
      QuerySnapshot querySnapshot = await _reviewCollection.get();
      List<ReviewModel> reviews = querySnapshot.docs.map((e) {
        return ReviewModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      }).toList();
    
      return reviews;
    } catch (e) {
      throw e;
    }
  }
}