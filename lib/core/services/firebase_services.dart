import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirebaseServicesHelper {
  static final _firebaseInstance = FirebaseAuth.instance;
  static final _fireStore = FirebaseFirestore.instance;

  //creart user with email and password
  static Future<UserCredential> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    return await _firebaseInstance.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  // LOGIN FIREBASE METHOD

  static Future<UserCredential> login(
      {required String email, required String password}) async {
    return await _firebaseInstance.signInWithEmailAndPassword(
        email: email, password: password);
  }

// add data to firestore database.
  static Future<void> addInformationToFireStoreDB(
      {required String user,
      required String docId,
      required Map<String, dynamic> data}) async {
    await _fireStore.collection(user).doc(docId).set(data);
  }

  // upload Identification to Firebase Storage

  static Future<String> uploadImage({required File image}) async {
    try {
      final storageRef = firebase_storage.FirebaseStorage.instance.ref();
      final imageRef = storageRef
          .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = imageRef.putFile(image);
      final snapshot = await uploadTask;

      if (snapshot.state == firebase_storage.TaskState.success) {
        final downloadUrl = await imageRef.getDownloadURL();
        return downloadUrl;
      }
    } catch (e) {
      print('Error uploading image: $e');
    }

    return '';
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> getDataFromDb() async {
    return await _fireStore
        .collection('users')
        .doc(_firebaseInstance.currentUser!.uid)
        .get();
  }
}
