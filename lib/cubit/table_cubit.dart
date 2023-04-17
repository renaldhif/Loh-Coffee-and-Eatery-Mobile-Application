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

  void updateTable({
    required String id,
    required int tableNum,
    required int sizeOfPeople,
    required String location,
    required bool isBooked,
  }) async {
    try {
      emit(TableLoading());
      await TableService().updateTable(
        id: id,
        tableNum: tableNum,
        sizeOfPeople: sizeOfPeople,
        location: location,
        isBooked: isBooked,
      );
      emit(TableSuccess([]));
    } catch (e) {
      emit(TableFailed(e.toString()));
    }
  }

  void deleteTable({required int tableNum}) async {
    try {
      emit(TableLoading());
      await TableService().deleteTable(tableNum: tableNum);
      emit(TableSuccess([]));
    } catch (e) {
      emit(TableFailed(e.toString()));
    }
  }

  void getTableNum() async {
    try {
      emit(TableLoading());
      List<int> tableNum = await TableService().getTableNum();
      emit(TableSuccess([]));
    } catch (e) {
      emit(TableFailed(e.toString()));
    }
  }

  Future<List<int>> getAvailableTableNumbers() async {
    try {
      emit(TableLoading());
      List<int> tableNum = await TableService().getAvailableTableNumbers();
      emit(TableSuccess([]));
      return tableNum; // Add this line to return the table numbers list
    } catch (e) {
      emit(TableFailed(e.toString()));
      throw e; // Add this line to re-throw the error
    }
  }

  Future<int> getTableSizeByTableNumber(int tableNum) async {
    try {
      emit(TableLoading());
      int tableSize = await TableService().getTableSizeByTableNumber(tableNum: tableNum);
      emit(TableSuccess([]));
      return tableSize; // Add this line to return the table size
    } catch (e) {
      emit(TableFailed(e.toString()));
      throw e; // Add this line to re-throw the error
    }
  }

  Future<String> getTableLocationByTableNumber(int tableNum) async{
    try {
      emit(TableLoading());
      String tableLocation = await TableService().getTableLocationByTableNumber(tableNum: tableNum);
      emit(TableSuccess([]));
      return tableLocation; // Add this line to return the table size
    } catch (e) {
      emit(TableFailed(e.toString()));
      throw e; // Add this line to re-throw the error
    }
  }


}
