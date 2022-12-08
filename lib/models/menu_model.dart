import 'package:equatable/equatable.dart';

class MenuModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final List<String> tag;
  final String price;
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
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    tag,
    price,
    totalLoved,
    totalOrdered,
  ];
}
