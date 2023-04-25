import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import '../models/reservation_model.dart';
import '../services/reservation_service.dart';
part 'reservation_state.dart';

class ReservationCubit extends Cubit<ReservationState> {
  ReservationCubit() : super(ReservationInitial());

  void addReservation({
    required String customerName,
    required String customerEmail,
    required String date,
    required String time,
    required int tableNum,
    required int sizeOfPeople,
    required String location,
    required Timestamp dateCreated,
  }) async {
    try {
      emit(ReservationLoading());
      ReservationModel reservations = await ReservationService().addReservation(
        customerName: customerName,
        customerEmail: customerEmail,
        date: date,
        time: time,
        tableNum: tableNum,
        sizeOfPeople: sizeOfPeople,
        location: location,
        dateCreated: dateCreated,
      );
      emit(ReservationSuccess([reservations]));
    } catch (e) {
      emit(ReservationFailed(e.toString()));
    }
  }

  Future<List<ReservationModel>> getReservations() async {
    try {
      emit(ReservationLoading());
      List<ReservationModel> reservations =
          await ReservationService().getReservations();
      emit(ReservationSuccess(reservations));
      return reservations;
    } catch (e) {
      emit(ReservationFailed(e.toString()));
      return [];
    }
  }

  //get reservation by customer email
  Future<List<ReservationModel>> getReservationByCustomerEmail(
      String customerEmail) async {
    try {
      emit(ReservationLoading());
      List<ReservationModel> reservation = await ReservationService()
          .getReservationByCustomerEmail(customerEmail);
      emit(ReservationSuccess(reservation));
      return reservation;
    } catch (e) {
      emit(ReservationFailed(e.toString()));
      return [];
    }
  }

  Future<List<ReservationModel>> getReservationByCustomerName(
      String customerName) async {
    try {
      emit(ReservationLoading());
      List<ReservationModel> reservation =
          await ReservationService().getReservationByCustomerName(customerName);
      emit(ReservationSuccess(reservation));
      return reservation;
    } catch (e) {
      emit(ReservationFailed(e.toString()));
      return [];
    }
  }

  Future<void> updateTableIsBooked(int tableNum) async {
    try {
      emit(ReservationLoading());
      await ReservationService().updateTableIsBooked(tableNum);
      emit(ReservationSuccess([]));
    } catch (e) {
      emit(ReservationFailed(e.toString()));
    }
  }

  Future<void> cancelReservation(String id) async {
    try {
      emit(ReservationLoading());
      await ReservationService().cancelReservation(id);
      emit(ReservationSuccess([]));
    } catch (e) {
      emit(ReservationFailed(e.toString()));
    }
  }

  Future<void> doneReservation(String id) async {
    try {
      emit(ReservationLoading());
      await ReservationService().doneReservation(id);
      emit(ReservationSuccess([]));
    } catch (e) {
      emit(ReservationFailed(e.toString()));
    }
  }

}
