import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/menu_model.dart';
import '../services/menu_service.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(MenuInitial());

  // void addMenu(MenuModel menu) async {
  void addMenu({
    required String title,
    required String description,
    required String tag,
    required int price,
    required String image,
    int totalLoved = 0,
    int totalOrdered = 0,
    int quantity = 1,
    List<String> userId = const [],
  }) async {
    try {
      emit(MenuLoading());

      MenuModel menu = await MenuService().addMenu(
        title: title,
        description: description,
        tag: tag,
        price: price,
        image: image,
        totalLoved: totalLoved,
        totalOrdered: totalOrdered,
        quantity: quantity,
        userId: userId,
      );
      emit(MenuSuccess([menu]));
    } catch (e) {
      emit(MenuFailed(e.toString()));
    }
  }

  void getMenus() async {
    try {
      emit(MenuLoading());
      List<MenuModel> menus = await MenuService().getMenus();
      emit(MenuSuccess(menus));
    } catch (e) {
      emit(MenuFailed(e.toString()));
    }
  }

  Future<void> getRecommendedMenus(String uid) async {
    print('getRecommendedMenus() executed');
    try {
      emit(MenuLoadingRecommendation());
      List<MenuModel> menuRecommend = await MenuService().getRecommendedMenus(uid);
      emit(MenuSuccessRecomendation(menuRecommend));
    } catch (e) {
      emit(MenuFailed(e.toString()));
      throw (e);
    }
  }

  // Future<void> getTop3MenusBasedOnTotalLovedAndOrdered() async{
  //   try {
  //     emit(MenuLoadingRecommendation());
  //     bool menuTop3 = await MenuService().getTop3MenusBasedOnTotalLovedAndOrdered().then((value) => true);
  //     emit(MenuLoadingRecommendation());
  //   } catch (e) {
  //     emit(MenuFailed(e.toString()));
  //     throw (e);
  //   }
  // }

  Future<MenuModel> getMenuById(String id) async {
    try {
      emit(MenuLoading());
      MenuModel menu = await MenuService().getMenuById(id);
      emit(MenuSuccess([menu]));
      return menu;
    } catch (e) {
      emit(MenuFailed(e.toString()));
      throw e;
    }
  }

  void updateMenu(MenuModel? menu, String title, String description, int price,
      String tag, String image) async {
    try {
      emit(MenuLoading());
      await MenuService()
          .updateMenu(menu!, title, description, price, tag, image);
      emit(MenuSuccess([menu]));
    } catch (e) {
      emit(MenuFailed(e.toString()));
    }
  }

  void deleteMenu(MenuModel? menu) async {
    try {
      emit(MenuLoading());
      await MenuService().deleteMenu(menu!);
      getMenus();
    } catch (e) {
      emit(MenuFailed(e.toString()));
    }
  }

  void addQuantity(MenuModel? menu) async {
    try {
      emit(MenuLoading());
      await MenuService().addQuantity(menu!);
      getMenus();
    } catch (e) {
      emit(MenuFailed(e.toString()));
    }
  }

  void minusQuantity(MenuModel? menu) async {
    try {
      emit(MenuLoading());
      await MenuService().minusQuantity(menu!);
      getMenus();
    } catch (e) {
      emit(MenuFailed(e.toString()));
    }
  }

  void addLikeMenu(MenuModel? menu, String? uid) async {
    try {
      emit(MenuLoading());
      await MenuService().addLikeMenu(menu!, uid);
      getMenus();
    } catch (e) {
      emit(MenuFailed(e.toString()));
    }
  }
}
