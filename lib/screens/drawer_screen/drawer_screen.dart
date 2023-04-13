import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:pro_test/resources/color_manager.dart';
import 'package:pro_test/resources/components.dart';
import 'package:pro_test/screens/drawer_screen/menu_screen.dart';
import 'package:pro_test/screens/follow_complaints/previous_complaints.dart';
import 'package:pro_test/screens/home_screen/home_screen.dart';
import 'package:pro_test/screens/login_screen/login_screen.dart';

import '../follow_complaints/follow_complaints.dart';
import '../notification/notification.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final ZoomDrawerController z = ZoomDrawerController();
  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen(
      (event) {
        if (uId!.isEmpty) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
        } else if (event.notification!.body == 'Prosses') {
          // print('prosses');
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FollowComplaints(),
          ));
        } else if (event.notification!.body == 'Success') {
          //print('Success');
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PreviousComplaints(),
          ));
        }
      },
    );
    firebaseMessagingListener(context: context);

    return ZoomDrawer(
      isRtl: draw!,
      borderRadius: 24.0,
      showShadow: true,
      angle: 0.0,
      drawerShadowsBackgroundColor: Colors.grey[300]!,
      slideWidth: MediaQuery.of(context).size.width * 0.6,
      mainScreenScale: 0.05,
      shadowLayer2Color: Colors.white38,
      menuBackgroundColor: ColorManager.primary,
      moveMenuScreen: true,
      controller: z,
      style: DrawerStyle.defaultStyle,
      openCurve: Curves.easeInQuad,
      closeCurve: Curves.linear,
      menuScreen: MenuScreen(),
      mainScreen: HomeScreen(),
    );
  }
}
