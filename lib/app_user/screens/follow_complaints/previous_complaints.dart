import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pro_test/app_user/screens/follow_complaints/cubit/cubit.dart';
import 'package:pro_test/app_user/screens/follow_complaints/cubit/states.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/components.dart';

import '../../../resources/widgets/bottom_sheet.dart';
import '../../../resources/widgets/listtitle_widget.dart';
import '../../../translations/locale_keys.g.dart';
import '../drawer_screen/drawer_screen.dart';

class PreviousComplaints extends StatelessWidget {
  const PreviousComplaints({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FollowComplaintsCubit()..getFollowComplaints(),
      child: BlocConsumer<FollowComplaintsCubit, FollowComplaintsStates>(
        listener: (context, state) {
          if (state is FollowRemoveSuccessState) {
            navigateAndFinish(context, PreviousComplaints());
          }
        },
        builder: (context, state) {
          var cubit = FollowComplaintsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(LocaleKeys.previous_Complaint.tr()),
              leading: IconButton(
                  onPressed: () => navigateAndFinish(context, DrawerScreen()),
                  icon: Icon(Icons.arrow_back_ios_new)),
            ),
            body: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: cubit.completeComplaints.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 1500),
                  child: SlideAnimation(
                    horizontalOffset: 300,
                    child: FadeInAnimation(
                      child: GestureDetector(
                        onLongPress: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.question,
                            borderSide: BorderSide(
                              color: ColorManager.primary,
                              width: 2,
                            ),
                            buttonsBorderRadius: const BorderRadius.all(
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
                            btnOkOnPress: () => cubit.removeComplaint(
                                id2: cubit.completeComplaints[index].id2!),
                          ).show();
                        },
                        onTap: () {
                          print(cubit.completeComplaints[index].description);
                          showFlexibleBottomSheet(
                            minHeight: 0,
                            initHeight: 0.9,
                            maxHeight: 0.9,
                            context: context,
                            builder: (context, scrollController,
                                    bottomSheetOffset) =>
                                SheetBuild(
                              followComplaints: cubit.completeComplaints[index],
                              scrollController: scrollController,
                              cubit: cubit,
                            ),
                            isExpand: false,
                          );
                        },
                        child: ListWidget(
                            followComplaints: cubit.completeComplaints[index]),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
