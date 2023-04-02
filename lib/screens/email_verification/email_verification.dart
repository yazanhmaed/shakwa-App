import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pro_test/resources/color_manager.dart';
import 'package:pro_test/resources/components.dart';
import 'package:pro_test/resources/string_manager.dart';
import 'package:pro_test/screens/login_screen/cubit/cubit.dart';
import 'package:pro_test/screens/login_screen/cubit/states.dart';
import 'package:pro_test/screens/login_screen/login_screen.dart';

import '../../resources/cache_helper.dart';
import '../../resources/widgets/button_custom.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(),
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final googleSignIn = GoogleSignIn();
          var cubit = UserCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    CacheHelper.removeData(key: 'uId').then(
                        (value) => navigateAndFinish(context, LoginScreen()));
                    FirebaseAuth.instance.signOut().then((value) {
                      googleSignIn.disconnect();
                    });
                  },
                  icon: Icon(Icons.arrow_back_ios_new)),
            ),
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
                      margin: EdgeInsets.all(20),
                      color: ColorManager.primary.withOpacity(0.8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Please verify your email',
                            style: TextStyle(
                                fontSize: 20, color: ColorManager.white),
                          ),
                          ButtomCustom(
                            text: 'Send',
                            color: ColorManager.amber,
                            onPressed: () => cubit.getEmailVerify(),
                          )
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
