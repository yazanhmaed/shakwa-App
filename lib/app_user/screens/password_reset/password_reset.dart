import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../resources/color_manager.dart';
import '../../../resources/components.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/widgets/button_custom.dart';
import '../../../resources/widgets/input_text.dart';
import '../../../translations/locale_keys.g.dart';
import '../login_screen/cubit/cubit.dart';
import '../login_screen/cubit/states.dart';
import '../login_screen/login_screen.dart';

class PasswordResetScreen extends StatelessWidget {
  const PasswordResetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(),
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {
          if (state is PasswordResetSuccessState) {
            navigateAndFinish(context, LoginScreen());
          }
        },
        builder: (context, state) {
          var key = GlobalKey<FormState>();
          var cubit = UserCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey.shade100,
              leading: IconButton(
                  onPressed: () {
                    navigateAndFinish(context, LoginScreen());
                  },
                  icon: Icon(
                    Icons.logout,
                  )),
            ),
            body: Form(
              key: key,
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppString.complaintBackground),
                        fit: BoxFit.fill)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: Column(
                    children: [
                      Text(
                        AppString.barTitle,
                        style: TextStyle(
                            fontSize: 40,
                            fontFamily: 'HSNNaskh',
                            color: ColorManager.primary),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: ColorManager.primary.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(20)),
                        margin: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            InputText(
                              checkEmail: false,
                              type: TextInputType.emailAddress,
                              hintText: '',
                              validator:cubit.emailController.text.isEmpty? LocaleKeys.Enter_your_Email.tr():LocaleKeys.Enter_the_email_correctly.tr(),
                              icon: Icons.email,
                              controller: cubit.emailController,
                              labelText: LocaleKeys.email.tr(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ButtomCustom(
                                  text: LocaleKeys.Reset.tr(),
                                  color: ColorManager.amber,
                                  onPressed: () {
                                    if (key.currentState!.validate()) {
                                      cubit.getPassword(
                                          email: cubit.emailController.text);
                                    }
                                  },
                                ),
                                SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
