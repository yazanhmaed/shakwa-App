import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pro_test/screens/login_screen/cubit/states.dart';

import '../../../models/user_model.dart';
import '../../../resources/components.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(UserInitialState());
  static UserCubit get(context) => BlocProvider.of(context);

  List<UserModel> userModel = [];
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  userLogin({
    required String email,
    required String password,
  }) {
    emit(UserLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(UserSuccessState(value.user!.uid));
    }).catchError((onError) {
      print(onError);
      emit(UserErrorState());
    });
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
  }) {
    emit(AddUserLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
        uId: value.user!.uid,
        name: name,
        email: email,
      );
      emit(AddUserSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(AddUserErrorState(onError.toString()));
    });
  }

  userCreate({
    required String uId,
    required String name,
    required String email,
  }) {
    UserModel userModel = UserModel(
      name: name,
      uId: uId,
      email: email,
    );
    emit(AddCreateUserLoadingState());
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .collection('profile')
        .doc()
        .set(userModel.toMap())
        .then((value) {
      emit(AddCreateUserSuccessState());
    }).catchError((onError) {
      print(onError);
      // emit(AddCreateUserErrorState());
    });
  }

  String? userid;
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential

    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      userCreate(
          uId: value.user!.uid,
          email: value.user!.email!,
          name: value.user!.displayName!);

      emit(UserSuccessState(value.user!.uid));
    }).catchError((onError) {
      print(onError);
      // emit(UserErrorState());
    });
  }

  Future logout() async {
    FirebaseAuth.instance.signOut().then((value) {
      googleSignIn.disconnect();
      print(token);
      emit(LogoutSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(LogoutErrorState());
    });
  }

  void getEmailVerify() {
    FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
      Fluttertoast.showToast(
          msg: 'Check your Email',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      emit(EmailVerifySuccessState());
    }).catchError((onError) {
      emit(EmailVerifyErrorState());
    });
  }

  void getPassword({
    required String email,
  }) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      emit(PasswordResetSuccessState());
    }).catchError((onError) {
      Fluttertoast.showToast(
          msg: 'Check your Email',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      emit(PasswordResetErrorState());
    });
  }

  int positive = 0;
  void changecurrentSwitch({required int posit}) {
    positive = posit;
    emit(ChangeSuccessState());
  }

  bool obscureText = true;
  void changeobscureText() {
    obscureText = !obscureText;
    print(obscureText);
    emit(ChangeobscureTextSuccessState());
  }
}
