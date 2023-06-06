// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';


 navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

 navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );



String? uId;
String? uIdA;
String? token = '';
String? admin = '';
String? passLo = '';
String nameUser = '';

bool? draw;



