import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pro_test/resources/color_manager.dart';
import 'package:pro_test/screens/follow_complaints/contact%20numbers.dart';
import 'package:pro_test/screens/follow_complaints/cubit/cubit.dart';
import 'package:pro_test/screens/login_screen/cubit/cubit.dart';
import 'package:pro_test/screens/login_screen/cubit/states.dart';

import '../../resources/cache_helper.dart';
import '../../resources/components.dart';
import '../../translations/locale_keys.g.dart';
import '../follow_complaints/follow_complaints.dart';
import '../follow_complaints/previous_complaints.dart';
import '../login_screen/login_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final googleSignIn = GoogleSignIn();

    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
          create: (context) => UserCubit()..getUser(uId: uId!),
        ),
        BlocProvider<FollowComplaintsCubit>(
          create: (context) => FollowComplaintsCubit()..n(),
        ),
      ],
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = UserCubit.get(context);
          return Scaffold(
            backgroundColor: ColorManager.primary,
            body: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  Center(
                      child: CircleAvatar(
                    backgroundColor: ColorManager.grey1,
                    child: FaIcon(
                      FontAwesomeIcons.user,
                      color: Colors.white,
                    ),
                    radius: 50,
                  )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    cubit.n,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  ListTile(
                    onTap: () => navigateTo(context, FollowComplaints()),
                    leading: FaIcon(
                      FontAwesomeIcons.user,
                      color: Colors.white,
                    ),
                    title: Text(LocaleKeys.follow_Complaint.tr()),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    minLeadingWidth: 38,
                    onTap: () => navigateTo(context, PreviousComplaints()),
                    leading: FaIcon(
                      FontAwesomeIcons.user,
                      color: Colors.white,
                    ),
                    title: Text(LocaleKeys.previous_Complaint.tr()),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    onTap: () => navigateTo(context, ContactNumbers()),
                    leading: FaIcon(
                      FontAwesomeIcons.user,
                      color: Colors.white,
                    ),
                    title: Text(LocaleKeys.contact_numbers.tr()),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () async {
                            await context.setLocale(Locale('en'));
                            FollowComplaintsCubit.get(context).n();
                          },
                          child: Text('en')),
                      TextButton(
                          onPressed: () async {
                            FollowComplaintsCubit.get(context).n();
                            await context.setLocale(Locale('ar'));
                          },
                          child: Text('ar')),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    onTap: () {
                      CacheHelper.removeData(key: 'name');
                      CacheHelper.removeData(key: 'uId').then(
                          (value) => navigateAndFinish(context, LoginScreen()));
                      FirebaseAuth.instance.signOut().then((value) {
                        googleSignIn.disconnect();
                      });
                    },
                    leading: FaIcon(
                      FontAwesomeIcons.rightFromBracket,
                      color: Colors.white,
                    ),
                    title: Text(LocaleKeys.logout.tr()),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
