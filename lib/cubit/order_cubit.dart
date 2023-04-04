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

  void createOrder({
    required int number,
    required UserModel user,
    required List<MenuModel> menu,
    required int tableNum,
    required PaymentModel payment,
    required String orderStatus,
    required Timestamp orderDateTime,
  }) async {
    try {
      emit(OrderLoading());
      await OrderService().createOrder(
        number: number,
        user: user,
        menu: menu,
        tableNum: tableNum,
        payment: payment,
        orderStatus: orderStatus,
        orderDateTime: orderDateTime,
      );
      emit(OrderSuccess([]));
    } catch (e) {
      emit(OrderFailed(e.toString()));
    }
  }

  void getOrders() async {
    try {
      emit(OrderLoading());
      List<OrderModel> orders = await OrderService().getOrders();
      emit(OrderSuccess(orders));
    } catch (e) {
      emit(OrderFailed(e.toString()));
    }
  }

  Future<String> getCustomerNameByIndex({
    required int index,
  }) async {
    try {
      emit(OrderLoading());

      String customerName = await OrderService().getCustomerNameByIndex(
        index: index,
      );
      return customerName.toString();
    } catch (e) {
      throw e;
    }
  }

  Future<String> getDiningOptionByIndex({required int index}) async {
    try {
      emit(OrderLoading());
      String diningOption =
          await OrderService().getDiningOptionByIndex(index: index);
      emit(OrderSuccess([]));
      return diningOption;
    } catch (e) {
      emit(OrderFailed(e.toString()));
      throw e;
    }
  }

  Future<int> getTableNumberByIndex({
    required int index,
  }) async {
    try {
      emit(OrderLoading());
      int tableNumber =
          await OrderService().getTableNumberByIndex(index: index);
      emit(OrderSuccess([]));
      return tableNumber;
    } catch (e) {
      emit(OrderFailed(e.toString()));
      throw e;
    }
  }

  Future<List<MenuModel>> getMenuByIndex({required int index}) async {
    try {
      emit(OrderLoading());
      List<MenuModel> menu =
          await OrderService().getListOfMenuByIndex(index: index);
      emit(OrderSuccess([]));
      return menu;
    } catch (e) {
      emit(OrderFailed(e.toString()));
      throw e;
    }
  }

  Future<int> getTotalPriceByIndex({
    required int index,
  }) async {
    try {
      emit(OrderLoading());
      int totalPrice = await OrderService().getTotalPriceByIndex(index: index);
      emit(OrderSuccess([]));
      return totalPrice;
    } catch (e) {
      emit(OrderFailed(e.toString()));
      throw e;
    }
  }

  Future<String> getPaymentStatusByIndex({
    required int index,
  }) async {
    try {
      emit(OrderLoading());
      String paymentStatus =
          await OrderService().getPaymentStatusByIndex(index: index);
      emit(OrderSuccess([]));
      return paymentStatus;
    } catch (e) {
      emit(OrderFailed(e.toString()));
      throw e;
    }
  }

  Future<String> getOrderStatusByIndex({required int index}) async {
    try {
      emit(OrderLoading());
      String orderStatus =
          await OrderService().getOrderStatusByIndex(index: index);
      emit(OrderSuccess([]));
      return orderStatus;
    } catch (e) {
      emit(OrderFailed(e.toString()));
      throw e;
    }
  }

  Future<Timestamp> getOrderDateTimeByIndex({required int index}) async {
    try {
      emit(OrderLoading());
      Timestamp orderDateTime =
          await OrderService().getOrderDateTimeByIndex(index: index);
      emit(OrderSuccess([]));
      return orderDateTime;
    } catch (e) {
      emit(OrderFailed(e.toString()));
      throw e;
    }
  }

  Future<void> updateOrderStatusByNumber({
    required int orderNumber,
    required String orderStatus,
  }) async {
    try {
      emit(OrderLoading());
      await OrderService().updateOrderStatusByNumber(orderNumber, orderStatus);
      emit(OrderSuccess([]));
    } catch (e) {
      emit(OrderFailed(e.toString()));
      throw e;
    }
  }

  Future<void> changePaymentStatusByPayment({
    required Timestamp orderDateTime,
    required String status,
  }) async {
    try {
      emit(OrderLoading());
      await OrderService().changePaymentStatusByPayment(
          orderDateTime: orderDateTime, status: status);
      emit(OrderSuccess([]));
    } catch (e) {
      emit(OrderFailed(e.toString()));
      throw e;
    }
  }

  //update order status by order datetime
  Future<void> updateOrderStatusByOrderDateTime({
    required Timestamp orderDateTime,
    required String orderStatus,
  }) async {
    try {
      emit(OrderLoading());
      await OrderService().updateOrderStatusByOrderDateTime(
          orderDateTime: orderDateTime, orderStatus: orderStatus);
      emit(OrderSuccess([]));
    } catch (e) {
      emit(OrderFailed(e.toString()));
      throw e;
    }
  }

  Future<List<String>> getOrderIdListByUserEmail(String email) async {
    try {
      emit(OrderLoading());
      List<String> orderIdList =
          await OrderService().getOrderIdListByUserEmail(email);
      emit(OrderSuccess([]));
      return orderIdList;
    } catch (e) {
      emit(OrderFailed(e.toString()));
      throw e;
    }
  }

  Future<void> updateTotalOrdered(
      int orderNumber, List<MenuModel> menu) async {
    try {
      emit(OrderLoading());
      await OrderService().updateTotalOrdered(orderNumber, menu);
      emit(OrderSuccess([]));
    } catch (e) {
      emit(OrderFailed(e.toString()));
      throw e;
    }
  }
}
