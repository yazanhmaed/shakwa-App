import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../../resources/color_manager.dart';
import 'notification_messages.dart';

Future<void> messageHandler(RemoteMessage message) async {
  Data notificationMessage = Data.fromJson(message.data);

  print('notification from background : ${notificationMessage.title}');
}

void firebaseMessagingListener({required BuildContext context}) {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    Data notificationMessage = Data.fromJson(message.data);
    AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
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
        title: '${message.notification!.title}',
        desc: '${message.notification!.body}',
        showCloseIcon: true,
        
        btnOkOnPress: (){},
      ).show();
    // print('notification from foreground2 : ${notificationMessage.title}');
  });
}
