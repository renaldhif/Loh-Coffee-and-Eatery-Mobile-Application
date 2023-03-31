import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loh_coffee_eatery/models/user_model.dart';

class UserService{
  final CollectionReference _userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(UserModel user) async{
    try{
      await _userCollection.doc(user.id).set({
        'email': user.email,
        //'password': user.password,
        'name': user.name,
        'dob': user.dob,
        'role': user.role,
        'foodPreference': user.foodPreference,
      });
    }catch(e){
      throw e;
    }
  } 

  Future<UserModel> getUserById(String id)async{
    try{
      DocumentSnapshot documentSnapshot = await _userCollection.doc(id).get();
      return UserModel(
        id: documentSnapshot.id,
        email: documentSnapshot['email'],
        //password: documentSnapshot['password'],
        name: documentSnapshot['name'],
        dob: documentSnapshot['dob'],
        role: documentSnapshot['role'],
        foodPreference: documentSnapshot['foodPreference'].cast<String>(),
      );
    }catch(e){
      throw e;
    }
  }

  // Future<void> updateUser(UserModel user) async{
  //   try{
  //     getUserById(user.id).then((value) => {
  //       _userCollection.doc(user.id).update({
  //         'email': user.email,
  //         //'password': user.password,
  //         'name': user.name,
  //         'dob': user.dob,
  //         'role': user.role
  //       })
  //     });
  //   }catch(e){
  //     throw e;
  //   }
  // }
  Future<void> updateUser({required String id, required String name, required String email, required String dob}) async{
    await _userCollection.doc(id).update({
      'name': name,
      'email': email,
      'dob': dob,
    });
    // await _userCollection.doc().update({
    //   'name': name,
    //   'email': email,
    //   'dob': dob,
    // });
  }
  //   Future<void> updateUser({required UserModel user}) async{
  //   await _userCollection.doc().update({
  //     'name': user.name,
  //     'email': user.email,
  //     'dob': user.dob,
  //   });
  // }
  Future<String> getUserNameFromUID(String uid) async {

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();
    return snapshot.docs.first['name'];

  }

  // Get current user preferences
  Future<List<String>> getUserPreferences(String id) async {
    try {
      DocumentSnapshot documentSnapshot = await _userCollection.doc(id).get();
      return documentSnapshot['foodPreference'].cast<String>();
    } catch (e) {
      throw e;
    }
  }

  //update food preferences by uid
  Future<void> updateFoodPreferences({required String id, required List<String> foodPreference}) async{
    await _userCollection.doc(id).update({
      'foodPreference': foodPreference,
    });
  }
}