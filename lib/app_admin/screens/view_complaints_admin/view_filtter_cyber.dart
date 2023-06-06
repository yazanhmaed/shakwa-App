import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pro_test/app_admin/screens/view_complaints_admin/view_cyber.dart';

import '../cybercrimes/cubit/cubit.dart';
import '../cybercrimes/list_title_widget.dart';

class ViewFilterCyber extends StatelessWidget {
  const ViewFilterCyber(
      {super.key, required this.list, this.cyberCrimes, required this.title});
  final CyberCrimesCubit? cyberCrimes;
  final List list;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: list.length,
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
                      builder: (context, scrollController, bottomSheetOffset) =>
                          CyberInfoScreen(
                        cyberCrimesModel: list[index],
                        scrollController: scrollController,
                        cubit: cyberCrimes!,
                      ),
                      isExpand: false,
                    );
                  },
                  child: ListCyberWidget(eventModel: list[index]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
