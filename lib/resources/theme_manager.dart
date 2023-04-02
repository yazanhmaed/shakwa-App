import './values_manager.dart';
import 'package:flutter/material.dart';

import './styles_manager.dart';
import 'color_manager.dart';
import 'font_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
//main colors
    primaryColor: ColorManager.primary,

    disabledColor: ColorManager.grey1,

//app bar theme
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: ColorManager.primary),
        color: ColorManager.grey2,
        elevation: AppSize.s0,
        //shadowColor: ColorManager.secondary,
        centerTitle: true,
        titleTextStyle:
            getBoldStyle(color: ColorManager.primary, fontSize: FontSize.s22)),

//button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
    ),
//elevated buttom theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle:
            getRegularStyle(color: ColorManager.white, fontSize: FontSize.s18),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s12)),
      ),
    ),
    //text theme
    textTheme: TextTheme(
      // displayLarge:
      //     getLightStyle(color: ColorManager.white, fontSize: FontSize.s22),
      displayLarge: getSemiBoldStyle(
          color: ColorManager.secondary, fontSize: FontSize.s16),
      titleMedium:
          getMediumStyle(color: ColorManager.lightGrey, fontSize: FontSize.s14),
      bodySmall: getRegularStyle(color: ColorManager.grey1),
      bodyLarge: getRegularStyle(color: ColorManager.grey1),
    ),
    // input decoration theme (text form field)
    // inputDecorationTheme: InputDecorationTheme(
    //   focusColor: ColorManager.white,
    //   hoverColor: ColorManager.white,
    //   contentPadding: const EdgeInsets.all(AppPadding.p8),
    //   hintStyle:
    //       getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
    //   labelStyle:
    //       getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s14),
    //   errorStyle: getRegularStyle(color: ColorManager.error),
    //   // enabled Border style
    //   enabledBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: ColorManager.white, width: AppSize.s1_5),
    //     borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
    //   ),
    //   // focused Border style
    //   focusedBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
    //     borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
    //   ),
    //   // error Border style
    //   errorBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: ColorManager.error, width: AppSize.s1_5),
    //     borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
    //   ),
    //   // focused error Border style
    //   focusedErrorBorder: OutlineInputBorder(
    //     borderSide:
    //         BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
    //     borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
    //   ),
    // ),
  );
}
