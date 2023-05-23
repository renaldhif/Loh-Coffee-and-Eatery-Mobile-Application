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

  // get recommended menu from user's preference and menu's tag
  Future<List<MenuModel>> getRecommendedMenus(String userId) async {
    try {
      List<String> userPrefMenu = [];
      List<MenuModel> recommendedMenu = [];
      Set<String> addedMenuIds = {}; // Set to store already added menu IDs
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        final userData = userDoc.data();
        if (userData != null && userData.containsKey('foodPreference')) {
          userPrefMenu = List<String>.from(userData['foodPreference']);
        }

        // If there is only one food preference, store it in a single-element list
        if (userPrefMenu.length == 1) {
          userPrefMenu = [userPrefMenu.first];
        }
      }

      // Get the length of userPrefMenu
      int userPrefMenuLength = userPrefMenu.length;
      QuerySnapshot querySnapshot;

      //loop through the userPrefMenuLength
      for (int i = 0; i < userPrefMenuLength; i++) {
        //get the i index of the userPrefMenu
        String userPrefMenuIndex = userPrefMenu[i];

        if (userPrefMenu.isNotEmpty) {
          querySnapshot = await FirebaseFirestore.instance
              .collection('menus')
              .orderBy('totalLoved', descending: true)
              .orderBy('totalOrdered', descending: true)
              .limit(3) // limit 3 for each menu tag
              .get();

          // Iterate through each menu document
          querySnapshot.docs.forEach((doc) {
            Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

            if (data != null && data.containsKey('tag')) {
              // Extract the tag string from the menu document and split it into individual tags
              String tagString = data['tag'] as String;
              List<String> tags =
                  tagString.split(',').map((tag) => tag.trim()).toList();

              // Check if any of the tags partially match with the user's food preference
              bool hasPartialMatch =
                  tags.any((tag) => userPrefMenuIndex.contains(tag));
              // if (hasPartialMatch) {
              //   // Create a MenuModel object and add it to the recommendedMenu list
              //   recommendedMenu.add(MenuModel.fromJson(doc.id, data));
              // }

               // Check if menu ID is not already added and has a partial match
               // so it won't add the same menu twice
              if (!addedMenuIds.contains(doc.id) && hasPartialMatch) {
                recommendedMenu.add(MenuModel.fromJson(doc.id, data));
                addedMenuIds.add(doc.id); // Add the menu ID to the set
              }
            }
          });
        }
      }

      // However,
      // if user's menu preference is empty, return the most loved menu and ordered menu
      if (userPrefMenu.isEmpty) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('menus')
            .orderBy('totalLoved', descending: true)
            .orderBy('totalOrdered', descending: true)
            .limit(5)
            .get();

        // then add to recommendedMenu list
        querySnapshot.docs.forEach((doc) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

          if (data != null && data.containsKey('tag')) {
            recommendedMenu.add(MenuModel.fromJson(doc.id, data));
          }
        });
      }

      //return recommendedMenu limit to 5 menus
      return recommendedMenu.take(5).toList();
      // return recommendedMenu.toList();
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
