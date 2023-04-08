// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

import 'color_manager.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(
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

showAlertDialog(BuildContext context, Function()? onPressed) {
  // set up the button
  Widget okButton = TextButton(
    onPressed: onPressed,
    child: Text(
      "OK",
      style: TextStyle(color: ColorManager.primary),
    ),
  );
  // ignore: unused_local_variable
  Widget cancelButton = TextButton(
    child: Text(
      "Cancel",
      style: TextStyle(color: ColorManager.primary),
    ),
    onPressed: () => Navigator.pop(context),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    title: Column(
      children: [
        const Text("Data"),
        Divider(
          color: ColorManager.primary,
          thickness: 2,
        )
      ],
    ),
    content: const Text(
      "Please enter the data correctly",
      style: TextStyle(color: Colors.black),
    ),
    actions: [okButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

String? uId;
String? token = '';
String? email = '';
String? passLo = '';
String nameUser = '';

List<String>? favoriteList = [];
