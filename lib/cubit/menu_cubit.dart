import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/menu_model.dart';
import '../services/menu_service.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(MenuInitial());

  void getMenus() async{
    try{
      emit(MenuLoading());
      List<MenuModel> menus = await MenuService().getMenus();
      emit(MenuSuccess(menus));
    } catch (e) {
      emit(MenuFailed(e.toString()));
    }
  }
}
