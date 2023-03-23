import 'package:equatable/equatable.dart';
import 'package:loh_coffee_eatery/models/user_model.dart';

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
  final List<String> userId;

  const MenuModel({
    required this.id,
    required this.title,
    required this.description,
    required this.tag,
    required this.price,
    required this.image,
    this.totalLoved = 0,
    this.totalOrdered = 0,
    this.quantity = 1,
    this.userId = const [],
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
        userId: List<String>.from(json['userId']),
        quantity: json['quantity']);
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
      'quantity': quantity,
      'userId' : userId,
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
        quantity,
        userId
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
      quantity: quantity,
      userId: userId,
    );
  }
}
