import 'package:flutter/material.dart';

import '../color_manager.dart';
import '../values_manager.dart';

class InputText extends StatelessWidget {
  const InputText({
    super.key,
    required this.hintText,
    required this.validator,
    required this.icon,
    required this.controller,
    this.obscureText,
    required this.labelText,
  });
  final String hintText;
  final String labelText;
  final String validator;
  final bool? obscureText;
  final IconData icon;

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      cursorColor: ColorManager.white,
      obscureText: obscureText ?? false,
      style: TextStyle(color: ColorManager.black),
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
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
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Icon(
            icon,
            color: ColorManager.primary,
          ),
        ),
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.amber, width: AppSize.s1_5),
          borderRadius: BorderRadius.circular(80),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.amber, width: 2),
          borderRadius: BorderRadius.circular(80),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.amber, width: 1),
          borderRadius: BorderRadius.circular(80),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.amber, width: 2),
          borderRadius: BorderRadius.circular(80),
        ),
      ),
    );
  }
}
