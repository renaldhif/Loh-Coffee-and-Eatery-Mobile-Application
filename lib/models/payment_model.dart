import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PaymentModel extends Equatable {
  final String id;
  final String paymentReceipt;
  final String paymentOption;
  final String diningOption;
  final int totalPrice;
  final String status;
  final Timestamp paymentDateTime;

  const PaymentModel({
    required this.id,
    required this.paymentReceipt,
    required this.paymentOption,
    required this.diningOption,
    required this.totalPrice,
    required this.status,
    required this.paymentDateTime,
  });

  factory PaymentModel.fromJson(String id, Map<String, dynamic> json) {
    return PaymentModel(
      id: id,
      paymentReceipt: json['paymentReceipt'],
      paymentOption: json['paymentOption'],
      diningOption: json['diningOption'],
      totalPrice: json['totalPrice'],
      status: json['status'],
      paymentDateTime: json['paymentDateTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentReceipt': paymentReceipt,
      'paymentOption': paymentOption,
      'diningOption': diningOption,
      'totalPrice': totalPrice,
      'status': status,
      'paymentDateTime': paymentDateTime,
    };
  }

  @override
  List<Object?> get props => [
    id,
    paymentReceipt,
    paymentOption,
    diningOption,
    totalPrice,
    status,
    paymentDateTime,
  ];
}