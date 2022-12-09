import 'package:firebase_auth/firebase_auth.dart';
import 'package:loh_coffee_eatery/models/user_model.dart';
import 'package:loh_coffee_eatery/services/user_service.dart';

class AuthService{
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel> register({
    required String email, 
    required String password, 
    required String name, 
    required String dob, 
    String role = 'customer'}) 
    async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      UserModel user = UserModel(
        id: userCredential.user!.uid, 
        email: email, 
        //password: password, 
        name: name, 
        dob: dob,
        role: 'customer');

        await UserService().addUser(user);

        return user;

    }catch(e){
      throw e;
    }
  }

  Future<UserModel> signIn({required String email, required String password}) async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password);
      UserModel user = await UserService().getUserById(userCredential.user!.uid);
      return user;
    }catch(e){
      throw e;
    }
  }

  Future<void> signOut() async{
    try{
      await _auth.signOut();
    }catch(e){
      throw e;
    }
  }
}