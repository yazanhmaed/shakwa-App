import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';
import 'package:pro_test/app_user/screens/add_cybercrimes/cubit/states.dart';

import '../../../../resources/components.dart';
import '../../../models/addcybercrimes_model.dart';

class AddCyberCrimesCubit extends Cubit<AddCyberCrimesStates> {
  AddCyberCrimesCubit() : super(AddCyberCrimesInitialState());

  static AddCyberCrimesCubit get(context) => BlocProvider.of(context);

  Random r = Random();
  var token = '';

  TextEditingController docController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  void complaint({
    String? id,
    required String userid,
    required String type,
    required String description,
    required String image,
    required String link,
    required String social,
    required String state,
    required String token,
    required int color,
    required Timestamp date,
    required String authority,
  }) {
    int rs = r.nextInt(999999);
    emit(AddCyberCrimesLoadingState());
    FirebaseFirestore.instance
        .collection('Users/')
        .doc(userid)
        .collection('complaint')
        .doc()
        .get()
        .then((value) {
      id = '$rs';

      complaintsuccess(
        id: id!,
        type: type,
        authority: authority,
        description: description,
        image: image,
        link: link,
        social: social,
        state: state,
        token: token,
        color: color,
        date: date,
      );

      //emit(AddCyberCrimesSuccessState());
    }).catchError((onError) {
      emit(AddCyberCrimesErrorState(onError));
    });
  }

  void complaintsuccess({
    required String id,
    required String type,
    required String description,
    required String image,
    required String link,
    required String social,
    required String state,
    required String token,
    required String authority,
    required int color,
    required Timestamp date,
  }) {
    int rs = r.nextInt(999999);
    emit(AddCyberCrimesLoading2State());
    AddCyberCrimesModel model = AddCyberCrimesModel(
      id: uId,
      id2: '$rs',
      type: type,
      description: description,
      image: image,
      link: link,
      social: social,
      state: state,
      token: token,
      color: color,
      date: date,
    );
    FirebaseFirestore.instance
        .collection('Users/')
        .doc(uId)
        .collection('complaint/')
        .doc('$rs')
        .set(model.toMap())
        .then((value) {
      complaintauthority(
        id2: '$rs',
        type: type,
        description: description,
        image: image,
        link: link,
        social: social,
        state: 'Waiting',
        token: token,
        authority: authority,
        color: 1,
        date: Timestamp.now(),
      );
      // emit(AddCyberCrimesSuccess2State());
    }).catchError((onError) {
      emit(AddCyberCrimesError2State());
    });
  }

  void complaintauthority({
    String? id,
    String? id2,
    required String type,
    required String description,
    required String image,
    required String link,
    required String social,
    required String state,
    required String token,
    required String authority,
    required int color,
    required Timestamp date,
  }) {
    emit(AddCyberCrimesLoadingState());

    FirebaseFirestore.instance
        .collection('competentAuthority/')
        .doc(authority)
        .collection('complaint')
        .doc(id2)
        .get()
        .then((value) {
      complaintAuthoritysuccess(
          id: uId!,
          id2: id2!,
          type: type,
          description: description,
          image: image,
          link: link,
          social: social,
          state: state,
          token: token,
          authority: authority,
          color: color,
          date: date);
      // emit(AddCyberCrimesSuccessState());
    }).catchError((onError) {
      // print(onError);
      emit(AddCyberCrimesErrorState(onError));
    });
  }

  void complaintAuthoritysuccess({
    required String id,
    required String id2,
    required String type,
    required String description,
    required String image,
    required String link,
    required String social,
    required String state,
    required String token,
    required String authority,
    required int color,
    required Timestamp date,
  }) {
    emit(AddCyberCrimesLoading2State());
    AddCyberCrimesModel model = AddCyberCrimesModel(
      id: id,
      id2: id2,
      type: type,
      description: description,
      image: image,
      link: link,
      social: social,
      state: state,
      token: token,
      color: color,
      date: date,
    );
    FirebaseFirestore.instance
        .collection('competentAuthority/')
        .doc(authority)
        .collection('complaint/')
        .doc(id2)
        .set(model.toMap())
        .then((value) {
      emit(AddCyberCrimesSuccessState());
    });
  }

  void addCyberCrimes({
    required String type,
    required String userid,
    required String description,
    required String link,
    required String social,
    required String token,
    required String authority,
  }) {
    emit(AddCyberCrimesImagePicLoadingState());
    FirebaseStorage.instance
        .ref()
        .child(
            'complaint/$authority/${Uri.file(storieImage!.path).pathSegments.last}')
        .putFile(storieImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        complaint(
            userid: userid,
            type: type,
            description: description,
            image: value,
            link: link,
            social: social,
            state: 'Waiting',
            token: token,
            color: 1,
            date: Timestamp.now(),
            authority: authority);
      }).catchError((onError) {
        emit(AddComplainImagePicErrorState());
      });
    }).catchError((onError) {
      print(onError);
      emit(AddComplainImagePicErrorState());
    });
  }

  File? storieImage;
  var picker = ImagePicker();
  String imagename = '';
  Future<void> getImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      storieImage = File(pickerFile.path);
      imagename = pickerFile.name;
      print(pickerFile.name);
      emit(AddCyberCrimesImagePicSuccessState());
    } else {
      print('No Image ');
      emit(AddComplainImagePicErrorState());
    }
  }

  String? selectedValue;
  void changeSwitch(String value) {
    selectedValue = value;
    emit(AddComplainChangeSwitchState());
  }

  String? selectedValue2;
  void changeSwitch2(String value) {
    selectedValue2 = value;
    emit(AddComplainChangeSwitch2State());
  }
}
