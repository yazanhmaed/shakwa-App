import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pro_test/calendar.dart';

import '../../../app_user/screens/login_screen/login_screen.dart';
import '../../../resources/cache_helper.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/components.dart';
import '../../../translations/locale_keys.g.dart';
import '../layout/layout_screen.dart';
import '../pie/pie_chart.dart';
import '../view_complaints_admin/view_cyber.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'list_title_widget.dart';

class CyberCrimesScreen extends StatefulWidget {
  const CyberCrimesScreen({super.key});

  @override
  State<CyberCrimesScreen> createState() => _CyberCrimesScreenState();
}

class _CyberCrimesScreenState extends State<CyberCrimesScreen> {
  DateTime? selectedDate;
  Random random = Random();

  @override
  void initState() {
    setState(() {
      selectedDate = DateTime.now();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CyberCrimesCubit()..getCyberCrimes(),
      child: BlocConsumer<CyberCrimesCubit, CyberCrimesStates>(
        listener: (context, state) {
          if (state is CyberCrimesUpdateSuccessState) {
            navigateAndFinish(context, const CyberCrimesScreen());
          }
          if (state is CyberCrimesRemoveSuccessState) {
            navigateAndFinish(context, const CyberCrimesScreen());
          }
        },
        builder: (context, state) {
          var cubit = CyberCrimesCubit.get(context);

          return ConditionalBuilder(
            condition: cubit.cyber.isNotEmpty,
            fallback: (context) => Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                title: Text(
                  '$uIdA',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: ColorManager.primary,
                leading: IconButton(
                    onPressed: () {
                      CacheHelper.removeData(key: 'uIdA').then((value) =>
                          navigateAndFinish(context, const LayoutScreen()));
                    },
                    icon: const Icon(Icons.logout)),
              ),
              body: CalendarAppBar(
                locale: draw == true ? 'ar' : 'en',
                backButton: false,
                firstDate: DateTime(2022),
                accent: ColorManager.primary,
                white: Colors.white,
                onDateChanged: (value) => setState(() => selectedDate = value),
                lastDate: DateTime.now(),
           
              ),
            ),
            builder: (context) => Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                title: Text(
                  '$uIdA',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: ColorManager.primary,
                leading: IconButton(
                    onPressed: () {
                      CacheHelper.removeData(key: 'uIdA').then((value) {
                        if (admin == 'admin@shakwa.com') {
                          navigateAndFinish(context, LayoutScreen());
                        } else {
                          navigateAndFinish(context, LoginScreen());
                        }
                      });
                    },
                    icon: const Icon(Icons.logout)),
                actions: [
                  if (draw == true)
                    TextButton(
                        onPressed: () async {
                          cubit.changeDraw(dr: false, context: context);
                          navigateAndFinish(context, CyberCrimesScreen());
                        },
                        child: Icon(
                          Icons.translate,
                          color: Colors.white,
                        )),
                  if (draw == false)
                    TextButton(
                      onPressed: () async {
                        cubit.changeDraw(dr: true, context: context);
                        navigateAndFinish(context, CyberCrimesScreen());
                      },
                      child: Icon(
                        Icons.translate,
                        color: Colors.white,
                      ),
                    ),
                  IconButton(
                      onPressed: () => navigateTo(
                          context,
                          PieCharts(
                            waiting: cubit.w,
                            prosses: cubit.p,
                            success: cubit.s,
                            wcount: cubit.waiting.length,
                            pcount: cubit.prosses.length,
                            scount: cubit.success.length,
                            s1: cubit.s1,
                            s2: cubit.s2,
                            s3: cubit.s3,
                            s4: cubit.s4,
                            s5: cubit.s5,
                            rate: cubit.rate,
                            cubitCrimes: cubit,
                          )),
                      icon: const FaIcon(
                        FontAwesomeIcons.chartSimple,
                        size: 30,
                      ))
                ],
              ),
              body: Column(
                children: [
                  CalendarAppBar(
                    locale: draw == true ? 'ar' : 'en',
                    backButton: false,
                    firstDate: DateTime(2022),
                    accent: ColorManager.primary,
                    white: Colors.white,
                    onDateChanged: (value) =>
                        setState(() => selectedDate = value),
                    lastDate: DateTime.now(),
                    events: cubit.cyberDate,
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      color: ColorManager.primary,
                      displacement: 200,
                      strokeWidth: 3,
                      onRefresh: () =>
                          navigateAndFinish(context, const CyberCrimesScreen()),
                      child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          itemCount: cubit.cyber.length,
                          itemBuilder: (context, index) {
                            // ignore: unrelated_type_equality_checks
                            if ((cubit.cyber[index].date!.toDate().day ==
                                    selectedDate!.day) &&
                                (cubit.cyber[index].date!.toDate().month ==
                                    selectedDate!.month) &&
                                (cubit.cyber[index].date!.toDate().year ==
                                    selectedDate!.year)) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 1500),
                                child: SlideAnimation(
                                  horizontalOffset: 300,
                                  child: FadeInAnimation(
                                    child: GestureDetector(
                                      onLongPress: () => AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.question,
                                        borderSide: BorderSide(
                                          color: ColorManager.primary,
                                          width: 2,
                                        ),
                                        buttonsBorderRadius:
                                            const BorderRadius.all(
                                          Radius.circular(2),
                                        ),
                                        dismissOnTouchOutside: true,
                                        dismissOnBackKeyPress: false,
                                        headerAnimationLoop: false,
                                        animType: AnimType.bottomSlide,
                                        title: LocaleKeys.delete.tr(),
                                        desc: LocaleKeys.delete_the_complaints
                                            .tr(),
                                        showCloseIcon: false,
                                        btnCancelOnPress: () {},
                                        btnOkColor: ColorManager.primary,
                                        btnOkOnPress: () =>
                                            cubit.removeComplaint(
                                                id2: cubit.cyber[index].id2!),
                                      ).show(),
                                      onTap: () {
                                        showFlexibleBottomSheet(
                                          minHeight: 0,
                                          initHeight: 0.9,
                                          maxHeight: 0.9,
                                          context: context,
                                          builder: (context, scrollController,
                                                  bottomSheetOffset) =>
                                              CyberInfoScreen(
                                            cyberCrimesModel:
                                                cubit.cyber[index],
                                            scrollController: scrollController,
                                            cubit: cubit,
                                          ),
                                          isExpand: false,
                                        );
                                      },
                                      child: ListCyberWidget(
                                          eventModel: cubit.cyber[index]),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ),
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
