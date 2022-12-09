import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/menu_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path/path.dart';

class MenuService {
  final CollectionReference _menuCollection = FirebaseFirestore.instance.collection('menus');

  // add menu from add menu page
  Future<void> addMenu(MenuModel menu) async {
    try {
      await _menuCollection.doc(menu.id).set({
        'name': menu.title,
        'price': menu.price,
        'description': menu.description,
        'image': menu.image,
        'tag': menu.tag,
        'total loved': menu.totalLoved,
        'total ordered': menu.totalOrdered,
      });
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

  // update menu from edit menu page
  Future<void> updateMenu(MenuModel menu) async {
    try {
      await _menuCollection.doc(menu.id).update({
        'name': menu.title,
        'price': menu.price,
        'description': menu.description,
        'image': menu.image,
        'tag': menu.tag,
        'total loved': menu.totalLoved,
        'total ordered': menu.totalOrdered,
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
