import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import '../models/review_model.dart';
import '../services/review_service.dart';
part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(ReviewInitial());

  void addReview({
    required String? name,
    required String? email,
    required String review,
    required double rating,
    required Timestamp timestamp,
  }) async {
    try {
      emit(ReviewLoading());
      ReviewModel reviews = await ReviewService().addReview(
        name: name,
        email: email,
        review: review,
        rating: rating,
        timestamp: timestamp,
      );
      emit(ReviewSuccess([reviews]));
    } catch (e) {
      emit(ReviewFailed(e.toString()));
    }
  }

  void getReviews() async {
    try {
      emit(ReviewLoading());
      List<ReviewModel> reviews = await ReviewService().getReviews();
      emit(ReviewSuccess(reviews));
    } catch (e) {
      emit(ReviewFailed(e.toString()));
    }
  }

}
