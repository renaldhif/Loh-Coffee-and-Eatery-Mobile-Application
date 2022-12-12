part of 'review_cubit.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object> get props => [];
}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewSuccess extends ReviewState {
  final List<ReviewModel> reviews;

  ReviewSuccess(this.reviews);

  @override
  List<Object> get props => [reviews];
}

class ReviewFailed extends ReviewState {
  final String error;

  ReviewFailed(this.error);

  @override
  List<Object> get props => [error];
}