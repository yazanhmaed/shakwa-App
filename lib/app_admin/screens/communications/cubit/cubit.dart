import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_test/app_admin/screens/communications/cubit/states.dart';


import '../../../../resources/components.dart';
import '../../../models/add_communications_model.dart';
import '../../notification/notification.dart';

class CommunicationsCubit extends Cubit<CommunicationsStates> {
  CommunicationsCubit() : super(CommunicationsInitialState());

  static CommunicationsCubit get(context) => BlocProvider.of(context);

  List<CommunicationsModel> communications = [];
  List<DateTime> communicationsDate = [];
  List<CommunicationsModel> waiting = [];
  List<CommunicationsModel> prosses = [];
  List<CommunicationsModel> success = [];

  var w = 0.0;
  var p = 0.0;
  var s = 0.0;
 

  Future getCommunications() async {
    communications = [];
    communicationsDate = [];
    waiting = [];
    prosses = [];
    success = [];
    emit(CommunicationsLoadingState());
    await FirebaseFirestore.instance
        .collection('competentAuthority/')
        .doc(uIdA)
        .collection('complaint')
        .get()
        .then((value) {
      for (var e in value.docs) {
        communications.add(CommunicationsModel.fromJson(e.data()));
      }
      for (var element in communications) {
        communicationsDate.add(element.date!.toDate());
      }
          for (var element in communications) {
        if (element.state == 'Waiting') {
          waiting.add(element);
        } else if (element.state == 'Prosses') {
          prosses.add(element);
        } else if (element.state == 'Success') {
          success.add(element);
        }
        w = (waiting.length / communications.length) * 100;
        p = (prosses.length / communications.length) * 100;
        s = (success.length / communications.length) * 100;
      }

      emit(CommunicationsSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(CommunicationsErrorState(onError));
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
      getCommunications();
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

        emit(CommunicationsUpdateSuccessState());
      });
      emit(CommunicationsUpdateSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(CommunicationsUpdateErrorState());
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
      getCommunications();
      emit(CommunicationsRemoveSuccessState());
    }).catchError((onError) {
      emit(CommunicationsRemoveErrorState());
    });
  }
}
