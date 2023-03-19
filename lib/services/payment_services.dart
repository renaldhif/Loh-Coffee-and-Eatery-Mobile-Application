import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loh_coffee_eatery/models/payment_model.dart';

class PaymentService{
  final CollectionReference _paymentCollection = FirebaseFirestore.instance.collection('payments');

  Future<PaymentModel> addPayment({
    required String paymentReceipt,
    required String paymentOption,
    required String diningOption,
    required int totalPrice,
    required String status,
    required Timestamp paymentDateTime,
  })
  async{
    try{
      await _paymentCollection.add({
        'paymentReceipt': paymentReceipt,
        'paymentOption' : paymentOption,
        'diningOption' : diningOption,
        'totalPrice' : totalPrice,
        'status' : status,
        'paymentDateTime' : paymentDateTime,
      });
      return PaymentModel(
        id: '',
        paymentReceipt: paymentReceipt,
        paymentOption: paymentOption,
        diningOption: diningOption,
        totalPrice: totalPrice,
        status: status,
        paymentDateTime: paymentDateTime,
      );
    }catch(e){
      throw e;
    }
  }

  Future<List<PaymentModel>> getPayments() async{
    try{
      QuerySnapshot querySnapshot = await _paymentCollection.get();
      List<PaymentModel> payments = querySnapshot.docs.map((e) {
        return PaymentModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      }).toList();
      return payments;
    }catch(e){
      throw e;
    }
  }

//update status
  Future<void> updatePayment({
    required String id,
    required String status,
  }) async{
    try{
      await _paymentCollection.doc(id).update({
        'status' : status,
      });
    }catch(e){
      throw e;
    }
  }
}