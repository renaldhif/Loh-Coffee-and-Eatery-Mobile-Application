part of 'reservation_cubit.dart';

abstract class ReservationState extends Equatable {
  const ReservationState();

  @override
  List<Object> get props => [];
}

class ReservationInitial extends ReservationState {}

class ReservationLoading extends ReservationState {}

class ReservationSuccess extends ReservationState {
  final List<ReservationModel> reservations;

  ReservationSuccess(this.reservations);

  @override
  List<Object> get props => [reservations];
}

class ReservationFailed extends ReservationState {
  final String error;

  ReservationFailed(this.error);

  @override
  List<Object> get props => [error];
}