import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_test/models/add_complaint_model.dart';
import 'package:pro_test/screens/add_complaint/cubit/states.dart';

import '../../../resources/components.dart';

class AddComplaintCubit extends Cubit<AddComplaintStates> {
  AddComplaintCubit() : super(AddComplaintInitialState());

  static AddComplaintCubit get(context) => BlocProvider.of(context);

  Random r = Random();

 TextEditingController docController = TextEditingController();
  void complaint({
    String? id,
    required String userid,
    required String type,
    required String description,
    required String image,
    required String latitude,
    required String longitude,
    required String state,
    required int color,
    required Timestamp date,
    required String authority,
  }) {
    int rs = r.nextInt(999999);
    emit(AddComplaintLoadingState());
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
        latitude: latitude,
        longitude: longitude,
        state: state,
        color: color,
        date: date,
      );

      emit(AddComplaintSuccessState());
    }).catchError((onError) {
      emit(AddComplaintErrorState(onError));
    });
  }

  void complaintsuccess({
    required String id,
    required String type,
    required String description,
    required String image,
    required String latitude,
    required String longitude,
    required String state,
    required String authority,
    required int color,
    required Timestamp date,
  }) {
    int rs = r.nextInt(999999);
    emit(AddComplaintLoading2State());
    AddComplaintModel model = AddComplaintModel(
      id: uId,
      id2: '$rs',
      type: type,
      description: description,
      image: image,
      latitude: latitude,
      longitude: longitude,
      state: state,
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
        latitude: latitude,
        longitude: longitude,
        state: 'Waiting',
        authority: authority,
        color: 1,
        date: Timestamp.now(),
      );
      emit(AddComplaintSuccess2State());
    }).catchError((onError) {
      emit(AddComplaintError2State());
    });
  }

  void complaintauthority({
    String? id,
    String? id2,
    required String type,
    required String description,
    required String image,
    required String latitude,
    required String longitude,
    required String state,
    required String authority,
    required int color,
    required Timestamp date,
  }) {
    emit(AddComplaintLoadingState());

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
          latitude: latitude,
          longitude: longitude,
          state: state,
          authority: authority,
          color: color,
          date: date);
      emit(AddComplaintSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(AddComplaintErrorState(onError));
    });
  }

  void complaintAuthoritysuccess({
    required String id,
    required String id2,
    required String type,
    required String description,
    required String image,
    required String latitude,
    required String longitude,
    required String state,
    required String authority,
    required int color,
    required Timestamp date,
  }) {
    emit(AddComplaintLoading2State());
    AddComplaintModel model = AddComplaintModel(
      id: id,
      id2: id2,
      type: type,
      description: description,
      image: image,
      latitude: latitude,
      longitude: longitude,
      state: state,
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
      //emit(AddComplaintSuccess2State());
    });
  }

  void addComplaint({
    required String type,
    required String userid,
    required String description,
    required String latitude,
    required String longitude,
    required String authority,
  }) {
    emit(AddComplaintImagePicLoadingState());
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
            latitude: latitude,
            longitude: longitude,
            state: 'Waiting',
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
  Future<void> getImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.camera);
    if (pickerFile != null) {
      storieImage = File(pickerFile.path);
      emit(AddComplaintImagePicSuccessState());
    } else {
      print('No Image ');
      emit(AddComplainImagePicErrorState());
    }
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      emit(AddComplainGeolocatorState());
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        emit(AddComplainGeolocatorState());
        return Future.error('Location permissions are denied');
      }
      emit(AddComplainGeolocatorState());
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      emit(AddComplainGeolocatorState());
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    emit(AddComplainGeolocatorState());
    return await Geolocator.getCurrentPosition();
  }

  Position? position;
  Future<void> getGeo() async {
    position = await Geolocator.getCurrentPosition().whenComplete(() {
      // setState(() {});
      emit(AddComplainGeolocatorState());
    });
  }

  String? selectedValue;
  void changeSwitch(String value) {
    selectedValue = value;
    emit(AddComplainChangeSwitchState());
  }
}