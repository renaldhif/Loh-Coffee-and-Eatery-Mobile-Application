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
  final int quantity;

  const MenuModel({
    required this.id,
    required this.title,
    required this.description,
    required this.tag,
    required this.price,
    required this.image,
    this.totalLoved = 0,
    this.totalOrdered = 0,
    this.quantity = 1});

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
      quantity: json['quantity']
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
      'quantity': quantity
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
    quantity
  ];

  MenuModel copyWith({required int quantity}) {
    return MenuModel(
      id: id,
      title: title,
      description: description,
      tag: tag,
      price: price,
      image: image,
      totalLoved: totalLoved,
      totalOrdered: totalOrdered,
      quantity: quantity
    );
  }

}
