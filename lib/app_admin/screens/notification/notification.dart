import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../../resources/components.dart';
import 'notification_messages.dart';

Future<void> messageHandler(RemoteMessage message) async {
  Data notificationMessage = Data.fromJson(message.data);
  print('notification from background : ${notificationMessage.title}');
}

void firebaseMessagingListener() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    Data notificationMessage = Data.fromJson(message.data);
    print('notification from foreground : ${notificationMessage.title}');
  });
}

Future<void> sendNotification({
  required String token,
  required String desc,
  required String state,
  required String id2,
}) async {
  const postUrl = 'https://fcm.googleapis.com/fcm/send';
  Dio dio = Dio();

  final data = {
    "data": {
      "message": "Accept Ride Request",
      "title": "This is Ride Request",
    },
    "notification": {
      "title": '$uIdA : $id2 ',
      "body":state,
      "titleLocKey": state,
    },
    "android": {"priority": "normal"},
    "to": token
  };

  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers["Authorization"] =
      'key=AAAA7lPATic:APA91bFqjqocdRlh0uFQcl3dkWrQSh-wQdh6BpixPPJM7LDp6sdhM6YF2Ks3o6izBkiG21zRzVp61Y7HPhIWZivuKv3hZzgwO2oBnvoFIRZmCxFpPLSLdbF9IApnv7xhcL0NVSnJ_dnA';

  try {
    final response = await dio.post(postUrl, data: data);

    if (response.statusCode == 200) {
      print('Request Sent To Driver');
    } else {
      print('notification sending failed');
    }
  } catch (e) {
    print('exception $e');
  }
}
