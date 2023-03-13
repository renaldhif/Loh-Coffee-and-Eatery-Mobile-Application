import 'package:equatable/equatable.dart';

class TableModel extends Equatable {
  final String id;
  final int tableNum;
  final int sizeOfPeople;
  final String location;
  final bool isBooked;

  const TableModel({
    required this.id,
    required this.tableNum,
    required this.sizeOfPeople,
    required this.location,
    this.isBooked = false,
  });

  factory TableModel.fromJson(String id, Map<String, dynamic> json) {
    return TableModel(
      id: id,
      tableNum: json['tableNum'],
      sizeOfPeople: json['sizeOfPeople'],
      location: json['location'],
      isBooked: json['isBooked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tableNum': tableNum,
      'sizeOfPeople': tableNum,
      'location': location,
      'isBooked': isBooked,
    };
  }

  @override
  List<Object?> get props => [id, tableNum, sizeOfPeople, location, isBooked];
}
