import 'package:equatable/equatable.dart';

class UserModel extends Equatable{
  final String id;
  final String email;
  //final String password;
  final String name;
  final String dob;
  final String role;

  const UserModel({
    required this.id,
    required this.email,
    //required this.password,
    required this.name,
    required this.dob,
    this.role = 'customer'
  });

  factory UserModel.fromJson(String id, Map<String, dynamic> json) {
    return UserModel(
      id: id,
      email: json['email'],
      //password: json['password'],
      name: json['name'],
      dob: json['dob'],
      role: json['role']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      //'password': password,
      'name': name,
      'dob': dob,
      'role': role
    };
  }


  @override
  // TODO: implement props
  List<Object?> get props => [id, email, name, dob, role];


}