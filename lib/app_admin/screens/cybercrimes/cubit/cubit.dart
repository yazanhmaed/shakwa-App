import 'package:cloud_firestore/cloud_firestore.dart';

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

  var w = 0.0;
  var p = 0.0;
  var s = 0.0;
 

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
      }
          for (var element in cyber) {
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

      emit(CyberCrimesSuccessState());
    }).catchError((onError) {
      print(onError);
      //emit(CyberCrimesErrorState(onError));
    });
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
          state: state == 'Waiting' ? 'Prosses' : 'Success',
        );

        emit(CyberCrimesUpdateSuccessState());
      });
      emit(CyberCrimesUpdateSuccessState());
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
