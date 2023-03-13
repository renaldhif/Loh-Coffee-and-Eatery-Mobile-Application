import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import '../models/table_model.dart';
import '../services/table_service.dart';
part 'table_state.dart';

class TableCubit extends Cubit<TableState> {
  TableCubit() : super(TableInitial());

  void addTable({
    required int tableNum,
    required int sizeOfPeople,
    required String location,
    required bool isBooked,
  }) async {
    try {
      emit(TableLoading());
      TableModel tables = await TableService().addTable(
        tableNum: tableNum,
        sizeOfPeople: sizeOfPeople,
        location: location,
        isBooked: isBooked,
      );
      emit(TableSuccess([tables]));
    } catch (e) {
      emit(TableFailed(e.toString()));
    }
  }

  void getTables() async {
    try {
      emit(TableLoading());
      List<TableModel> tables = await TableService().getTables();
      emit(TableSuccess(tables));
    } catch (e) {
      emit(TableFailed(e.toString()));
    }
  }

}
