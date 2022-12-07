import 'package:equatable/equatable.dart';

class UserModel extends Equatable{
  final String id;
  final String email;
  final String password;
  final String name;
  final String dob;
  final String role;

  UserModel({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.dob,
    this.role = 'customer'
  });


  @override
  // TODO: implement props
  List<Object?> get props => [id, email, password, name, dob, role];

  
}