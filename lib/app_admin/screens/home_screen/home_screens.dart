import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../resources/cache_helper.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/components.dart';
import '../../../resources/widgetAdmin/bottom_sheet.dart';
import '../../../resources/widgetAdmin/listtitle_widget.dart';
import '../login_screen/login_screen.dart';
import '../pie/pie_chart.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
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
      create: (context) => ComplaintsCubit()..getComplaints(),
      child: BlocConsumer<ComplaintsCubit, ComplaintsStates>(
        listener: (context, state) {
          if (state is ComplaintsUpdateSuccessState) {
            navigateAndFinish(context, const HomeScreens());
          }
          if (state is ComplaintsRemoveSuccessState) {
            navigateAndFinish(context, const HomeScreens());
          }
        },
        builder: (context, state) {
          var cubit = ComplaintsCubit.get(context);

          return ConditionalBuilder(
            condition: cubit.dateTime.isNotEmpty,
            fallback: (context) => Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: ColorManager.primary,
                title: Text(
                  '$uIdA',
                  style: TextStyle(color: Colors.white),
                ),
                leading: IconButton(
                    onPressed: () {
                      CacheHelper.removeData(key: 'uIdA').then((value) =>
                          navigateAndFinish(context, const LoginAdminScreen()));
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
                backgroundColor: ColorManager.primary,
                title: Text(
                  '$uIdA',
                  style: TextStyle(color: Colors.white),
                ),
                leading: IconButton(
                    onPressed: () {
                      CacheHelper.removeData(key: 'uIdA').then((value) =>
                          navigateAndFinish(context, const LoginAdminScreen()));
                    },
                    icon: const Icon(Icons.logout)),
                actions: [
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
                    events: cubit.dateTime,
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      color: ColorManager.primary,
                      onRefresh: () =>
                          navigateAndFinish(context, const HomeScreens()),
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: cubit.complaintsModel.length,
                          itemBuilder: (context, index) {
                            // ignore: unrelated_type_equality_checks
                            if ((cubit.complaintsModel[index].date!
                                        .toDate()
                                        .day ==
                                    selectedDate!.day) &&
                                (cubit.complaintsModel[index].date!
                                        .toDate()
                                        .month ==
                                    selectedDate!.month) &&
                                (cubit.complaintsModel[index].date!
                                        .toDate()
                                        .year ==
                                    selectedDate!.year)) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 1200),
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
                                        title: 'Delete',
                                        desc: 'Delete The Complaints',
                                        showCloseIcon: false,
                                        btnCancelOnPress: () {},
                                        btnOkColor: ColorManager.primary,
                                        btnOkOnPress: () =>
                                            cubit.removeComplaint(
                                                id2: cubit
                                                    .complaintsModel[index]
                                                    .id2!),
                                      ).show(),
                                      onTap: () {
                                        showFlexibleBottomSheet(
                                          minHeight: 0,
                                          initHeight: 0.9,
                                          maxHeight: 0.9,
                                          context: context,
                                          builder: (context, scrollController,
                                                  bottomSheetOffset) =>
                                              SheetBuild(
                                            complaintsModel:
                                                cubit.complaintsModel[index],
                                            scrollController: scrollController,
                                            cubit: cubit,
                                          ),
                                          isExpand: false,
                                        );
                                      },
                                      child: ListWidget(
                                          complaintsModel:
                                              cubit.complaintsModel[index]),
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
