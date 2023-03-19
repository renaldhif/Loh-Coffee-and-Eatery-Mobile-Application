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
}