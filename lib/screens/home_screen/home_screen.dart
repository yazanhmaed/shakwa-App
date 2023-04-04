import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:pro_test/screens/email_verification/email_verification.dart';
import 'package:pro_test/screens/follow_complaints/cubit/cubit.dart';
import 'package:pro_test/screens/follow_complaints/cubit/states.dart';

import '../../resources/color_manager.dart';
import '../../resources/components.dart';
import '../../resources/string_manager.dart';
import '../add_complaint/add_complaint.dart';
import '../add_cybercrimes/add_cyber_crimes.dart';
import 'components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FollowComplaintsCubit()..getUser(),
      child: BlocConsumer<FollowComplaintsCubit, FollowComplaintsStates>(
        listener: (context, state) {
          if (state is GetUserSuccessState) {
            nameUser = state.name;
          }
        },
        builder: (context, state) {
          var cubit = FollowComplaintsCubit.get(context);
          return ConditionalBuilder(
            condition: FirebaseAuth.instance.currentUser!.emailVerified,
            fallback: (context) => EmailVerificationScreen(),
            builder: (context) => Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      if (ZoomDrawer.of(context)!.isOpen()) {
                        ZoomDrawer.of(context)!.close();
                      } else {
                        ZoomDrawer.of(context)!.open();
                        print(ZoomDrawer.of(context)!.isOpen());
                      }
                    },
                    icon: Icon(Icons.menu)),
                title: const Text(
                  AppString.barTitle,
                  style: TextStyle(fontFamily: 'HSNNaskh', fontSize: 35),
                ),
              ),
              body: ConditionalBuilder(
                condition: cubit.users.isNotEmpty,
                fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
                builder: (context) => Container(
                  height: double.infinity,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AppString.homeBackground2),
                          fit: BoxFit.fill)),
                  child: GridView.builder(
                    padding: EdgeInsets.only(top: 20),
                    physics: const BouncingScrollPhysics(),
                    itemCount: nameData.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          navigateTo(
                              context,
                              index == 0
                                  ? AddCyberCrimes(
                                      userid: cubit.users[0].uId!,
                                      title: name[index],
                                      data: nameData[index],
                                    )
                                  : AddComplaint(
                                      userid: cubit.users[0].uId!,
                                      title: name[index],
                                      data: nameData[index],
                                    ));
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
                              child: Text(
                                name[index],
                                style: TextStyle(color: Colors.white),
                              ),
                              padding: const EdgeInsets.all(12),
                            )
                          ],
                        ),
                      );
                    },
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
