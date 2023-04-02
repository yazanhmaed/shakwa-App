import 'package:flutter/material.dart';

import '../color_manager.dart';
import '../values_manager.dart';

class ListSetting extends StatelessWidget {
  final Function()? ontap;
  final String text;
  final Widget? trainling;
  const ListSetting({
    Key? key, required this.ontap, required this.text,required this.trainling,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppMargin.m10),
      color: ColorManager.primary,
      child: ListTile(
        onTap: ontap,
        title: Text(
         text,
          style:
              TextStyle(color: ColorManager.white, fontWeight: FontWeight.bold),
        ),
        trailing: trainling,
      ),
    );
  }
}