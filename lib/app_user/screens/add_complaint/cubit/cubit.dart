import 'dart:io';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_test/app_user/screens/add_complaint/cubit/states.dart';

import '../../../../resources/color_manager.dart';
import '../../../../resources/components.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../models/add_complaint_model.dart';
import '../../drawer_screen/drawer_screen.dart';

class AddComplaintCubit extends Cubit<AddComplaintStates> {
  AddComplaintCubit() : super(AddComplaintInitialState());

  static AddComplaintCubit get(context) => BlocProvider.of(context);

  Random r = Random();
  var token = '';

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
    required String token,
    required String competent,
    required int color,
    required Timestamp date,
    required Timestamp timeSpent,
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
        token: token,
        competent: competent,
        color: color,
        date: date,
        timeSpent: timeSpent,
      );

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
    required String token,
    required String competent,
    required String authority,
    required int color,
    required Timestamp date,
    required Timestamp timeSpent,
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
      token: token,
      competent: competent,
      color: color,
      date: date,
      timeSpent: timeSpent,
      rating: null,
      note: ' ',
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
        competent:competent,
        latitude: latitude,
        longitude: longitude,
        state: 'Waiting',
        token: token,
        authority: authority,
        color: 1,
        date: Timestamp.now(),
        timeSpent: Timestamp.now(),
      );
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
    required String token,
    required String competent,
    required String authority,
    required int color,
    required Timestamp date,
    required Timestamp timeSpent,
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
          competent: competent,
          latitude: latitude,
          longitude: longitude,
          state: state,
          token: token,
          authority: authority,
          color: color,
          timeSpent: timeSpent,
          date: date);
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
    required String token,
    required String competent,
    required String authority,
    required int color,
    required Timestamp date,
    required Timestamp timeSpent,
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
      token: token,
      competent: competent,
      color: color,
      timeSpent: timeSpent,
      date: date,
      rating: null,
      note: ' ',
    );
    FirebaseFirestore.instance
        .collection('competentAuthority/')
        .doc(authority)
        .collection('complaint/')
        .doc(id2)
        .set(model.toMap())
        .then((value) {
      emit(AddComplaintSuccessState());
    });
  }

  void addComplaint({
    required String type,
    required String userid,
    required String description,
    required String latitude,
    required String longitude,
    required String token,
    required String competent,
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
            token: token,
            color: 1,
            competent: competent,
            date: Timestamp.now(),
            timeSpent: Timestamp.now(),
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
    final pickerFile = await picker.pickImage(source: ImageSource.camera);
    if (pickerFile != null) {
      storieImage = File(pickerFile.path);
      imagename = pickerFile.name;
      print(storieImage!);
      emit(AddComplaintImagePicSuccessState());
    } else {
      print('No Image ');
      emit(AddComplainImagePicErrorState());
    }
  }

  Future<Position> determinePosition({required BuildContext context}) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: 2,
        ),
        buttonsBorderRadius: const BorderRadius.all(
          Radius.circular(2),
        ),
        dismissOnTouchOutside: true,
        dismissOnBackKeyPress: false,
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        title: LocaleKeys.Location.tr(),
        desc: LocaleKeys.Location_services.tr(),
        showCloseIcon: false,
        btnCancelOnPress: () => navigateAndFinish(context, DrawerScreen()),
        btnOkOnPress: () => Geolocator.getCurrentPosition(),
        btnCancelText: LocaleKeys.cancel.tr(),
        btnOkText: LocaleKeys.ok.tr(),
      ).show();
      emit(ErrorComplainGeolocatorState());
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
    
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
  String latitude = "";
  String longitude = "";
  Future<void> getGeo() async {
    position = await Geolocator.getCurrentPosition().whenComplete(() {
      emit(GetComplainGeolocatorState());
    });
    latitude = "${position?.latitude}";
    longitude = "${position?.longitude}";
  }

  String? selectedValue;
  void changeSwitch(String value) {
    selectedValue = value;
    emit(AddComplainChangeSwitchState());
  }
}
