import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/add_complaint_model.dart';
import '../../screens/follow_complaints/cubit/cubit.dart';
import '../color_manager.dart';

class SheetBuild extends StatelessWidget {
  const SheetBuild(
      {super.key,
      required this.scrollController,
      required this.followComplaints,
      required this.cubit});

  final ScrollController scrollController;
  //double bottomSheetOffset,
  final AddComplaintModel followComplaints;
  final FollowComplaintsCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: double.infinity,
        child: Container(
          height: double.infinity,
          color: ColorManager.grey1.withOpacity(0.7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Container(
                height: 80,
                color: ColorManager.primary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 1,
                    ),
                    const Icon(
                      Icons.numbers,
                      color: Colors.white,
                    ),
                    Text(
                      ' ${followComplaints.id2!}',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(
                      width: 80,
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_circle_down_rounded,
                          size: 30,
                        )),
                  ],
                ),
              )),
              Center(
                child: Image.network(
                  '${followComplaints.image}',
                  height: 350,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                color: ColorManager.primary,
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(Icons.menu_open_outlined),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      ' ${followComplaints.type!}',
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(Icons.description_outlined),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      ' ${followComplaints.description!}',
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(Icons.date_range),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(DateFormat.yMd()
                        .format(followComplaints.date!.toDate())),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
