import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pro_test/screens/follow_complaints/cubit/cubit.dart';
import 'package:pro_test/screens/follow_complaints/cubit/states.dart';

import '../../resources/widgets/bottom_sheet.dart';

import '../../resources/widgets/listtitle_widget.dart';

class PreviousComplaints extends StatelessWidget {
  const PreviousComplaints({super.key});

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
              title: Text('Previous Complaints'),
            ),
            body: ListView.builder(
              itemCount: cubit.completeComplaints.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 1500),
                  child: SlideAnimation(
                    horizontalOffset: 300,
                    child: FadeInAnimation(
                      child: GestureDetector(
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
