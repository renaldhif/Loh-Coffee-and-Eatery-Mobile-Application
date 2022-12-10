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
    this.totalLoved = 0,
    this.totalOrdered = 0
    // required this.totalLoved,
    // required this.totalOrdered,
  });

  factory MenuModel.fromJson(String id, Map<String, dynamic> json) {
    return MenuModel(
      id: id,
      title: json['title'],
      description: json['description'],
      tag: json['tag'],
      price: json['price'],
      image: json['image'],
      totalLoved: json['totalLoved'],
      totalOrdered: json['totalOrdered'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'tag': tag,
      'price': price,
      'image': image,
      'totalLoved': totalLoved,
      'totalOrdered': totalOrdered,
    };
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
