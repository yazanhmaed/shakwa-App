import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pro_test/resources/bloc.dart';
import 'package:pro_test/resources/cache_helper.dart';
import 'package:pro_test/resources/components.dart';
import 'package:pro_test/resources/theme_manager.dart';
import 'package:pro_test/screens/drawer_screen/drawer_screen.dart';
import 'package:pro_test/screens/login_screen/login_screen.dart';
import 'package:pro_test/screens/notification/notification.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(messageHandler);
firebaseMessagingListener();
  await Firebase.initializeApp();
  await CacheHelper.init();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  
  // ignore: deprecated_member_use

  Widget widget;
  uId = CacheHelper.getData(key: 'uId');
  if (uId != null) {
    widget = const DrawerScreen();
  } else {
    widget = LoginScreen();
  }
  // ignore: deprecated_member_use
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.startWidget});
  final Widget startWidget;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      home: startWidget,
    );
  }
}
