part of 'app_cubit.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppInitial extends AppState {}

class AppSuccessState extends AppState {}

class AppLoadingState extends AppState {}

class AppErrorState extends AppState {}

class NavBarSelectState extends AppState {}
