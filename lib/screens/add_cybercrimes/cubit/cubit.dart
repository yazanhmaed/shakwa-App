import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_test/screens/add_cybercrimes/cubit/states.dart';

import '../../../models/addcybercrimes_model.dart';
import '../../../resources/components.dart';

class AddCyberCrimesCubit extends Cubit<AddCyberCrimesStates> {
  AddCyberCrimesCubit() : super(AddCyberCrimesInitialState());

  static AddCyberCrimesCubit get(context) => BlocProvider.of(context);

  Random r = Random();

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
        color: color,
        date: date,
      );

      emit(AddCyberCrimesSuccessState());
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
      link:link ,
      social: social,
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
        link: link,
        social: social,
        state: 'Waiting',
        authority: authority,
        color: 1,
        date: Timestamp.now(),
      );
      emit(AddCyberCrimesSuccess2State());
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
          authority: authority,
          color: color,
          date: date);
      emit(AddCyberCrimesSuccessState());
    }).catchError((onError) {
      print(onError);
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
      //emit(AddCyberCrimesSuccess2State());
    });
  }

  void addCyberCrimes({
    required String type,
    required String userid,
    required String description,
    required String link,
    required String social,
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
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      storieImage = File(pickerFile.path);
      emit(AddCyberCrimesImagePicSuccessState());
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
  String? selectedValue2;
  void changeSwitch2(String value) {
    selectedValue2 = value;
    emit(AddComplainChangeSwitch2State());
  }
}
