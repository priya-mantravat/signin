import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '/home.dart';
import '/dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController{
  var userId;
  Future<void>  signUp(email,password,firstname,lastname,phonenumber,address) async{
    try {
     CommonDialog.showLoading();
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password
      );
        print(userCredential);
        CommonDialog.hideLoading();

        try{
          CommonDialog.showLoading();
          var response =
              await FirebaseFirestore.instance.collection('userslist').add({
                'user_Id': userCredential.user!.uid,
                'firstname': firstname,
                'lastname' : lastname,
                 'email'   : email,
                'password' : password,
                'phonenumber': phonenumber,
                'address' : address,
                'joinDate': DateTime.now().millisecondsSinceEpoch,
              });
          print("Firebase response1111 ${response.id}");
          CommonDialog.hideLoading();
          Get.back();
        }catch (exception){
          CommonDialog.hideLoading();
          print("Error Saving data at firestore $exception");
        }
        Get.back();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
         CommonDialog.showErrorDialog(
             description: "The password provided is too weak.");
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        CommonDialog.showErrorDialog(
            description: "The account already exists for that email.");
        print('The account already exists for that email.');
      }
    } catch (e) {
      CommonDialog.hideLoading();
      CommonDialog.showErrorDialog(
        description: "Something went wrong."
      );
      print(e);
    }

  }
  Future<void> login(email,password) async{
    print('$email,$password');
    try {
      CommonDialog.showLoading();
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(),
          password: password
      );
      print(userCredential.user!.uid);
      userId = userCredential.user!.uid;
      CommonDialog.hideLoading();

      Get.off(HomeScreen());


    } on FirebaseAuthException catch (e) {
      CommonDialog.hideLoading();
      if (e.code == 'user-not-found') {
        CommonDialog.showErrorDialog(
            description: "No user found for that email.");
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        CommonDialog.showErrorDialog(
            description: "Wrong password provided for that user.");
        print('Wrong password provided for that user.');
      }
    }
  }
}