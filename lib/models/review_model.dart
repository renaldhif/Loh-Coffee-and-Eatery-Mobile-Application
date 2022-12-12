import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class ReviewModel extends Equatable {
  final String id;
  final String? name;
  final String? email;
  final String review;
  final double rating;
  final Timestamp timestamp;

  const ReviewModel({
    required this.id,
    required this.name,
    required this.email,
    required this.review,
    required this.rating,
    required this.timestamp,
  });

  factory ReviewModel.fromJson(String id, Map<String, dynamic> json) {
    return ReviewModel(
      id: id,
      name: json['name'],
      email: json['email'],
      review: json['review'],
      rating: json['rating'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'review': review,
      'rating': rating,
      'timestamp': timestamp,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        review,
        rating,
        timestamp,
      ];
}
