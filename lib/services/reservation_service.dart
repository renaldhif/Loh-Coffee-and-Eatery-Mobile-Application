import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/reservation_model.dart';

class ReservationService {
  final CollectionReference _reservationCollection =
      FirebaseFirestore.instance.collection('reservations');
  
  final CollectionReference _tableCollection =
      FirebaseFirestore.instance.collection('tables');

  Future<ReservationModel> addReservation({
    required customerName,
    required customerEmail,
    required date,
    required time,
    required tableNum,
    required sizeOfPeople,
    required location,
    required dateCreated,
  }) async {
    try {
      _reservationCollection.add({
        'customerName': customerName,
        'customerEmail': customerEmail,
        'date': date,
        'time': time,
        'tableNum': tableNum,
        'sizeOfPeople': sizeOfPeople,
        'location': location,
        'dateCreated': dateCreated,
      });
      return ReservationModel(
        id: '',
        customerName: customerName,
        customerEmail: customerEmail,
        date: date,
        time: time,
        tableNum: tableNum,
        sizeOfPeople: sizeOfPeople,
        location: location,
        dateCreated: dateCreated,
      );
    } catch (e) {
      throw e;
    }
  }

  Future<List<ReservationModel>> getReservations() async {
    try {
      QuerySnapshot querySnapshot = await _reservationCollection.get();
      List<ReservationModel> reservations = querySnapshot.docs.map((e) {
        return ReservationModel.fromJson(
            e.id, e.data() as Map<String, dynamic>);
      }).toList();

      return reservations;
    } catch (e) {
      throw e;
    }
  }

  //get reservation by customer email
  Future<List<ReservationModel>> getReservationByCustomerEmail(
      String customerEmail) async {
    try {
      QuerySnapshot querySnapshot = await _reservationCollection
          .where('customerEmail', isEqualTo: customerEmail)
          .get();
      List<ReservationModel> reservations = querySnapshot.docs.map((e) {
        return ReservationModel.fromJson(
            e.id, e.data() as Map<String, dynamic>);
      }).toList();
      return reservations;
    } catch (e) {
      throw e;
    }
  }

  Future<List<ReservationModel>> getReservationByCustomerName(
      String customerName) async {
    try {
      QuerySnapshot querySnapshot = await _reservationCollection
          .where('customerName', isEqualTo: customerName)
          .get();
      List<ReservationModel> reservations = querySnapshot.docs.map((e) {
        return ReservationModel.fromJson(
            e.id, e.data() as Map<String, dynamic>);
      }).toList();
      return reservations;
    } catch (e) {
      throw e;
    }
  }

  //get reservation date
  Future<String> getReservationDate(String id) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _reservationCollection.doc(id).get();
      ReservationModel reservation = ReservationModel.fromJson(
          documentSnapshot.id, documentSnapshot.data() as Map<String, dynamic>);
      return reservation.date;
    } catch (e) {
      throw e;
    }
  }

  //update table isBooked by table number
  Future<void> updateTableIsBooked(int tableNum) async {
    try {
      QuerySnapshot querySnapshot = await _tableCollection
          .where('tableNum', isEqualTo: tableNum)
          .get();
      querySnapshot.docs.forEach((element) {
        _tableCollection.doc(element.id).update({'isBooked': true});
      });
    } catch (e) {
      throw e;
    }
  }

  //cancel reservation
  Future<void> cancelReservation(String id) async {
    try {
      DocumentSnapshot documentSnapshot = await _reservationCollection.doc(id).get();
      //get table number from document snapshot
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      int tableNum = data['tableNum'];
      //update table isBooked to false
      QuerySnapshot querySnapshot = await _tableCollection
          .where('tableNum', isEqualTo: tableNum)
          .get();
      querySnapshot.docs.forEach((element) {
        _tableCollection.doc(element.id).update({'isBooked': false});
      });
      //delete reservation
      await _reservationCollection.doc(id).delete();
    } catch (e) {
      throw e;
    }
  }

  // Done Reservation
  Future<void> doneReservation(String id) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _reservationCollection.doc(id).get();
      //get table number from document snapshot
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      int tableNum = data['tableNum'];
      //update table isBooked to false
      QuerySnapshot querySnapshot = await _tableCollection
          .where('tableNum', isEqualTo: tableNum)
          .get();
      querySnapshot.docs.forEach((element) {
        _tableCollection.doc(element.id).update({'isBooked': false});
      });
    } catch (e) {
      throw e;
    }
  }

}
