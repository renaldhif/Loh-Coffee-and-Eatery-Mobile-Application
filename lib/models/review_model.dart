import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class ReviewModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String review;
  final int rating;
  final DateTime date;

  const ReviewModel({
    required this.id,
    required this.name,
    required this.email,
    required this.review,
    required this.rating,
    required this.date,
  });

  factory ReviewModel.fromJson(String id, Map<String, dynamic> json) {
    return ReviewModel(
      id: id,
      name: json['name'],
      email: json['email'],
      review: json['review'],
      rating: json['rating'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'review': review,
      'rating': rating,
      'date': date,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        review,
        rating,
        date,
      ];
}
