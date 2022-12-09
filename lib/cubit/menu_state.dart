part of 'menu_cubit.dart';

abstract class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object> get props => [];
}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuSuccess extends MenuState {
  final List<MenuModel> menus;

  MenuSuccess(this.menus);

  @override
  List<Object> get props => [menus];
}

class MenuFailed extends MenuState {
  final String error;

  MenuFailed(this.error);

  @override
  List<Object> get props => [error];
}