import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:pro_test/resources/widgets/signup.dart';
import 'package:pro_test/screens/drawer_screen/drawer_screen.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../resources/cache_helper.dart';
import '../../resources/color_manager.dart';
import '../../resources/components.dart';
import '../../resources/string_manager.dart';

import '../../resources/widgets/login.dart';
import '../../translations/locale_keys.g.dart';
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
            Fluttertoast.showToast(
                msg: state.error.toString(),
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
            uId = state.uId;
            CacheHelper.seveData(key: 'uId', value: state.uId).then((value) {
              print(state.uId);
              navigateAndFinish(context, DrawerScreen());
            });
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
