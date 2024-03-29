import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:loading_animations/loading_animations.dart';


import '../../../resources/color_manager.dart';
import '../../../resources/components.dart';
import '../../../resources/string_manager.dart';
import '../add_complaint/add_complaint.dart';
import '../add_cybercrimes/add_cyber_crimes.dart';
import '../communications/add_communications.dart';
import '../email_verification/email_verification.dart';
import '../follow_complaints/cubit/cubit.dart';
import '../follow_complaints/cubit/states.dart';
import '../support/support.dart';
import 'components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FollowComplaintsCubit()..getUser(),
      child: BlocConsumer<FollowComplaintsCubit, FollowComplaintsStates>(
        listener: (context, state) {},
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
                      }
                    },
                    icon: Icon(Icons.menu)),
                title: const Text(
                  AppString.barTitle,
                  style: TextStyle(fontFamily: 'HSNNaskh', fontSize: 35),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        navigateTo(context, SupportScreen());
                      },
                      icon: Icon(Icons.support_agent,size: 35,))
                ],
              ),
              body: ConditionalBuilder(
                condition: cubit.users.isNotEmpty,
                fallback: (context) => Center(
                  child: LoadingBouncingGrid.square(
                    backgroundColor: ColorManager.primary,
                    borderColor: ColorManager.white,
                    size: 50.0,
                  ),
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
                          if (index == 0) {
                            navigateTo(
                                context,
                                AddCyberCrimes(
                                  userid: cubit.users[0].uId!,
                                  title: cubit.name[index],
                                  data: nameData[index],
                                  cyberName: cubit.cyberName,
                                  list: cubit.complaints[0]
                                      ['AntiCyberCrimesUnit'],
                                ));
                          } else if (index == 4) {
                            navigateTo(
                                context,
                                AddCommunications(
                                  userid: cubit.users[0].uId!,
                                  title: cubit.name[index],
                                  data: nameData[index],
                                  servies: cubit.communications,
                                  list: cubit.complaints[0]
                                      ['MinistryofCommunications'],
                                ));
                          } else {
                            navigateTo(
                                context,
                                AddComplaint(
                                  userid: cubit.users[0].uId!,
                                  title: cubit.name[index],
                                  data: nameData[index],
                                  list: cubit.complaints[0]
                                      ['${nameData[index]}'],
                                ));
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
              ),
            ),
          );
        },
      ),
    );
  }
}
