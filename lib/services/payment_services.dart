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
    required String customerName,
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
        'customerName' : customerName,
      });
      return PaymentModel(
        id: '',
        paymentReceipt: paymentReceipt,
        paymentOption: paymentOption,
        diningOption: diningOption,
        totalPrice: totalPrice,
        status: status,
        paymentDateTime: paymentDateTime,
        customerName: customerName,
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


//change payment status by index 
  Future<void> changePaymentStatusByIndex({
    required int index,
    required String status,
  }) async{
    try{
      QuerySnapshot querySnapshot = await _paymentCollection.get();
      Iterable<PaymentModel> payments = querySnapshot.docs.map((e) {
        return PaymentModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      });
      await _paymentCollection.doc(payments.elementAt(index).id).update({
        'status' : status,
      });
    }catch(e){
      throw e;
    }
  }


  //get payement model by timestamp
  Future<PaymentModel> getPaymentByTimestamp({
    required Timestamp paymentDateTime,
  }) async{
    try{
      QuerySnapshot querySnapshot = await _paymentCollection.where('paymentDateTime', isEqualTo: paymentDateTime).get();
      Iterable<PaymentModel> payments = querySnapshot.docs.map((e) {
        return PaymentModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      });
      return payments.first;
    }catch(e){
      throw e;
    }
  }

  //get customerName by index
  Future<String> getCustomerNameByIndex({
    required int index,
  }) async{
    try{
      QuerySnapshot querySnapshot = await _paymentCollection.get();
      Iterable<PaymentModel> payments = querySnapshot.docs.map((e) {
        return PaymentModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      });
      return payments.elementAt(index).customerName;
    }catch(e){
      throw e;
    }
  }

  //get timestamp by index
  Future<Timestamp> getTimestampByIndex({
    required int index,
  }) async{
    try{
      QuerySnapshot querySnapshot = await _paymentCollection.get();
      Iterable<PaymentModel> payments = querySnapshot.docs.map((e) {
        return PaymentModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      });
      return payments.elementAt(index).paymentDateTime;
    }catch(e){
      throw e;
    }
  }

  //get paymentReceipt by index
  Future<String> getPaymentReceiptByIndex({
    required int index,
  }) async{
    try{
      QuerySnapshot querySnapshot = await _paymentCollection.get();
      Iterable<PaymentModel> payments = querySnapshot.docs.map((e) {
        return PaymentModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      });
      if(payments.elementAt(index).paymentReceipt == 'none')
        return 'none';
      else
        return payments.elementAt(index).paymentReceipt;
    }catch(e){
      throw e;
    }
  }

  //get paymentStatus by index
  Future<String> getPaymentStatusByIndex({
    required int index,
  }) async{
    try{
      QuerySnapshot querySnapshot = await _paymentCollection.get();
      Iterable<PaymentModel> payments = querySnapshot.docs.map((e) {
        return PaymentModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      });
      return payments.elementAt(index).status;
    }catch(e){
      throw e;
    }
  }

  //get paymentOption by index
  Future<String> getPaymentOptionByIndex({
    required int index,
  }) async{
    try{
      QuerySnapshot querySnapshot = await _paymentCollection.get();
      Iterable<PaymentModel> payments = querySnapshot.docs.map((e) {
        return PaymentModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      });
      return payments.elementAt(index).paymentOption;
    }catch(e){
      throw e;
    }
  }

  //get totalPrice by index
  Future<int> getTotalPriceByIndex({
    required int index,
  }) async{
    try{
      QuerySnapshot querySnapshot = await _paymentCollection.get();
      Iterable<PaymentModel> payments = querySnapshot.docs.map((e) {
        return PaymentModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      });
      return payments.elementAt(index).totalPrice;
    }catch(e){
      throw e;
    }
  }

  //get payment by index
  Future<PaymentModel> getPaymentByIndex({
    required int index,
  }) async{
    try{
      QuerySnapshot querySnapshot = await _paymentCollection.get();
      Iterable<PaymentModel> payments = querySnapshot.docs.map((e) {
        return PaymentModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      });
      return payments.elementAt(index);
    }catch(e){
      throw e;
    }
  }


}