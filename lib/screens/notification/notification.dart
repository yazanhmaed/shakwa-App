import 'package:firebase_messaging/firebase_messaging.dart';
import 'notification_messages.dart';

Future<void> messageHandler(RemoteMessage message) async {
  Data notificationMessage = Data.fromJson(message.data);

  print('notification from background : ${notificationMessage.title}');
}

void firebaseMessagingListener() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    Data notificationMessage = Data.fromJson(message.data);
    print('notification from foreground2 : ${notificationMessage.title}');
  });
}
