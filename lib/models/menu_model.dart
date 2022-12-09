import 'package:equatable/equatable.dart';

class MenuModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String tag;
  final int price;
  final String image;
  final int totalLoved;
  final int totalOrdered;

  const MenuModel({
    required this.id,
    required this.title,
    required this.description,
    required this.tag,
    required this.price,
    required this.image,
    required this.totalLoved,
    required this.totalOrdered,

    // this.totalLoved = 0,
    // this.totalOrdered = 0
  });

  factory MenuModel.fromJson(String id, Map<String, dynamic> json) {
    return MenuModel(
      id: id,
      title: json['title'],
      description: json['description'],
      tag: json['tag'],
      price: json['price'].toInt(),
      image: json['image'],
      totalLoved: json['totalLoved'].toInt(),
      totalOrdered: json['totalOrdered'].toInt(),
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    tag,
    price,
    image,
    totalLoved,
    totalOrdered,
  ];
}
