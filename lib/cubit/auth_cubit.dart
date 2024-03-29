import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loh_coffee_eatery/models/user_model.dart';
import 'package:loh_coffee_eatery/services/auth_service.dart';
import 'package:loh_coffee_eatery/services/user_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void register({
    required String email,
    required String password,
    required String name,
    required String dob,
    String role = 'customer',
    List<String> foodPreference = const [],
    }) async {
    try {
      emit(AuthLoading());

      UserModel user = await AuthService().register(
        email: email, 
        password: password, 
        name: name, 
        dob: dob, 
        role: role,
        foodPreference: foodPreference,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signIn({required String email, required String password}) async {
    try {
      emit(AuthLoading());

      UserModel user =
          await AuthService().signIn(email: email, password: password);

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

    Future<UserModel> getCurrentUser(String id) async {
    try {
      UserModel user = await UserService().getUserById(id);

      return user;
    } catch (e) {
      throw e;
    }
  }

  void signOut() async {
    try {
      emit(AuthLoading());
      await AuthService().signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void resetPassword({required String email}) async {
    try {
      emit(AuthLoading());
      await AuthService().resetPassword(email);
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void updateUser({required String id, required String name, required String email, required String dob}) async {
    try {
      emit(AuthLoading());
      await UserService().updateUser(id: id,name: name, email: email, dob: dob);
      emit(AuthSuccessUpdate());
      UserModel user = await UserService().getUserById(id);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  Future<void> updateFoodPreferences({required String id, required List<String> foodPreference}) async{
    try{
      emit(AuthLoading());
      await UserService().updateFoodPreferences(id: id, foodPreference: foodPreference);
      emit(AuthSuccessUpdate());
      UserModel user = await UserService().getUserById(id);
      emit(AuthSuccess(user));
    }catch(e){
      emit(AuthFailed(e.toString()));
    }
  }

  Future<List<String>> getUserPreferences(String id) async{
    try{
      List<String> userPreferences = await UserService().getUserPreferences(id);
      return userPreferences;
    }catch(e){
      throw e;
    }
  }
}