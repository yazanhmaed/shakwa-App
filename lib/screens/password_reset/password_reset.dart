import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_test/resources/components.dart';
import 'package:pro_test/screens/login_screen/login_screen.dart';

import '../../resources/color_manager.dart';
import '../../resources/string_manager.dart';
import '../../resources/widgets/button_custom.dart';
import '../../resources/widgets/input_text.dart';
import '../login_screen/cubit/cubit.dart';
import '../login_screen/cubit/states.dart';

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
          var cubit = UserCubit.get(context);
          return Scaffold(
            body: Container(
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
                            type: TextInputType.emailAddress,
                            hintText: '',
                            validator: 'Enter your Email',
                            icon: Icons.email,
                            controller: cubit.emailController,
                            labelText: 'Email',
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ButtomCustom(
                                text: 'Reset',
                                color: ColorManager.amber,
                                onPressed: () => cubit.getPassword(
                                    email: cubit.emailController.text),
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
          );
        },
      ),
    );
  }
}
