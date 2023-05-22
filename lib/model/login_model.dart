import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
  final String email;
  final String password;

  const LoginModel({
    required this.email,
    required this.password,
  });

  // name constuctor
  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        email: json['email'],
        password: json['password'],
      );

  Map<String, dynamic> toMap() => {
        'email': email,
        'password': password,
      };
  @override
  List<Object?> get props => [email, password];
}
