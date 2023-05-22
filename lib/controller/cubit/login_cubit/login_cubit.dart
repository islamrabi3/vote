import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_app/core/global.dart';
import 'package:voting_app/core/services/firebase_services.dart';
import 'package:voting_app/screens/home_layout_screen.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      emit(LoginLoadingState());

      FirebaseServicesHelper.login(email: email, password: password)
          .then((value) async {
        uid = value.user!.uid;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', uid);
        // ignore: use_build_context_synchronously
        navigateAndRemove(context, const HomeLayout());
      });

      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      emit(LoginErrotState());
    }
  }
}
