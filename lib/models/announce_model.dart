import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AnnounceModel extends Equatable {
  final String id;
  final String title;
  final String announce;
  final String dateAvail;
  final String? image;
  final Timestamp timestamp;

  const AnnounceModel({
    required this.id,
    required this.title,
    required this.announce,
    required this.dateAvail,
    this.image,
    required this.timestamp,
  });

  factory AnnounceModel.fromJson(String id, Map<String, dynamic> json) {
    return AnnounceModel(
      id: id,
      title: json['title'],
      announce: json['announce'],
      dateAvail: json['dateAvail'],
      image: json['image'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'announce': announce,
      'dateAvail': dateAvail,
      'image': image,
      'timestamp': timestamp,
    };
  }

  @override
  List<Object?> get props => [
    id,
    title,
    announce,
    dateAvail,
    image,
    timestamp,
  ];
}
