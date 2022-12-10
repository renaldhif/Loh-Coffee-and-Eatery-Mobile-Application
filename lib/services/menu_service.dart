import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loh_coffee_eatery/models/user_model.dart';
import '/models/menu_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path/path.dart';

class MenuService {
  final CollectionReference _menuCollection = FirebaseFirestore.instance.collection('menus');

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
    }) async {
    try {
      _menuCollection.add({
        'title' : title,
        'description' : description,
        'tag' : tag,
        'price' : price,
        'image' : image,
        'totalLoved' : totalLoved,
        'totalOrdered' : totalOrdered,
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

  // // get menu id
  // Future<MenuModel> getMenuById(String id) async {
  //   Future<List<MenuModel>> getMenuById() async {
  //   try {
  //     QuerySnapshot querySnapshot = await _menuCollection.get();
  //     List<MenuModel> menus = querySnapshot.docs.map((e) {
  //       return MenuModel.fromJson(e.id, e.data() as Map<String, dynamic>);
  //     }).toList();
    
  //     return menus;
  //   } catch (e) {
  //     throw e;
  //   }
  // }
  Future<MenuModel> getMenuById(String id) async {
    try {
      DocumentSnapshot documentSnapshot = await _menuCollection.doc(id).get();
      MenuModel menu = MenuModel.fromJson(documentSnapshot.id, documentSnapshot.data() as Map<String, dynamic>);
      return menu;
    } catch (e) {
      throw e;
    }
  }

  // update menu from edit menu page
  Future<void> updateMenu(MenuModel menu) async {
    try {
      await _menuCollection.doc(menu.id).update({
        'title': menu.title,
        'price': menu.price,
        'description': menu.description,
        'image': menu.image,
        'tag': menu.tag,
        'totalLoved': menu.totalLoved,
        'totalOrdered': menu.totalOrdered,
      });
    } catch (e) {
      throw e;
    }
  }


  // delete menu from edit menu page
  Future<void> deleteMenu(String id) async {
    try {
      await _menuCollection.doc(id).delete();
    } catch (e) {
      throw e;
    }
  }

//   Future<String> uploadImage(String path, String imageFile) async {
//     String fileName = basename(imageFile.path);
//     final Reference ref = _firebaseStorage.ref().child('$path/$fileName');
//     final UploadTask task = ref.putFile(imageFile);
//     final TaskSnapshot snapshot = await task.whenComplete(() => null);
//     final String downloadUrl = await snapshot.ref.getDownloadURL();

//     return downloadUrl;
//   }
}
