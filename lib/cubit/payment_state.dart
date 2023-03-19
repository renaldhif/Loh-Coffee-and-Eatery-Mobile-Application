
import 'package:equatable/equatable.dart';
import 'package:loh_coffee_eatery/models/payment_model.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final List<PaymentModel> payments;

  PaymentSuccess(this.payments);

  @override
  List<Object> get props => [payments];
}

class PaymentFailed extends PaymentState {
  final String error;

  PaymentFailed(this.error);

  @override
  List<Object> get props => [error];
}

