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
      return user;
    }catch(e){
      throw e;
    }
  }

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
      return user;
    }catch(e){
      throw e;
    }
  }

Future<void> signOut() async{
  try {
    // Close the Hive box if it is open
    var user = FirebaseAuth.instance.currentUser;
    if (user != null && Hive.isBoxOpen('isDarkModeBox_${user.uid}')) {
      await Hive.box<bool>('isDarkModeBox_${user.uid}').close();
    }

    // Sign out the user
    await _auth.signOut();
  } catch(e) {
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