import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:pro_test/resources/color_manager.dart';
import 'package:pro_test/screens/drawer_screen/menu_screen.dart';
import 'package:pro_test/screens/home_screen/home_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final ZoomDrawerController z = ZoomDrawerController();
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      // drawerShadowsBackgroundColor: Colors.white,
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
