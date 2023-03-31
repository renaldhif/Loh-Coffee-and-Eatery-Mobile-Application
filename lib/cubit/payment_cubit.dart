import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import '../models/payment_model.dart';
import '../services/payment_services.dart';
import 'payment_state.dart';


class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  void addPayment({
    required String paymentReceipt,
    required String paymentOption,
    required String diningOption,
    required int totalPrice,
    required String status,
    required Timestamp paymentDateTime,
    required String customerName,
  }) async {
    try {
      emit(PaymentLoading());
      PaymentModel payment = await PaymentService().addPayment(
        paymentReceipt: paymentReceipt,
        paymentOption: paymentOption,
        diningOption: diningOption,
        totalPrice: totalPrice,
        status: status,
        paymentDateTime: paymentDateTime,
        customerName: customerName,
      );
      emit(PaymentSuccess([payment]));
    } catch (e) {
      emit(PaymentFailed(e.toString()));
    }
  }

  void getPayments() async {
    try {
      emit(PaymentLoading());
      List<PaymentModel> payments = await PaymentService().getPayments();
      emit(PaymentSuccess(payments));
    } catch (e) {
      emit(PaymentFailed(e.toString()));
    }
  }

  Future<void> changePaymentStatusByIndex({
    required int index,
    required String status,
  }) async{
    try{
      emit(PaymentLoading());
      await PaymentService().changePaymentStatusByIndex(
        index: index,
        status: status,
      );
      print(status);
      emit(PaymentSuccess([]));
    }catch(e){
      throw e;
    }
  }

  Future<PaymentModel> getPaymentByTimestamp({
    required Timestamp paymentDateTime,
  }) async {
    try {
      emit(PaymentLoading());
      PaymentModel payments = await PaymentService().getPaymentByTimestamp(
        paymentDateTime: paymentDateTime,
      );
      return payments;
    } catch (e) {
      throw e;
    }
  }

  Future<String> getCustomerNameByIndex({
    required int index,
  }) async{
    try{
      emit(PaymentLoading());
      
      String customerName = await PaymentService().getCustomerNameByIndex(
        index: index,
      );
      return customerName.toString();


    }catch(e){
      throw e;
    }
  }

  Future<Timestamp> getTimestampByIndex({
    required int index,
  }) async{
    try{
      emit(PaymentLoading());
      
      Timestamp paymentDateTime = await PaymentService().getTimestampByIndex(
        index: index,
      );
      return paymentDateTime;
  }
  catch(e){
    throw e;
  }
  }

  Future<String> getPaymentReceiptByIndex({
    required int index,
  }) async{
    try{
      emit(PaymentLoading());
      
      String paymentReceipt = await PaymentService().getPaymentReceiptByIndex(
        index: index,
      );
      return paymentReceipt;
  }
  catch(e){
    throw e;
  }
  }

    Future<String> getPaymentStatusByIndex({
    required int index,
  }) async{
    try{
      emit(PaymentLoading());
      
      String status = await PaymentService().getPaymentStatusByIndex(
        index: index,
      );
      return status;
  }
  catch(e){
    throw e;
  }
  }

    Future<String> getPaymentOptionByIndex({
    required int index,
  }) async{
    try{
      emit(PaymentLoading());
      
      String paymentOption = await PaymentService().getPaymentOptionByIndex(
        index: index,
      );
      return paymentOption;
  }
  catch(e){
    throw e;
  }
  }


    Future<int> getTotalPriceByIndex({
      required int index,
    }) async{
      try{
        emit(PaymentLoading());
        
        int totalPrice = await PaymentService().getTotalPriceByIndex(
          index: index,
        );
        return totalPrice;
    }
      catch(e){
        throw e;
      }
    }

  Future<PaymentModel> getPaymentByIndex({
    required int index,
  }) async{
    try{
      emit(PaymentLoading());
      
      PaymentModel payment = await PaymentService().getPaymentByIndex(
        index: index,
      );
      return payment;
  }
  catch(e){
    throw e;
  }
  }

}