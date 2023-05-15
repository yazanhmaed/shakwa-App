import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_test/app_admin/screens/home_screen/cubit/states.dart';

import '../../../../resources/components.dart';
import '../../../models/event.dart';
import '../../notification/notification.dart';

class ComplaintsCubit extends Cubit<ComplaintsStates> {
  ComplaintsCubit() : super(ComplaintsInitialState());

  static ComplaintsCubit get(context) => BlocProvider.of(context);

  List<ComplaintsModel> complaintsModel = [];
  List<ComplaintsModel> waiting = [];
  List<ComplaintsModel> prosses = [];
  List<ComplaintsModel> success = [];
  List<DateTime> dateTime = [];

  var w = 0.0;
  var p = 0.0;
  var s = 0.0;

  Future getComplaints() async {
    complaintsModel = [];
    dateTime = [];
    waiting = [];
    prosses = [];
    success = [];

    emit(ComplaintsLoadingState());
    await FirebaseFirestore.instance
        .collection('competentAuthority/')
        .doc(uIdA)
        .collection('complaint')
        .get()
        .then((value) {
      for (var e in value.docs) {
        complaintsModel.add(ComplaintsModel.fromJson(e.data()));
        //  print(e.data());
      }
      for (var element in complaintsModel) {
        dateTime.add(element.date!.toDate());
      }
     
      //print(dateTime2);

      for (var element in complaintsModel) {
        if (element.state == 'Waiting') {
          waiting.add(element);
        } else if (element.state == 'Prosses') {
          prosses.add(element);
        } else if (element.state == 'Success') {
          success.add(element);
        }
        w = (waiting.length / complaintsModel.length) * 100;
        p = (prosses.length / complaintsModel.length) * 100;
        s = (success.length / complaintsModel.length) * 100;
      }

      emit(ComplaintsSuccessState());
    }).catchError((onError) {
      print(onError);
      //emit(ComplaintsErrorState());
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
      'color': color < 2 ? color + 1 : 4,
      'date': Timestamp.now(),
      'state': color == 1
          ? 'Prosses'
          : color == 2
              ? 'Image'
              : 'Success'
    }).then((value) {
      getComplaints();
      FirebaseFirestore.instance
          .collection('Users/')
          .doc(id)
          .collection('complaint')
          .doc(id2)
          .update({
        'color': color < 2 ? color + 1 : 4,
        'date': Timestamp.now(),
        'state': color == 1
            ? 'Prosses'
            : color == 2
                ? 'Image'
                : 'Success',
      }).then((value) {
        sendNotification(
            id2: id2,
            token: token,
            desc: description,
            state: state == 'Waiting'
                ? 'Prosses'
                : state == 'Prosses'
                    ? 'Image'
                    : 'Success');

        //emit(ComplaintsUpdateSuccessState());
      });
      emit(ComplaintsUpdateSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(ComplaintsUpdateErrorState());
    });
  }

  File? storieImage;
  var picker = ImagePicker();
  Future<void> getImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.camera);
      emit(AddComplaintImagelOADINGState());
    if (pickerFile != null) {
      storieImage = File(pickerFile.path);

      emit(AddComplaintImagePicSuccessState());
    } else {
      print('No Image ');
      emit(AddComplaintImagePicErrorState());
    }
  }

  void updateImage({
    required int color,
    required String id,
    required String id2,
    required String token,
    required String description,
    required String state,
  }) {
    emit(AddComplaintImagelOADINGState());
    FirebaseStorage.instance
        .ref()
        .child(
            'complaint/$uIdA/${Uri.file(storieImage!.path).pathSegments.last}')
        .putFile(storieImage!)
        .then((value) => {
              value.ref.getDownloadURL().then((val) {
                FirebaseFirestore.instance
                    .collection('competentAuthority')
                    .doc(uIdA)
                    .collection('complaint')
                    .doc(id2)
                    .update({'image': val, 'color': 3}).then((value) {
                  // getComplaints();
                  FirebaseFirestore.instance
                      .collection('Users/')
                      .doc(id)
                      .collection('complaint')
                      .doc(id2)
                      .update({'image': val, 'color': 3}).then((value) {
                    sendNotification(
                        id2: id2,
                        token: token,
                        desc: description,
                        state: state == 'Waiting' ? 'Prosses' : 'Image');
                    emit(ComplaintsUpdateSuccessState());
                  });
                  emit(ComplaintsUpdateSuccessState());
                }).catchError((onError) {
                  print(onError);
                  emit(ComplaintsUpdateError2State());
                });
              })
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
      getComplaints();
      emit(ComplaintsRemoveSuccessState());
    }).catchError((onError) {
      emit(ComplaintsRemoveErrorState());
    });
  }
}
