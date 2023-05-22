part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class ResgisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterErrotState extends RegisterState {}

class UploadImageLoadingState extends RegisterState {}

class UploadImageSuccessState extends RegisterState {}

class UploadImageErrorState extends RegisterState {}
