import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_app/core/global.dart';
import 'package:voting_app/core/services/firebase_services.dart';
import 'package:voting_app/model/user_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);

  UserModel? userModel;
  UserCredential? userCredential;
  Future<void> createNewUser(
      {String? name,
      String? email,
      String? password,
      String? phoneNumber}) async {
    try {
      emit(ResgisterLoadingState());

      userCredential =
          await FirebaseServicesHelper.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );

      uid = userCredential!.user!.uid;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', uid);
      userModel = UserModel(
          name: name!,
          email: email,
          password: password,
          phoneNumber: phoneNumber!,
          uid: userCredential!.user!.uid);

      // Store user information to firestore DB
      await FirebaseServicesHelper.addInformationToFireStoreDB(
              user: 'users',
              docId: userCredential!.user!.uid,
              data: userModel!.toMap())
          .then((value) {
        print('data has been added');
      });

      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      emit(RegisterErrotState());
    }
  }

  // pick image
  File? image;
  String? imageUrl;
  Future pickImageAndSendItFireStorage(ImageSource source) async {
    final picker = ImagePicker();

    emit(UploadImageLoadingState());
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      image = File(pickedImage.path);
      emit(UploadImageSuccessState());
    } else {
      print('No image selected');
    }
  }

  File? idImage;
  ImagePicker picker = ImagePicker();
  String? idUrl;
  void pickProfileImage(ImageSource src, BuildContext context) async {
    var selectedImage = await picker.pickImage(source: src);
    if (selectedImage != null) {
      idImage = File(selectedImage.path);
      emit(UploadImageLoadingState());
      idUrl = await FirebaseServicesHelper.uploadImage(image: idImage!);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential!.user!.uid)
          .set({
        'name': userModel!.name,
        'email': userModel!.email,
        'phoneNumber': userModel!.phoneNumber,
        'password': userModel!.password,
        'uid': userCredential!.user!.uid,
        'idUrl': idUrl,
      });

      emit(UploadImageSuccessState());
    } else {
      print('No image Seleted');
    }
  }
}
