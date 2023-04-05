import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loh_coffee_eatery/models/user_model.dart';
import '/models/menu_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path/path.dart';

class MenuService {
  final CollectionReference _menuCollection =
      FirebaseFirestore.instance.collection('menus');

  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

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
      print('getMenus() executed');

      return menus;
    } catch (e) {
      throw e;
    }
  }

  //* Refix the queries
  // Future<List<MenuModel>> getRecommendedMenus(String userId) async {
  //   try {
  //     List<String> userPrefMenu = [];
  //     List<String> tagArrayMenu = [];

  //     final userDoc = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(userId)
  //         .get();

  //     if (userDoc.exists) {
  //       print('user doc exist');
  //       final userData = userDoc.data();
  //       if (userData != null && userData.containsKey('foodPreference')) {
  //         userPrefMenu = List<String>.from(userData['foodPreference']);
  //         print('userPrefMenu block if: $userPrefMenu');
  //       }
  //     }

  //     QuerySnapshot querySnapshot;

  //     querySnapshot = await _menuCollection.get();
  //     final menuDocs = querySnapshot.docs;
  //     for (var doc in menuDocs) {
  //       var data = doc.data() as Map<String, dynamic>;
  //       var tag = data['tag'] as String;
  //       if (tag != null && tag.isNotEmpty) {
  //         tagArrayMenu
  //             .addAll(tag.split(',')); // assigned in the array separated by ","
  //       }
  //       print('printing array of tag menu:');
  //       print(tagArrayMenu);
  //     }
  //     // if userPrefMenu is not empty, then get recommended menu based on userPrefMenu
  //     if (userPrefMenu.isNotEmpty) {
  //       // convert userPrefMenu into a regex pattern
  //       final userPrefMenuStr = userPrefMenu.join('|');
  //       final regex = RegExp(userPrefMenuStr, caseSensitive: false);

  //       querySnapshot = await FirebaseFirestore.instance
  //           .collection('menus')
  //           .where('tag', arrayContainsAny: userPrefMenu)
  //           // .orderBy('tag')
  //           .orderBy('totalLoved', descending: true)
  //           .orderBy('totalOrdered', descending: true)
  //           .limit(3)
  //           .get();

  //       print('This is block if userPrefMenu is NOT empty');
  //       print('querySnapshot if userPrefMenu is NOT empty: $querySnapshot');
  //     }
  //     // else get recommended menu based on totalLoved and totalOrdered and limit to 3 menus
  //     else {
  //       querySnapshot = await _menuCollection
  //           .orderBy('totalLoved', descending: true)
  //           .orderBy('totalOrdered', descending: true)
  //           .limit(3)
  //           .get();
  //       print('this else block is executed means it is empty');
  //       print('querySnapshot if userPrefMenu is empty: $querySnapshot');
  //     }

  //     print('Number of documents returned: ${querySnapshot.docs.length}');
  //     print('getRecommendedMenus executed in menu service');

  //     final menuDocs = querySnapshot.docs;
  //     final recommendedMenus = menuDocs
  //         .map((doc) =>
  //             MenuModel.fromJson(doc.id, doc.data() as Map<String, dynamic>))
  //         .toList();

  //     return recommendedMenus;
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  //* BACKUP CODE getRecommendedMenus()
  Future<List<MenuModel>> getRecommendedMenus(String userId) async {
    try {
      List<String> userPrefMenu = [];
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        print('user doc exist');
        final userData = userDoc.data();
        if (userData != null && userData.containsKey('foodPreference')) {
          userPrefMenu = List<String>.from(userData['foodPreference']);
          // print('userPrefMenu block if: $userPrefMenu');
        }
      }

      QuerySnapshot querySnapshot;
      if (userPrefMenu.isNotEmpty) {
        String userPrefMenuStr = userPrefMenu.join(',');
        querySnapshot = await FirebaseFirestore.instance
            .collection('menus')
            .where('tag', whereIn: userPrefMenu)
            .orderBy('totalLoved', descending: true)
            .orderBy('totalOrdered', descending: true)
            .limit(3)
            .get();
      } else {
        querySnapshot = await FirebaseFirestore.instance
            .collection('menus')
            .orderBy('totalLoved', descending: true)
            .orderBy('totalOrdered', descending: true)
            .limit(3)
            .get();
      }

      final menuDocs = querySnapshot.docs;
      final recommendedMenus = menuDocs
          .map((doc) =>
              MenuModel.fromJson(doc.id, doc.data() as Map<String, dynamic>))
          .toList();


      // final menuDocs = querySnapshot.docs;
      // List<MenuModel> recommendedMenus;
      // if (menuDocs.isNotEmpty) {
      //   recommendedMenus = menuDocs
      //       .map((doc) =>
      //           MenuModel.fromJson(doc.id, doc.data() as Map<String, dynamic>))
      //       .toList();
      // } else {
      //   recommendedMenus = await getTop3MenusBasedOnTotalLovedAndOrdered();
      // }

      return recommendedMenus;
    } catch (e) {
      throw e;
    }
  }

  // Future<List<MenuModel>> getTop3MenusBasedOnTotalLovedAndOrdered() async {
  //   bool isTop3Menus = true;
  //   try {
  //     final querySnapshot = await FirebaseFirestore.instance
  //         .collection('menus')
  //         .orderBy('totalLoved', descending: true)
  //         .orderBy('totalOrdered', descending: true)
  //         .limit(3)
  //         .get();

  //     final menuDocs = querySnapshot.docs;
  //     final recommendedMenus = menuDocs
  //         .map((doc) =>
  //             MenuModel.fromJson(doc.id, doc.data() as Map<String, dynamic>))
  //         .toList();

  //     // return true if function is executed and recommendedMenus is not empty
  //     return recommendedMenus;
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  // Future<bool> isTop3Menus() async {
  //   try {
  //     bool isTop3Menus = _getTop3MenusBasedOnTotalLovedAndOrdered().isNotEmpty;
  //   } catch (e) {
  //     throw e;
  //   }
  // }

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

  //update totalOrdered field in menu collection
  Future<void> updateTotalOrdered(MenuModel menu) async {
    try {
      await _menuCollection.doc(menu.id).update({
        'totalOrdered': menu.totalOrdered + 1,
      });
    } catch (e) {
      throw e;
    }
  }
}
