import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:loh_coffee_eatery/models/menu_model.dart';
import 'package:loh_coffee_eatery/models/payment_model.dart';
import 'package:loh_coffee_eatery/models/table_model.dart';
import 'package:loh_coffee_eatery/models/user_model.dart';

class OrderModel extends Equatable{
  // final String id;
  final int number;
  final UserModel user;
  final List<MenuModel> menu;
  final int tableNum;
  late final PaymentModel payment;
  final String orderStatus;
  final Timestamp orderDateTime;

  OrderModel({
    // required this.id,
    required this.number,
    required this.user,
    required this.menu,
    required this.tableNum,
    required this.payment,
    required this.orderStatus,
    required this.orderDateTime,
  });

  // factory OrderModel.fromJson(String id, Map<String, dynamic> json) {
  //   return OrderModel(
  //     id: id,
  //     user: UserModel.fromJson(id, json['user']),
  //     number: json['number'],
  //     menu: List<MenuModel>.from(json['menu'].map((x) => MenuModel.fromJson(id, x))),
  //     tableNum: json['tableNum'],
  //     payment: PaymentModel.fromJson(id, json['payment']),
  //     orderStatus: json['orderStatus'],
  //     orderDateTime: json['orderDateTime'],
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'user': user.toJson(),
  //     'number': number,
  //     'menu': List<dynamic>.from(menu.map((x) => x.toJson())),
  //     'tableNum': tableNum,
  //     'payment': payment.toJson(),
  //     'orderStatus': orderStatus,
  //     'orderDateTime': orderDateTime,
  //   };
  // }


  @override
  // TODO: implement props
  List<Object?> get props => [
    // id,
    number,
    user,
    menu,
    tableNum,
    payment,
    orderStatus,
    orderDateTime,
  ];

}