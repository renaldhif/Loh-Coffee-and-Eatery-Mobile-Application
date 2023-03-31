import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  //final String password;
  final String name;
  final String dob;
  final String role;
  final List<String> foodPreference;

  const UserModel({
    required this.id,
    required this.email,
    //required this.password,
    required this.name,
    required this.dob,
    this.role = 'customer',
    this.foodPreference = const [],
  });

  factory UserModel.fromJson(String id, Map<String, dynamic> json) {
    return UserModel(
      id: id,
      email: json['email'],
      //password: json['password'],
      name: json['name'],
      dob: json['dob'],
      role: json['role'],
      // foodPreference: List<String>.from(json['foodPreference'])
      foodPreference: List<String>.from(json['foodPreference'] as List<dynamic>).cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      //'password': password,
      'name': name,
      'dob': dob,
      'role': role,
      'foodPreference': foodPreference,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, email, name, dob, role, foodPreference];
}