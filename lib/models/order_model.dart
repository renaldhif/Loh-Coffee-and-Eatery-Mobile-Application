import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:loh_coffee_eatery/models/menu_model.dart';
import 'package:loh_coffee_eatery/models/payment_model.dart';
import 'package:loh_coffee_eatery/models/table_model.dart';
import 'package:loh_coffee_eatery/models/user_model.dart';

// class OrderModel extends Equatable{
//   final String id;
//   final int number;
//   final UserModel user;
//   final List<MenuModel> menu;
//   final int tableNum;
//   final PaymentModel payment;
//   final String orderStatus;
//   final Timestamp orderDateTime;

//   OrderModel({
//     required this.id,
//     required this.number,
//     required this.user,
//     required this.menu,
//     required this.tableNum,
//     required this.payment,
//     required this.orderStatus,
//     required this.orderDateTime,
//   });

//   // factory OrderModel.fromJson(String id, Map<String, dynamic> json) {
//   //   return OrderModel(
//   //     id: id,
//   //     user: UserModel.fromJson(id, json['user']),
//   //     number: json['number'],
//   //     menu: List<MenuModel>.from(json['menu'].map((x) => MenuModel.fromJson(id, x))),
//   //     tableNum: json['tableNum'],
//   //     payment: PaymentModel.fromJson(id, json['payment']),
//   //     orderStatus: json['orderStatus'],
//   //     orderDateTime: json['orderDateTime'],
//   //   );
//   // }

//   // Map<String, dynamic> toJson() {
//   //   return {
//   //     'user': user.toJson(),
//   //     'number': number,
//   //     'menu': List<dynamic>.from(menu.map((x) => x.toJson())),
//   //     'tableNum': tableNum,
//   //     'payment': payment.toJson(),
//   //     'orderStatus': orderStatus,
//   //     'orderDateTime': orderDateTime,
//   //   };
//   // }
// factory OrderModel.fromJson(String id, Map<String, dynamic> json) {
//   return OrderModel(
//     id: id,
//     user: UserModel.fromJson(id, json['user']),
//     number: json['number'],
//     menu: List<MenuModel>.from(json['menu'].map((x) => MenuModel.fromJson(id, x))),
//     tableNum: json['tableNum'],
//     payment: PaymentModel.fromJson(id, json['payment'] as Map<String, dynamic>), // ensure that 'payment' is parsed as a Map<String, dynamic>
//     orderStatus: json['orderStatus'],
//     orderDateTime: json['orderDateTime'],
//   );
// }

//   @override
//   // TODO: implement props
//   List<Object?> get props => [
//     id,
//     number,
//     user,
//     menu,
//     tableNum,
//     payment,
//     orderStatus,
//     orderDateTime,
//   ];

//   static Future<List<OrderModel>> fromJson(String id, Map<String, dynamic> data) {
//     return Future.value([
//       OrderModel(
//         id: id,
//         number: data['number'],
//         user: UserModel.fromJson(id, data['user']),
//         menu: List<MenuModel>.from(data['menu'].map((x) => MenuModel.fromJson(id, x))),
//         tableNum: data['tableNum'],
//         payment: PaymentModel.fromJson(id, data['payment']),
//         orderStatus: data['orderStatus'],
//         orderDateTime: data['orderDateTime'],
//       ),
//     ]);
//   }

//}

//--------------
// class OrderModel extends Equatable {
//   final String id;
//   final int number;
//   final UserModel user;
//   final List<MenuModel> menu;
//   final int tableNum;
//   late final PaymentModel payment;
//   final String orderStatus;
//   final Timestamp orderDateTime;

//   OrderModel({
//     required this.id,
//     required this.number,
//     required this.user,
//     required this.menu,
//     required this.tableNum,
//     required this.payment,
//     required this.orderStatus,
//     required this.orderDateTime,
//   });

//   factory OrderModel.fromJsonFactory(String id, Map<String, dynamic> json) {
//     return OrderModel(
//       id: id,
//       user: UserModel.fromJson(id, json['user']),
//       number: json['number'],
//       menu: List<MenuModel>.from(json['menu'].map((x) => MenuModel.fromJson(id, x))),
//       tableNum: json['tableNum'],
//       payment: PaymentModel.fromJson(id, json['payment']),
//       orderStatus: json['orderStatus'],
//       orderDateTime: json['orderDateTime'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'user': user.toJson(),
//       'number': number,
//       'menu': List<dynamic>.from(menu.map((x) => x.toJson())),
//       'tableNum': tableNum,
//       'payment': payment.toJson(),
//       'orderStatus': orderStatus,
//       'orderDateTime': orderDateTime,
//     };
//   }

//   @override
//   List<Object?> get props => [
//         id,
//         number,
//         user,
//         menu,
//         tableNum,
//         payment,
//         orderStatus,
//         orderDateTime,
//       ];

//   static Future<List<OrderModel>> fromJson(String id, Map<String, dynamic> data) {
//     return Future.value([
//       OrderModel.fromJsonFactory(id, data),
//     ]);
//   }
// }

//---------

import 'package:loh_coffee_eatery/models/menu_model.dart';
import 'package:loh_coffee_eatery/models/payment_model.dart';
import 'package:loh_coffee_eatery/models/table_model.dart';
import 'package:loh_coffee_eatery/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String id;
  int number;
  UserModel user;
  List<MenuModel> menu;
  int tableNum;
  PaymentModel payment;
  String orderStatus;
  Timestamp orderDateTime;

  OrderModel({
    required this.id,
    required this.number,
    required this.user,
    required this.menu,
    required this.tableNum,
    required this.payment,
    required this.orderStatus,
    required this.orderDateTime,
  });

  Map<String, dynamic> toJson() => {
        'number': number,
        'user': user.toJson(),
        'menu': menu.map((e) => e.toJson()).toList(),
        'tableNum': tableNum,
        'payment': payment.toJson(),
        'orderStatus': orderStatus,
        'orderDateTime': orderDateTime,
      };

  factory OrderModel.fromJson(String id, Map<String, dynamic> json) {
    return OrderModel(
      id: id,
      number: json['number'],
      user: UserModel.fromJson(json['user']['id'], json['user']),
      menu: (json['menu'] as List)
          .map((e) => MenuModel.fromJson(e['id'], e))
          .toList(),
      tableNum: json['tableNum'],
      payment: PaymentModel.fromJson(json['payment']['id'], json['payment']),
      orderStatus: json['orderStatus'],
      orderDateTime: json['orderDateTime'],
    );
  }
  
}
