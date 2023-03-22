import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loh_coffee_eatery/models/menu_model.dart';
import 'package:loh_coffee_eatery/models/payment_model.dart';
import 'package:loh_coffee_eatery/models/table_model.dart';
import 'package:loh_coffee_eatery/models/user_model.dart';
import '/models/order_model.dart';

class OrderService{
  final CollectionReference _orderCollection = FirebaseFirestore.instance.collection('orders');

  Future<void> createOrder(OrderModel order) async {
    try{
      _orderCollection.add(
        {
          'number' : order.number,
          'user' : order.user.toJson(),
          'menu' : order.menu.map((e) => e.toJson()).toList(),
          'tableNum' : order.tableNum,
          'payment' : order.payment.toJson(),
          'orderStatus' : order.orderStatus,
          'orderDateTime' : order.orderDateTime,
        }
      );
    } catch (e) {
      print(e.toString());
    }
  }

  // Future<OrderModel> addOrder({
  //   required int number,
  //   required UserModel user,
  //   required List<MenuModel> menu,
  //   required int tableNum,
  //   required PaymentModel payment,
  //   required String orderStatus,
  //   required Timestamp orderDateTime,
  // }) async {
  //   try{
  //     _orderCollection.add({
  //       'number' : number,
  //       'user' : user,
  //       'menu' : menu,
  //       'tableNum' : tableNum,
  //       'paymentId' : payment,
  //       'orderStatus' : orderStatus,
  //       'orderDateTime' : orderDateTime,
  //     });
  //     return OrderModel(
  //       id: '',
  //       number: number,
  //       user: user,
  //       menu: menu,
  //       tableNum: tableNum,
  //       payment: payment,
  //       orderStatus: orderStatus,
  //       orderDateTime: orderDateTime,
  //     );
  //   } catch (e) {
  //     throw e;
  //   }
  // }



//   Future<List<OrderModel>> getOrders() async {
//   try {
//     QuerySnapshot querySnapshot = await _orderCollection.get();
//     List<OrderModel> orders = querySnapshot.docs.map((e) {
//       return OrderModel.fromJson(e.id, e.data() as Map<String, dynamic>);
//     }).toList();
  
//     return orders;
//   } catch (e) {
//     throw e;
//   }
// }

// //update status
//   Future<void> updateOrder({
//     required String id,
//     required String orderStatus,
//   }) async{
//     try{
//       await _orderCollection.doc(id).update({
//         'orderStatus' : orderStatus,
//       });
//     }catch(e){
//       throw e;
//     }
//   }



}

