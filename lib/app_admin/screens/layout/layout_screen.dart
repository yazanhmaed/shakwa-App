import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_test/app_admin/screens/cybercrimes/cybercrimes_screen.dart';
import 'package:pro_test/app_admin/screens/login_screen/cubit/cubit.dart';
import 'package:pro_test/app_admin/screens/login_screen/cubit/states.dart';
import 'package:pro_test/app_user/screens/login_screen/login_screen.dart';

import '../../../app_user/screens/home_screen/components.dart';
import '../../../resources/cache_helper.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/components.dart';
import '../../../resources/string_manager.dart';
import '../communications/communications_screen.dart';
import '../home_screen/home_screens.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> dataName = [
      'AntiCyberCrimesUnit',
      'AmmanCity',
      'ElectricPower',
      'MinistryOfAgriculture',
      'MinistryofCommunications',
      'MinistryofEnvironment',
      'Miyahuna',
      'TrafficDepartment',
    ];
    return BlocProvider(
      create: (context) => UserCubit(),
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {
          if (state is ComplainChangeSwitchState) {
            CacheHelper.seveData(key: 'uIdA', value: state.uId).then((value) {
              print(state.uId);
              uIdA = CacheHelper.getData(key: 'uIdA');
            });
          }
        },
        builder: (context, state) {
          var cubit = UserCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                AppString.barTitle,
                style: TextStyle(fontFamily: 'HSNNaskh', fontSize: 35),
              ),
              leading: IconButton(
                  onPressed: () {
                    navigateAndFinish(context, LoginScreen());
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
                itemCount: dataName.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      if (index == 0) {
                        uIdA = dataName[0];

                        print(dataName[index]);
                        await navigateTo(context, CyberCrimesScreen());
                      } else if (index == 4) {
                        uIdA = dataName[4];

                        print(dataName[index]);
                        await navigateTo(context, CommunicationsScreen());
                      } else {
                        uIdA = dataName[index];

                        print(dataName[index]);
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
