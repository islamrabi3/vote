import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voting_app/core/services/firebase_services.dart';
import 'package:voting_app/model/login_model.dart';
import 'package:voting_app/model/user_model.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(BuildContext context) => BlocProvider.of(context);

  UserModel? profileUserModel;
  getDataFromDB() async {
    try {
      emit(AppLoadingState());
      await FirebaseServicesHelper.getDataFromDb().then((value) {
        profileUserModel = UserModel.fromJson(value.data()!);
        print('email is ${profileUserModel!.email}');
      });
      emit(AppSuccessState());
    } on FirebaseException catch (e) {
      print(e.toString());
      emit(AppErrorState());
    }
  }
}
