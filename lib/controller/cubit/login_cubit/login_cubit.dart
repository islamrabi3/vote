import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_app/core/global.dart';
import 'package:voting_app/core/services/firebase_services.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> login(String email, String password) async {
    try {
      emit(LoginLoadingState());
      UserCredential userAuth =
          await FirebaseServicesHelper.login(email: email, password: password);
      uid = userAuth.user!.uid;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', uid);
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      emit(LoginErrotState());
    }
  }
}
