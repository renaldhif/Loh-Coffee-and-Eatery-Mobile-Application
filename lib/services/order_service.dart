import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loh_coffee_eatery/models/menu_model.dart';
import 'package:loh_coffee_eatery/models/payment_model.dart';
import 'package:loh_coffee_eatery/models/table_model.dart';
import 'package:loh_coffee_eatery/models/user_model.dart';
import '../cubit/payment_cubit.dart';
import '/models/order_model.dart';

class OrderService{
  final CollectionReference _orderCollection = FirebaseFirestore.instance.collection('orders');
    final CollectionReference _paymentCollection = FirebaseFirestore.instance.collection('payments');

  Future<void> createOrder({
    required int number,
    required UserModel user,
    required List<MenuModel> menu,
    required int tableNum,
    required PaymentModel payment,
    required String orderStatus,
    required Timestamp orderDateTime,
  }) async {
    try{
      _orderCollection.add(
        {
          'number' : number,
          'user' : user.toJson(),
          'menu' : menu.map((e) => e.toJson()).toList(),
          'tableNum' : tableNum,
          'payment' : payment.toJson(),
          'orderStatus' : orderStatus,
          'orderDateTime' : orderDateTime,
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

  Future<List<OrderModel>> getOrders() async {
    try {
      QuerySnapshot querySnapshot = await _orderCollection.get();
      List<OrderModel> orders = querySnapshot.docs.map((e) {
        return OrderModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      }).cast<OrderModel>().toList();
      return orders;
    } catch (e) {
      throw e;
    }
  }

  //get index by order number
  // Future<int> getIndexByOrderNumber({
  //   required int orderNumber,
  // }) async{
  //   try{
  //     QuerySnapshot querySnapshot = await _orderCollection.get();
  //     List<OrderModel> orders = querySnapshot.docs.map((e) {
  //       return OrderModel.fromJson(e.id, e.data() as Map<String, dynamic>);
  //     }).cast<OrderModel>().toList();
  //     return orders.indexWhere((element) => element.number == orderNumber);
  //   }catch(e){
  //     throw e;
  //   }
  // }

//   Future<int> getIndexByOrderNumber({
//   required int orderNumber,
//   }) async {
//   try {
//     QuerySnapshot? querySnapshot = await _orderCollection.get();
//     Iterable orders = querySnapshot.docs.map((e)
//       => OrderModel.fromJson(e.id, e.data() as Map<String, dynamic>));
//       //if the order number is found, return the index
//       int index = 0;
//       for (var i = 0; i < orders.length; i++) {
//         if (orders.elementAt(i).number == orderNumber) {
//           index = i;
          
//         }
//       }
//       return index;
//   } catch (e) {
//     throw e;
//   }
// }


  //get customer name by index
  // Future<String> getCustomerNameByIndex({
  //   required int index,
  // }) async{
  //   try{
  //     QuerySnapshot querySnapshot = await _orderCollection.get();
  //     List<OrderModel> orders = querySnapshot.docs.map((e) {
  //       return OrderModel.fromJson(e.id, e.data() as Map<String, dynamic>);
  //     }).cast<OrderModel>().toList();
  //     return orders[index].payment.customerName;
  //   }catch(e){
  //     throw e;
  //   }
  // }

//   Future<String> getCustomerNameByIndex({
//   required int index,
// }) async {
//   try {
//     QuerySnapshot querySnapshot = await _orderCollection.get();
//     Iterable<OrderModel> orders = querySnapshot.docs.map((e) {
//       return OrderModel.fromJson(e.id, e.data() as Map<String, dynamic>);
//     }).cast<OrderModel>();
//     return orders.elementAt(index).payment.customerName;
//   } catch (e) {
//     throw e;
//   }
// }

//get payment by order index
  // Future<PaymentModel> getPaymentByOrderIndex({
  //   required int index,
  // }) async{
  //   try{
  //     QuerySnapshot querySnapshot = await _orderCollection.get();
  //     List<OrderModel> orders = querySnapshot.docs.map((e) {
  //       return OrderModel.fromJson(e.id, e.data() as Map<String, dynamic>);
  //     }).cast<OrderModel>().toList();
  //     return orders[index].payment;
  //   }catch(e){
  //     throw e;
  //   }
  // }
Future<PaymentModel> getPaymentByOrderIndex({
  required int index,
}) async {
  try {
    QuerySnapshot querySnapshot = await _orderCollection.get();
    List<OrderModel> orders = querySnapshot.docs.map((e) {
      return OrderModel.fromJson(e.id, e.data() as Map<String, dynamic>);
    }).toList();
    return orders[index].payment;
  } catch (e) {
    throw e;
  }
}


Future<String> getCustomerNameByIndex({
  required int index,
}) async {
  try {
    PaymentModel payment = await getPaymentByOrderIndex(index: index);
    if(payment.customerName != null) {
      return payment.customerName;
    } else {
      return "No customer name found";
    }
  }
  catch (e) {
  if (e != null) {
    throw e;
  } else {
    throw Exception("Unknown error occurred");
  }
  }
  // try {
  //   QuerySnapshot querySnapshot = await _orderCollection.get();
  //   List<OrderModel> orders = querySnapshot.docs.map((e) {
  //     return OrderModel.fromJson(e.id, e.data() as Map<String, dynamic>);
  //   }).cast<OrderModel>().toList();
  //   if (orders[index].payment != null) {
  //     return orders[index].payment.customerName;
  //   } else {
  //     throw Exception('Payment is null.');
  //   }
  // } catch (e) {
  //   return 'error';
  // }
}



  //get dining option by index
  Future<String> getDiningOptionByIndex({
    required int index,
  }) async{
    try{
      QuerySnapshot querySnapshot = await _orderCollection.get();
      List<OrderModel> orders = querySnapshot.docs.map((e) {
        return OrderModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      }).cast<OrderModel>().toList();
      return orders[index].payment.diningOption;
    }catch(e){
      throw e;
    }
  }

  //get table number by index
  Future<int> getTableNumberByIndex({
    required int index,
  }) async{
    try{
      QuerySnapshot querySnapshot = await _orderCollection.get();
      List<OrderModel> orders = querySnapshot.docs.map((e) {
        return OrderModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      }).cast<OrderModel>().toList();
      return orders[index].tableNum;
    }catch(e){
      throw e;
    }
  }

  //get list of menu by index
  Future<List<MenuModel>> getListOfMenuByIndex({
    required int index,
  }) async{
    try{
      QuerySnapshot querySnapshot = await _orderCollection.get();
      List<OrderModel> orders = querySnapshot.docs.map((e) {
        return OrderModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      }).cast<OrderModel>().toList();
      return orders[index].menu;
    }catch(e){
      throw e;
    }
  }

  //get total price by order index from the payment list in order
  Future<int> getTotalPriceByIndex({
    required int index,
  }) async{
    try{
      QuerySnapshot querySnapshot = await _orderCollection.get();
      List<OrderModel> orders = querySnapshot.docs.map((e) {
        return OrderModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      }).cast<OrderModel>().toList();
      return orders[index].payment.totalPrice;
    }catch(e){
      throw e;
    }
  }


  //get payment status by index from the payment list in order
  Future<String> getPaymentStatusByIndex({
    required int index,
  }) async{
    try{
      QuerySnapshot querySnapshot = await _orderCollection.get();
      List<OrderModel> orders = querySnapshot.docs.map((e) {
        return OrderModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      }).cast<OrderModel>().toList();
      return orders[index].payment.status;
    }catch(e){
      throw e;
    }
  }

  //get order status by index
  Future<String> getOrderStatusByIndex({
    required int index,
  }) async{
    try{
      QuerySnapshot querySnapshot = await _orderCollection.get();
      List<OrderModel> orders = querySnapshot.docs.map((e) {
        return OrderModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      }).cast<OrderModel>().toList();
      return orders[index].orderStatus;
    }catch(e){
      throw e;
    }
  }

  //get order date time by index
  Future<Timestamp> getOrderDateTimeByIndex({
    required int index,
  }) async{
    try{
      QuerySnapshot querySnapshot = await _orderCollection.get();
      List<OrderModel> orders = querySnapshot.docs.map((e) {
        return OrderModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      }).cast<OrderModel>().toList();
      return orders[index].orderDateTime;
    }catch(e){
      throw e;
    }
  }

  //update order status based on its order number
Future<void> updateOrderStatusByNumber(int orderNumber, String orderStatus) async {
    try {
      QuerySnapshot querySnapshot = await _orderCollection
          .where('number', isEqualTo: orderNumber)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        await documentSnapshot.reference.update({
          'orderStatus': orderStatus,
        });
      }
    } catch (e) {
      throw e;
    }
  }


  //---------
  //get order id by Timestamp
  Future<String> getOrderIdByOrderNumber(Timestamp orderDateTime) async {
    QuerySnapshot querySnapshot = await _orderCollection
          .where('orderDateTime', isEqualTo: orderDateTime)
          .get();
    if (querySnapshot.docs.isNotEmpty) {
      String id = querySnapshot.docs.first.id;
      return id;
    } else {
      throw Exception("No order found with order time $orderDateTime");
    }
  }

    Future<void> changePaymentStatusByPayment({
    required Timestamp orderDateTime,
    required String status,
  }) async{
    try{
      String id = await getOrderIdByOrderNumber(orderDateTime);
      await _orderCollection.doc(id).update({
        'payment.status': status,
      });

    }catch(e){
  }
}

// Future<void> changePaymentStatusByPayment({
//   required Timestamp orderDateTime,
//   required String status,
// }) async {
//   try {
//     // Get a reference to the order document
//     QuerySnapshot querySnapshot = await _orderCollection
//         .where('orderDateTime', isEqualTo: orderDateTime)
//         .get();
//     if (querySnapshot.docs.isNotEmpty) {
//       String orderId = querySnapshot.docs.first.id;
//       DocumentReference orderRef = _orderCollection.doc(orderId);

//       // Get a reference to the payment document in the payment subcollection
//       CollectionReference paymentRef = orderRef.collection('payment');
//       QuerySnapshot paymentQuerySnapshot = await paymentRef.get();
//       if (paymentQuerySnapshot.docs.isNotEmpty) {
//         String paymentId = paymentQuerySnapshot.docs.first.id;
//         DocumentReference paymentDocRef = paymentRef.doc(paymentId);

//         // Update the payment status field
//         await paymentDocRef.update({'status': status});
//       } else {
//         throw Exception('No payment document found for order with order time $orderDateTime');
//       }
//     } else {
//       throw Exception('No order found with order time $orderDateTime');
//     }
//   } catch (e) {
//     print('Error updating payment status: $e');
//     // Handle the error here
//   }
// }

  //update order status by order datetime
  Future<void> updateOrderStatusByOrderDateTime({
    required Timestamp orderDateTime,
    required String orderStatus,
  }) async{
    try{
      String id = await getOrderIdByOrderNumber(orderDateTime);
      await _orderCollection.doc(id).update({
        'orderStatus': orderStatus,
      });

    }catch(e){
      throw e;
    }
  }

  //get list of order id by user email
  Future<List<String>> getOrderIdListByUserEmail(String email) async{
    try{
      QuerySnapshot querySnapshot = await _orderCollection
          .where('user.email', isEqualTo: email)
          .get();
      List<String> orderIdList = querySnapshot.docs.map((e) => e.id).toList();
      return orderIdList;
    }catch(e){
      throw e;
    }
  }

    //get payment by timestamp in payment cubit
  Future<PaymentModel> getPaymentByTimestamp(Timestamp timestamp) async {
    QuerySnapshot querySnapshot = await _paymentCollection.where('paymentDateTime', isEqualTo: timestamp).get();
      Iterable<PaymentModel> payments = querySnapshot.docs.map((e) {
        return PaymentModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      });
      return payments.first;

  }

//get dining option that's stored by payment subcollection in order collection by order id
// Future<String?> getDiningOptionByOrderId(String orderId) async{
//   try {
//     DocumentReference orderRef = _orderCollection.doc(orderId);
//     Timestamp orderDateTime = await getOrderDateTimeByOrderId(orderId);
//     PaymentModel payment = await getPaymentByTimestamp(orderRef.orderDateTime);
//     } else {
//       throw Exception('No payment document found for order with order id $orderId');
//     }
//   } catch(e) {
//     throw e;
//   }
// }

}
