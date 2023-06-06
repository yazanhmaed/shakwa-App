import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_test/app_admin/screens/cybercrimes/cubit/states.dart';

import '../../../../resources/components.dart';
import '../../../models/cyber_crimes_model.dart';
import '../../notification/notification.dart';

class CyberCrimesCubit extends Cubit<CyberCrimesStates> {
  CyberCrimesCubit() : super(CyberCrimesInitialState());

  static CyberCrimesCubit get(context) => BlocProvider.of(context);

  List<CyberCrimesModel> cyber = [];
  List<DateTime> cyberDate = [];
  List<CyberCrimesModel> waiting = [];
  List<CyberCrimesModel> prosses = [];
  List<CyberCrimesModel> success = [];
  TextEditingController noteController = TextEditingController();

  var w = 0.0;
  var p = 0.0;
  var s = 0.0;

  var rate = 0.0;
  var s1 = 0;
  var s2 = 0;
  var s3 = 0;
  var s4 = 0;
  var s5 = 0;

  Future getCyberCrimes() async {
    cyber = [];
    cyberDate = [];
    waiting = [];
    prosses = [];
    success = [];
    emit(CyberCrimesLoadingState());
    await FirebaseFirestore.instance
        .collection('competentAuthority/')
        .doc(uIdA)
        .collection('complaint')
        .get()
        .then((value) {
      for (var e in value.docs) {
        cyber.add(CyberCrimesModel.fromJson(e.data()));
      }
      for (var element in cyber) {
        cyberDate.add(element.date!.toDate());

        if (element.rating != null && element.rating! == 1) {
          s1 = s1 + 1;
        } else if (element.rating != null && element.rating! == 2) {
          s2 = s2 + 1;
        } else if (element.rating != null && element.rating! == 3) {
          s3 = s3 + 1;
        } else if (element.rating != null && element.rating! == 4) {
          s4 = s4 + 1;
        } else if (element.rating != null && element.rating! == 5) {
          s5 = s5 + 1;
        }
        if (element.state == 'Waiting') {
          waiting.add(element);
        } else if (element.state == 'Prosses') {
          prosses.add(element);
        } else if (element.state == 'Success') {
          success.add(element);
        }
        w = (waiting.length / cyber.length) * 100;
        p = (prosses.length / cyber.length) * 100;
        s = (success.length / cyber.length) * 100;
      }
      var r = (s5 * 5) + (s4 * 4) + (s3 * 3) + (s2 * 2) + (s1 * 1);
      if (s1 != 0 || s2 != 0 || s3 != 0 || s4 != 0 || s5 != 0) {
        rate = r / (s5 + s4 + s3 + s2 + s1);
      }

      emit(CyberCrimesSuccessState());
    }).catchError((onError) {
      print(onError);
    });
  }

  Future changeDraw({required bool dr, required BuildContext context}) async {
    draw = dr;
    draw == false
        ? await context.setLocale(Locale('en'))
        : await context.setLocale(Locale('ar'));
    emit(ChangeDrawState());
  }

  void updateData({
    required int color,
    required String id2,
    required String id,
    required String token,
    required String description,
    required String state,
  }) {
    FirebaseFirestore.instance
        .collection('competentAuthority')
        .doc(uIdA)
        .collection('complaint')
        .doc(id2)
        .update({
      'color': color < 2 ? color + 1 : 3,
      'date': Timestamp.now(),
      'state': color == 1 ? 'Prosses' : 'Success'
    }).then((value) {
      getCyberCrimes();
      FirebaseFirestore.instance
          .collection('Users/')
          .doc(id)
          .collection('complaint')
          .doc(id2)
          .update({
        'color': color < 2 ? color + 1 : 3,
        'date': Timestamp.now(),
        'state': color == 1 ? 'Prosses' : 'Success'
      }).then((value) {
        sendNotification(
          id2: id2,
          token: token,
          desc: description,
          state: state == 'Waiting' ? 'Process' : 'Completed',
        );

        emit(CyberCrimesUpdateSuccessState());
      });
      emit(CyberCrimesUpdateSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(CyberCrimesUpdateErrorState());
    });
  }

  void updateNote({
    required String id2,
    required String id,
    required String note,
    required String token,
  }) {
    FirebaseFirestore.instance
        .collection('competentAuthority')
        .doc(uIdA)
        .collection('complaint')
        .doc(id2)
        .update({
      'note': note,
    }).then((value) {
      emit(CyberCrimesUpdateSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(CyberCrimesUpdateErrorState());
    }).then((value) {
      FirebaseFirestore.instance
          .collection('Users')
          .doc(id)
          .collection('complaint')
          .doc(id2)
          .update({
        'note': note,
      }).then((value) {
        sendNotification(
          id2: id2,
          token: token,
          desc: '',
          state: 'Add Note',
        );
      });
    }).catchError((onError) {
      print(onError);
      emit(CyberCrimesUpdateErrorState());
    });
  }

  void removeComplaint({
    required String id2,
  }) {
    FirebaseFirestore.instance
        .collection('competentAuthority/')
        .doc(uIdA)
        .collection('complaint')
        .doc(id2)
        .delete()
        .then((value) {
      getCyberCrimes();
      emit(CyberCrimesRemoveSuccessState());
    }).catchError((onError) {
      emit(CyberCrimesRemoveErrorState());
    });
  }
}
