import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loh_coffee_eatery/models/user_model.dart';
import '/models/menu_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path/path.dart';

class MenuService {
  final CollectionReference _menuCollection =
      FirebaseFirestore.instance.collection('menus');

  // add menu from add menu page
  // Future<void> addMenu(MenuModel menu) async {
  Future<MenuModel> addMenu({
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
      _menuCollection.add({
        'title': title,
        'description': description,
        'tag': tag,
        'price': price,
        'image': image,
        'totalLoved': totalLoved,
        'totalOrdered': totalOrdered,
        'quantity': quantity,
        'userId': userId,
      });
      return MenuModel(
        id: '',
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
    } catch (e) {
      throw e;
    }
  }

  // get menu from menu page
  Future<List<MenuModel>> getMenus() async {
    try {
      QuerySnapshot querySnapshot = await _menuCollection.get();
      List<MenuModel> menus = querySnapshot.docs.map((e) {
        return MenuModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      }).toList();

      return menus;
    } catch (e) {
      throw e;
    }
  }

  Future<MenuModel> getMenuById(String id) async {
    try {
      DocumentSnapshot documentSnapshot = await _menuCollection.doc(id).get();
      MenuModel menu = MenuModel.fromJson(
          documentSnapshot.id, documentSnapshot.data() as Map<String, dynamic>);
      return menu;
    } catch (e) {
      throw e;
    }
  }

  // update menu from edit menu page
  Future<void> updateMenu(MenuModel menu, String title, String description,
      int price, String tag, String image) async {
    try {
      await _menuCollection.doc(menu.id).update({
        'title': title,
        'price': price,
        'description': description,
        'image': image,
        'tag': tag,
        // 'totalLoved': 0,
        // 'totalOrdered': 0,
        'quantity': 1,
      });
    } catch (e) {
      throw e;
    }
  }

  // delete menu from edit menu page
  Future<void> deleteMenu(MenuModel menu) async {
    try {
      await _menuCollection.doc(menu.id).delete();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addQuantity(MenuModel menu) async {
    try {
      await _menuCollection.doc(menu.id).update({
        'quantity': menu.quantity,
      });
    } catch (e) {
      throw e;
    }
  }

  Future<void> minusQuantity(MenuModel menu) async {
    try {
      await _menuCollection.doc(menu.id).update({
        'quantity': menu.quantity - 1,
      });
    } catch (e) {
      throw e;
    }
  }

  Future<void> addLikeMenu(MenuModel menu, String? uid) async {
    try {
      // Check if the user ID is already in the list
      bool isUserInList = menu.userId.contains(uid);
      print(menu.userId);

      if (!isUserInList) {
        // Add the user ID to the list and increment the totalLoved field
        await _menuCollection.doc(menu.id).update({
          'userId': FieldValue.arrayUnion([uid]),
        });
        await _menuCollection.doc(menu.id).update({
          'totalLoved': menu.totalLoved + 1,
        });
      } else {
        // Remove the user ID from the list and decrement the totalLoved field
        await _menuCollection.doc(menu.id).update({
          'userId': FieldValue.arrayRemove([uid]),
        });
        await _menuCollection.doc(menu.id).update({
          'totalLoved': menu.totalLoved - 1,
        });
      }
    } catch (e) {
      throw e;
    }
  }
}