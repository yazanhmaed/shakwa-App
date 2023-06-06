import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pro_test/app_admin/screens/home_screen/home_screens.dart';
import 'package:pro_test/app_user/screens/login_screen/support/support.dart';

import 'package:toggle_switch/toggle_switch.dart';

import '../../../app_admin/screens/communications/communications_screen.dart';
import '../../../app_admin/screens/cybercrimes/cybercrimes_screen.dart';
import '../../../app_admin/screens/layout/layout_screen.dart';
import '../../../resources/cache_helper.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/components.dart';
import '../../../resources/string_manager.dart';

import '../../../resources/widgets/login.dart';
import '../../../resources/widgets/signup.dart';
import '../../../translations/locale_keys.g.dart';
import '../drawer_screen/drawer_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(),
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {
          if (state is AddUserErrorState) {
            if (state.error.toString() ==
                '[firebase_auth/weak-password] Password should be at least 6 characters')
              Fluttertoast.showToast(
                  msg: LocaleKeys.Password_is_less.tr(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            else
              Fluttertoast.showToast(
                  msg: LocaleKeys.Email_already_exists.tr(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
          }
          if (state is UserErrorState) {
            Fluttertoast.showToast(
                msg: LocaleKeys.Verify_your_email_and_password.tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          if (state is UserSuccessState) {
            if (state.email == 'anticybercrimesunit@shakwa.com') {
              CacheHelper.seveData(key: 'uIdA', value: 'AntiCyberCrimesUnit')
                  .then((value) {
                uIdA = CacheHelper.getData(key: 'uIdA');
                print(00000);
                navigateTo(context, CyberCrimesScreen());
              });
            } else if (state.email == 'ministryofcommunications@shakwa.com') {
              CacheHelper.seveData(
                      key: 'uIdA', value: 'MinistryofCommunications')
                  .then((value) {
                uIdA = CacheHelper.getData(key: 'uIdA');

                navigateTo(context, CommunicationsScreen());
              });
            } else if (state.email == 'ammancity@shakwa.com') {
              CacheHelper.seveData(key: 'uIdA', value: 'AmmanCity')
                  .then((value) {
                uIdA = CacheHelper.getData(key: 'uIdA');

                navigateTo(context, HomeScreens());
              });
            } else if (state.email == 'ministryofagriculture@shakwa.com') {
              CacheHelper.seveData(key: 'uIdA', value: 'MinistryOfAgriculture')
                  .then((value) {
                uIdA = CacheHelper.getData(key: 'uIdA');

                navigateTo(context, HomeScreens());
              });
            } else if (state.email == 'electricpower@shakwa.com') {
              CacheHelper.seveData(key: 'uIdA', value: 'ElectricPower')
                  .then((value) {
                uIdA = CacheHelper.getData(key: 'uIdA');

                navigateTo(context, HomeScreens());
              });
            } else if (state.email == 'ministryofenvironment@shakwa.com') {
              CacheHelper.seveData(key: 'uIdA', value: 'MinistryofEnvironment')
                  .then((value) {
                uIdA = CacheHelper.getData(key: 'uIdA');

                navigateTo(context, HomeScreens());
              });
            } else if (state.email == 'trafficdepartment@shakwa.com') {
              CacheHelper.seveData(key: 'uIdA', value: 'TrafficDepartment')
                  .then((value) {
                uIdA = CacheHelper.getData(key: 'uIdA');

                navigateTo(context, HomeScreens());
              });
            } else if (state.email == 'miyahuna@shakwa.com') {
              CacheHelper.seveData(key: 'uIdA', value: 'Miyahuna')
                  .then((value) {
                uIdA = CacheHelper.getData(key: 'uIdA');

                navigateTo(context, HomeScreens());
              });
            } else if (state.email == 'admin@shakwa.com') {
              CacheHelper.seveData(key: 'em', value: 'admin@shakwa.com')
                  .then((value) {
                admin = CacheHelper.getData(key: 'em');

                navigateAndFinish(context, LayoutScreen());
              });
            } else {
              uId = state.uId;
              CacheHelper.seveData(key: 'uId', value: state.uId).then((value) {
                print(state.uId);
                navigateAndFinish(context, DrawerScreen());
              });
            }
          }
          if (state is AddCreateUserSuccessState) {
            UserCubit.get(context).positive = 0;
          }
        },
        builder: (context, state) {
          var key = GlobalKey<FormState>();
          var cubit = UserCubit.get(context);
          FirebaseMessaging.instance.getToken().then((value) {
            cubit.token = value!;
          });

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    navigateTo(context, SupportLoginScreen());
                  },
                  icon: Icon(
                    Icons.support_agent,
                    size: 35,
                  )),
              actions: [
                if (draw == true)
                  TextButton(
                      onPressed: () async {
                        cubit.changeDraw(dr: false, context: context);
                        navigateAndFinish(context, LoginScreen());
                      },
                      child: Text(
                        'الانجليزية|En',
                        style: TextStyle(
                            color: ColorManager.primary,
                            fontWeight: FontWeight.bold),
                      )),
                if (draw == false)
                  TextButton(
                    onPressed: () async {
                      cubit.changeDraw(dr: true, context: context);
                      navigateAndFinish(context, LoginScreen());
                    },
                    child: Text(
                      'Ar|العربية',
                      style: TextStyle(
                          color: ColorManager.primary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
            body: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(AppString.background),
                fit: BoxFit.fitHeight,
              )),
              child: Form(
                  key: key,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 400,
                        ),
                        ToggleSwitch(
                          animate: true,
                          minHeight: 40,
                          minWidth: 190.0,
                          cornerRadius: 30.0,
                          activeBgColors: [
                            [ColorManager.amber],
                            [ColorManager.amber]
                          ],
                          borderColor: [
                            ColorManager.primary.withOpacity(0.7),
                            ColorManager.primary.withOpacity(0.7),
                          ],
                          borderWidth: 10,
                          activeFgColor: Colors.white,
                          inactiveBgColor:
                              ColorManager.primary.withOpacity(0.7),
                          inactiveFgColor: Colors.white,
                          initialLabelIndex: cubit.positive,
                          totalSwitches: 2,
                          labels: [
                            LocaleKeys.login.tr(),
                            LocaleKeys.signup.tr()
                          ],
                          radiusStyle: true,
                          onToggle: (index) {
                            cubit.changecurrentSwitch(posit: index!);
                          },
                        ),
                        cubit.positive == 0
                            ? LoginBuilder(
                                anim: draw!,
                                positive: cubit.positive,
                                onTap: () => cubit.signInWithGoogle(),
                                obscureText: cubit.obscureText,
                                onPressedobscureText: () =>
                                    cubit.changeobscureText(),
                                emailController: cubit.emailController,
                                passwordController: cubit.passwordController,
                                onPressed: () async {
                                  if (key.currentState!.validate()) {
                                    cubit.userLogin(
                                        email: cubit.emailController.text,
                                        password:
                                            cubit.passwordController.text);
                                  }
                                },
                              )
                            : SignUpBuilder(
                                anim: draw!,
                                positive: cubit.positive,
                                obscureText: cubit.obscureText,
                                onPressedobscureText: () =>
                                    cubit.changeobscureText(),
                                nameController: cubit.nameController,
                                emailController: cubit.emailController,
                                passwordController: cubit.passwordController,
                                onPressed: () {
                                  if (key.currentState!.validate()) {
                                    cubit.userRegister(
                                      name: cubit.nameController.text,
                                      email: cubit.emailController.text,
                                      password: cubit.passwordController.text,
                                      token: cubit.token,
                                    );
                                  }
                                }),
                             
                      ],
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }
}
