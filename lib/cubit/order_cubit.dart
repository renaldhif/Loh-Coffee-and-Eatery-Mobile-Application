import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loh_coffee_eatery/models/menu_model.dart';
import 'package:loh_coffee_eatery/models/order_model.dart';
import 'package:loh_coffee_eatery/models/user_model.dart';
import 'package:loh_coffee_eatery/services/order_service.dart';

import '../models/payment_model.dart';
import '../models/table_model.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  void createOrder(OrderModel order) async {
    try {
      emit(OrderLoading());
      await OrderService().createOrder(order);
      emit(OrderSuccess([]));
    } catch (e) {
      emit(OrderFailed(e.toString()));
    }
  }


  // void addOrder( {
  //   required int number,
  //   required UserModel user,
  //   required List<MenuModel> menu,
  //   required int tableNum,
  //   required PaymentModel payment,
  //   required String orderStatus,
  //   required Timestamp orderDateTime,
    
  // }) async {
  //   try {
  //     emit(OrderLoading());
  //     OrderModel order = await OrderService().addOrder(
  //       number: number,
  //       user: user,
  //       menu: menu,
  //       tableNum: tableNum,
  //       payment: payment,
  //       orderStatus: orderStatus,
  //       orderDateTime: orderDateTime,
  //     );
  //     emit(OrderSuccess([]));
  //   } catch (e) {
  //     emit(OrderFailed(e.toString()));
  //   }
  // }
}