part of 'table_cubit.dart';

abstract class TableState extends Equatable {
  const TableState();

  @override
  List<Object> get props => [];
}

class TableInitial extends TableState {}

class TableLoading extends TableState {}

class TableSuccess extends TableState {
  final List<TableModel> tables;

  TableSuccess(this.tables);

  @override
  List<Object> get props => [tables];
}

class TableFailed extends TableState {
  final String error;

  TableFailed(this.error);

  @override
  List<Object> get props => [error];
}