import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final String uid;

  const UserModel(
      {required this.name,
      required this.email,
      required this.password,
      required this.phoneNumber,
      required this.uid});

  // name constuctor
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      uid: json['uid']);

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
        'uid': uid
      };
  @override
  List<Object?> get props => [name, email, password, phoneNumber, uid];
}
