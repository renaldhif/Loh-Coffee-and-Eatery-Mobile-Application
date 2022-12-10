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
        'role': user.role
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
        role: documentSnapshot['role']
      );
    }catch(e){
      throw e;
    }
  }

  Future<void> updateUser({required String id, required String name, required String email, required String dob}) async{
    await _userCollection.doc(id).update({
      'name': name,
      'email': email,
      'dob': dob,
    });
  }
}