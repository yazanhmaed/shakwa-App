import 'package:flutter/material.dart';

import '../../screens/follow_complaints/cubit/cubit.dart';
import '../color_manager.dart';
import '../styles_manager.dart';

class CardBuild extends StatelessWidget {
  const CardBuild({
    super.key,
    this.model,
    required this.cubit,
  });

  final dynamic model;
  final FollowComplaintsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.primary,
      child: Padding(
        padding: EdgeInsets.only(top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
        child: ExpansionTile(
          iconColor: ColorManager.secondary,
          textColor: ColorManager.white,
          expandedAlignment: Alignment.topLeft,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          title: Image.network(
            '${model.image}',
            fit: BoxFit.cover,
            width: 150,
            height: 250,
          ),
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              'Type : ${model.type}',
              style: getSemiBoldStyle(color: ColorManager.white),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'description : ${model.description}',
              style: getSemiBoldStyle(color: ColorManager.white),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'states : ${model.state}',
              style: getSemiBoldStyle(color: ColorManager.white),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Date : ${model.date.toDate()}',
              style: getSemiBoldStyle(color: ColorManager.white),
            ),
          ],
        ),
      ),
    );
  }
}
