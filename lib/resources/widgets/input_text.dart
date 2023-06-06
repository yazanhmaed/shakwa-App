import 'package:flutter/material.dart';

import '../color_manager.dart';
import '../values_manager.dart';

class InputText extends StatelessWidget {
  const InputText({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.validator,
    this.obscureText,
    this.checkEmail,
    this.readOnly,
    required this.icon,
    this.type,
    this.suffixIcon,
    required this.controller,
  }) : super(key: key);
  final String hintText;
  final String labelText;
  final String validator;
  final bool? obscureText;
  final bool? checkEmail;
  final bool? readOnly;
  final IconData icon;
  final TextInputType? type;
  final Widget? suffixIcon;

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        readOnly: readOnly??false,
        keyboardType: type,
        cursorColor: ColorManager.amber,
        obscureText: obscureText ?? false,
        style: TextStyle(color: ColorManager.black),
        controller: controller,
        validator: checkEmail == true
            ? (value) {
                if (value == null || value.isEmpty) {
                  return validator;
                }
                return null;
              }
            : (value) {
                if (value == null || value.isEmpty || !value.contains('@')) {
                  return validator;
                }
                return null;
              },
        maxLines: 1,
        decoration: InputDecoration(
          filled: true,
          fillColor: ColorManager.white,
          focusColor: ColorManager.white,
          hoverColor: ColorManager.white,
          labelText: labelText,
          labelStyle: TextStyle(
              color: ColorManager.black.withOpacity(0.6),
              fontWeight: FontWeight.bold,
              fontSize: 15),
          suffixIcon: suffixIcon,
          prefixIcon: Icon(
            icon,
            color: ColorManager.primary,
          ),
          hintText: hintText,
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.amber, width: 2),
            borderRadius: BorderRadius.circular(80),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.amber, width: 2),
            borderRadius: BorderRadius.circular(80),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.amber, width: AppSize.s1_5),
            borderRadius: BorderRadius.circular(80),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.amber, width: 2),
            borderRadius: BorderRadius.circular(80),
          ),
        ),
      ),
    );
  }
}
