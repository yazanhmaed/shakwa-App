import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_test/app_admin/screens/login_screen/cubit/states.dart';

import '../../../../translations/locale_keys.g.dart';
import '../../../models/user_model.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(UserInitialState());
  static UserCubit get(context) => BlocProvider.of(context);
   List name = [
    LocaleKeys.Anti_Cyber_Crimes.tr(),
    LocaleKeys.Amman_City.tr(),
    LocaleKeys.Electric_Power.tr(),
    LocaleKeys.Agriculture.tr(),
    LocaleKeys.Communications.tr(),
    LocaleKeys.Environment.tr(),
    LocaleKeys.Miyahuna.tr(),
    LocaleKeys.Traffic_Department.tr(),
  ];

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
        .set(userModel.toMap())
        .then((value) {
      emit(AddCreateUserSuccessState());
    }).catchError((onError) {
      print(onError);
      // emit(AddCreateUserErrorState());
    });
  }

  List<UserModel> users = [];

  void getUser() async {
    users = [];
    emit(GetUserLoadingState());
    await FirebaseFirestore.instance.collection('Users/').get().then((value) {
      for (var e in value.docs) {
        users.add(UserModel.fromJson(e.data()));
        print(e.data());
      }
      emit(GetUserSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(GetUserErrorState());
    });
  }

  int positive = 0;
  void changecurrentSwitch({required int posit}) {
    positive = posit;
    emit(ChangeSuccessState());
  }
  String? selectedValue;
  void changeSwitch(String value) {
    selectedValue = value;
    emit(ComplainChangeSwitchState(value));
  }
}
