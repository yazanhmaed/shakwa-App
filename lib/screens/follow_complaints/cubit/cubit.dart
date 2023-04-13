import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_test/models/add_complaint_model.dart';
import 'package:pro_test/screens/follow_complaints/cubit/states.dart';

import '../../../models/user_model.dart';
import '../../../resources/components.dart';
import '../../../translations/locale_keys.g.dart';

class FollowComplaintsCubit extends Cubit<FollowComplaintsStates> {
  FollowComplaintsCubit() : super(FollowComplaintsInitialState());

  static FollowComplaintsCubit get(context) => BlocProvider.of(context);

  List<AddComplaintModel> followComplaints = [];
  List<AddComplaintModel> prossesComplaints = [];
  List<AddComplaintModel> completeComplaints = [];

  Future getFollowComplaints() async {
    followComplaints = [];
    emit(FollowComplaintsLoadingState());
    await FirebaseFirestore.instance
        .collection('Users/')
        .doc(uId)
        .collection('complaint')
        .get()
        .then((value) {
      for (var e in value.docs) {
        followComplaints.add(AddComplaintModel.fromJson(e.data()));
      }
      followComplaints.forEach((element) {
        if (element.state == 'Success') {
          completeComplaints.add(element);
        } else {
          prossesComplaints.add(element);
        }
      });

      emit(FollowComplaintsSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(FollowComplaintsErrorState());
    });
  }

  List<UserModel> users = [];

  void getUser() async {
    users = [];
    emit(GetUserLoadingState());
    await FirebaseFirestore.instance
        .collection('Users/')
        .doc('$uId')
        .collection('profile')
        .get()
        .then((value) {
      for (var e in value.docs) {
        users.add(UserModel.fromJson(e.data()));
        //print(e.data());
      }
      nameUser = users[0].name!;
      // print(users);

      emit(GetUserSuccessState(users[0].name!));
    }).catchError((onError) {
      print(onError);
      emit(GetUserErrorState());
    });
  }

  // bool draw = false;
   Future changeDraw(BuildContext context) async {
    draw != false
        ? await context.setLocale(Locale('en'))
        : await context.setLocale(Locale('ar'));
    draw = !draw!;
    print(draw);
    emit(ChangeDrawState());
  }

  List name = [];
  Future n() async {
    emit(GetnameLoadingState());
    name = [
      LocaleKeys.Anti_Cyber_Crimes.tr(),
      LocaleKeys.Amman_City.tr(),
      LocaleKeys.Electric_Power.tr(),
      LocaleKeys.Agriculture.tr(),
      LocaleKeys.Communications.tr(),
      LocaleKeys.Environment.tr(),
      LocaleKeys.Miyahuna.tr(),
      LocaleKeys.Traffic_Department.tr(),
    ];
    emit(GetnameState());
  }
}
