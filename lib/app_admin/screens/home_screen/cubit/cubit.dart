import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_test/app_admin/screens/home_screen/cubit/states.dart';

import '../../../../resources/components.dart';
import '../../../models/event.dart';
import '../../notification/notification.dart';

class ComplaintsCubit extends Cubit<ComplaintsStates> {
  ComplaintsCubit() : super(ComplaintsInitialState());

  static ComplaintsCubit get(context) => BlocProvider.of(context);
  TextEditingController noteController = TextEditingController();

  List<ComplaintsModel> complaintsModel = [];
  List<ComplaintsModel> waiting = [];
  List<ComplaintsModel> prosses = [];
  List<ComplaintsModel> success = [];
  List<DateTime> dateTime = [];
  List? list;
  var w = 0.0;
  var p = 0.0;
  var s = 0.0;

  var rate = 0.0;
  var s1 = 0;
  var s2 = 0;
  var s3 = 0;
  var s4 = 0;
  var s5 = 0;
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
      }
      for (var element in complaintsModel) {
        dateTime.add(element.date!.toDate());

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
        w = (waiting.length / complaintsModel.length) * 100;
        p = (prosses.length / complaintsModel.length) * 100;
        s = (success.length / complaintsModel.length) * 100;
      }
      var r = (s5 * 5) + (s4 * 4) + (s3 * 3) + (s2 * 2) + (s1 * 1);

      if (s1 != 0 || s2 != 0 || s3 != 0 || s4 != 0 || s5 != 0) {
        rate = r / (s5 + s4 + s3 + s2 + s1);
      }

      emit(ComplaintsSuccessState());
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
          state: color == 1
              ? 'Process'
              : color == 2
                  ? 'Image'
                  : 'Completed',
        );

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
      emit(ComplaintsUpdateSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(ComplaintsUpdateErrorState());
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
      emit(ComplaintsUpdateErrorState());
    });
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
                    .update({
                  'image': val,
                  'color': 3,
                  'date': Timestamp.now(),
                }).then((value) {
                  FirebaseFirestore.instance
                      .collection('Users/')
                      .doc(id)
                      .collection('complaint')
                      .doc(id2)
                      .update({
                    'image': val,
                    'color': 3,
                    'date': Timestamp.now(),
                  }).then((value) {
                    sendNotification(
                      id2: id2,
                      token: token,
                      desc: description,
                      state: color == 1
                          ? 'Prosses'
                          : color == 2
                              ? 'Image'
                              : 'Completed',
                    );
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
