import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_test/models/add_complaint_model.dart';
import 'package:pro_test/screens/follow_complaints/cubit/states.dart';

import '../../../models/user_model.dart';
import '../../../resources/components.dart';

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
        print(e.data());
      }
      nameUser = users[0].name!;
      print(users);

      emit(GetUserSuccessState(users[0].name!));
    }).catchError((onError) {
      print(onError);
      emit(GetUserErrorState());
    });
  }
}
