// import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loh_coffee_eatery/models/user_model.dart';
import 'package:loh_coffee_eatery/services/user_service.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel> register({
  
    required String email, 
    required String password, 
    required String name, 
    required String dob, 
    String role = 'customer', 
    List<String> foodPreference = const [],
    }) 
    
    async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password,
      );
      
      UserModel user = UserModel(
        id: userCredential.user!.uid, 
        email: email, 
        //password: password, 
        name: name, 
        dob: dob,
        role: 'customer',
        foodPreference: foodPreference,
      );
      await UserService().addUser(user);
      if(user != null){
        await Hive.openBox<bool>('isDarkModeBox_${user.id}');
        await Hive.openBox<bool>('isLanguageEnglishBox_${user.id}');
      }
      return user;
      
    }catch(e){
      throw e;
    }
  }

  // Future<UserModel> signIn({
  //   required String email, 
  //   required String password
  // }) async{
  //   try{
  //     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  //       email: email, 
  //       password: password,
  //     );
  //     UserModel user = await UserService().getUserById(userCredential.user!.uid);
  //     var user2 = FirebaseAuth.instance.currentUser;
  //         await Hive.openBox<bool>('isLanguageEnglishBox_${user2!.uid}');
  //     return user;
  //   }catch(e){
  //     throw e;
  //   }
  // }
    Future<UserModel> signIn({
    required String email, 
    required String password
  }) async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password,
      );
      UserModel user = await UserService().getUserById(userCredential.user!.uid);
      
      if (user != null) {
        await Hive.openBox<bool>('isDarkModeBox_${user.id}');
      }
      
      var user2 = FirebaseAuth.instance.currentUser;
      if (user2 != null) {
        await Hive.openBox<bool>('isLanguageEnglishBox_${user2.uid}');
      }
      
      return user;
    }catch(e){
      throw e;
    }
  }

    Future<void> signOut() async{
    try{
      var user = FirebaseAuth.instance.currentUser;
      if (user != null && Hive.isBoxOpen('isLanguageEnglishBox_${user.uid}')) {
        await Hive.box<bool>('isLanguageEnglishBox_${user.uid}').close();
      }
      if (user != null && Hive.isBoxOpen('isDarkModeBox_${user.uid}')) {
      await Hive.box<bool>('isDarkModeBox_${user.uid}').close();
      }
      await _auth.signOut();
    }catch(e){
      throw e;
    }
}



  Future<void> resetPassword(String email) async{
    try{
      await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      throw e;
    }
  }
}