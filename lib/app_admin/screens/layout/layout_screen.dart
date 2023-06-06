import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pro_test/app_admin/screens/layout/cubit/cubit.dart';
import 'package:pro_test/app_admin/screens/layout/cubit/states.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app_user/screens/home_screen/components.dart';
import '../../../app_user/screens/login_screen/login_screen.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/components.dart';
import '../../../resources/string_manager.dart';
import '../communications/communications_screen.dart';
import '../cybercrimes/cybercrimes_screen.dart';
import '../home_screen/home_screens.dart';
import 'chart.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocConsumer<LayoutCubit, ComplaintsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                AppString.barTitle,
                style: TextStyle(fontFamily: 'HSNNaskh', fontSize: 35),
              ),
              actions: [
                IconButton(
                    onPressed: () => navigateTo(context, ChartView()),
                    icon: const FaIcon(
                      FontAwesomeIcons.chartSimple,
                      size: 30,
                    ))
              ],
              leading: IconButton(
                  onPressed: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    // Remove data for the 'counter' key.
                    await prefs.remove('em').then((value) {
                      admin = '';

                      return navigateAndFinish(context, LoginScreen());
                    });
                  },
                  icon: Icon(
                    Icons.logout,
                    size: 30,
                  )),
            ),
            body: Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppString.homeBackground2),
                      fit: BoxFit.fill)),
              child: GridView.builder(
                padding: EdgeInsets.only(top: 20),
                physics: const BouncingScrollPhysics(),
                itemCount: cubit.dataName.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      if (index == 0) {
                        uIdA = cubit.dataName[0];

                        await navigateTo(context, CyberCrimesScreen());
                      } else if (index == 4) {
                        uIdA = cubit.dataName[4];

                        await navigateTo(context, CommunicationsScreen());
                      } else {
                        uIdA = cubit.dataName[index];

                        await navigateTo(context, HomeScreens());
                      }
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 150,
                          decoration: BoxDecoration(
                              color: ColorManager.primary.withOpacity(0.2),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12))),
                          child: Image.asset(
                            images[index],
                            width: 150,
                            height: 100,
                          ),
                          padding: const EdgeInsets.all(12),
                        ),
                        Container(
                          width: 150,
                          decoration: BoxDecoration(
                              color: ColorManager.primary.withOpacity(0.9),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(12),
                                  bottomLeft: Radius.circular(12))),
                          child: Center(
                            child: Text(
                              cubit.name[index],
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          padding: const EdgeInsets.all(12),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
