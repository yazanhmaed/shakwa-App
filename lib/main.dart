import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pro_test/resources/bloc.dart';
import 'package:pro_test/resources/cache_helper.dart';
import 'package:pro_test/resources/components.dart';
import 'package:pro_test/resources/theme_manager.dart';
import 'package:pro_test/screens/drawer_screen/drawer_screen.dart';
import 'package:pro_test/screens/login_screen/login_screen.dart';
import 'package:pro_test/screens/notification/notification.dart';
import 'package:pro_test/translations/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(messageHandler);

  await Firebase.initializeApp();
  await CacheHelper.init();
  await Geolocator.requestPermission();
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
      runApp(EasyLocalization(
        supportedLocales: [
          Locale('en'),
          Locale('ar'),
        ],
        fallbackLocale: Locale('en'),
        path: 'assets/translations',
        assetLoader: CodegenLoader(),
        child: MyApp(
          startWidget: widget,
        ),
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
    print(context.locale);
    // ignore: unrelated_type_equality_checks
    if (context.locale == Locale('en')) {
      draw = false;
    } else {
      draw = true;
    }
    return MaterialApp(
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      home:  startWidget,
    );
  }
}
