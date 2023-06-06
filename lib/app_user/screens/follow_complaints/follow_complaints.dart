import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pro_test/app_user/screens/view_complaints/view_complaints.dart';

import '../../../resources/components.dart';
import '../../../resources/widgets/list_title_widget.dart';
import '../../../translations/locale_keys.g.dart';
import '../drawer_screen/drawer_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class FollowComplaints extends StatelessWidget {
  const FollowComplaints({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FollowComplaintsCubit()..getFollowComplaints(),
      child: BlocConsumer<FollowComplaintsCubit, FollowComplaintsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = FollowComplaintsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(LocaleKeys.follow_Complaint.tr()),
              leading: IconButton(
                  onPressed: () => navigateAndFinish(context, DrawerScreen()),
                  icon: Icon(Icons.arrow_back_ios_new)),
            ),
            body: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: cubit.prossesComplaints.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 1500),
                  child: SlideAnimation(
                    horizontalOffset: 300,
                    child: FadeInAnimation(
                      child: GestureDetector(
                        onTap: () {
                          showFlexibleBottomSheet(
                            minHeight: 0,
                            initHeight: 0.9,
                            maxHeight: 0.9,
                            context: context,
                            builder: (context, scrollController,
                                    bottomSheetOffset) =>
                                InfoScreen(
                              followComplaints: cubit.prossesComplaints[index],
                              scrollController: scrollController,
                              cubit: cubit,
                            ),
                            isExpand: false,
                          );
                        },
                        child: ListWidget(
                            followComplaints: cubit.prossesComplaints[index]),
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
