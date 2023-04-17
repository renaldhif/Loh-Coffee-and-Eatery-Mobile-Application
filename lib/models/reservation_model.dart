import 'package:equatable/equatable.dart';
import 'package:loh_coffee_eatery/models/user_model.dart';

class ReservationModel extends Equatable {
  final String id;
  final String customerName;
  final String customerEmail;
  final String date;
  final String time;
  final String location;
  final int sizeOfPeople;
  final int tableNum;
  final DateTime dateCreated;

  const ReservationModel({
    required this.id,
    required this.customerName,
    required this.customerEmail,
    required this.date,
    required this.time,
    required this.tableNum,
    required this.sizeOfPeople,
    required this.location,
    required this.dateCreated,
  });

  factory ReservationModel.fromJson(String id, Map<String, dynamic> json) {
    return ReservationModel(
      id: id,
      customerName: json['customerName'],
      customerEmail: json['customerEmail'],
      date: json['date'],
      time: json['time'],
      tableNum: json['tableNum'],
      sizeOfPeople: json['sizeOfPeople'],
      location: json['location'],
      dateCreated: json['dateCreated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerName': customerName,
      'customerEmail': customerEmail,
      'date': date,
      'time': time,
      'tableNum': tableNum,
      'sizeOfPeople': sizeOfPeople,
      'location': location,
      'dateCreated': dateCreated,
    };
  }

  @override
  List<Object?> get props => [
    id,
    customerName,
    customerEmail,
    date,
    time,
    tableNum,
    sizeOfPeople,
    location,
    dateCreated,
  ];
}
