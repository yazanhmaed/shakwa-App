import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pro_test/resources/color_manager.dart';
import 'package:pro_test/resources/components.dart';

import '../../../resources/string_manager.dart';
import '../../../resources/values_manager.dart';
import '../../../translations/locale_keys.g.dart';
import '../drawer_screen/drawer_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class AddCyberCrimes extends StatelessWidget {
  const AddCyberCrimes(
      {super.key,
      required this.title,
      required this.data,
      required this.userid,
      required this.cyberName,
      required this.list});
  final String title;
  final String data;
  final String userid;
  final List cyberName;
  final List list;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCyberCrimesCubit(),
      child: BlocConsumer<AddCyberCrimesCubit, AddCyberCrimesStates>(
        listener: (context, state) {
          if (state is AddCyberCrimesSuccessState) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              borderSide: BorderSide(
                color: ColorManager.primary,
                width: 2,
              ),

              buttonsBorderRadius: const BorderRadius.all(
                Radius.circular(2),
              ),
              dismissOnTouchOutside: false,
              dismissOnBackKeyPress: false,

              headerAnimationLoop: false,
              animType: AnimType.bottomSlide,
              // title: '${message.notification!.title}',
              desc: LocaleKeys.Complaint_sent_successfully.tr(),
              //showCloseIcon: true,
btnOkText: LocaleKeys.ok.tr(),
              btnOkOnPress: () => navigateAndFinish(context, DrawerScreen()),
            ).show();
          }
          if (state is AddCyberCrimesErrorState) {
            Fluttertoast.showToast(
                msg: "${state.error}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (context, state) {
          AddCyberCrimesCubit cubit = AddCyberCrimesCubit.get(context);
          var key = GlobalKey<FormState>();
          FirebaseMessaging.instance.getToken().then((value) {
            cubit.token = value!;
            //  print(value);
          });

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey.shade100,
              title: Text(title),
            ),
            body: Form(
              key: key,
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppString.complaintBackground),
                        fit: BoxFit.fill)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (state is AddCyberCrimesImagePicLoadingState)
                        LinearProgressIndicator(
                          color: ColorManager.primary,
                          backgroundColor: ColorManager.white,
                        ),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 50),
                        decoration: BoxDecoration(
                            color: ColorManager.primary.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Row(
                                      children: [
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Expanded(
                                          child: Text(
                                            LocaleKeys.Select_Social_Media.tr(),
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    items: cyberName
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    value: cubit.selectedValue,
                                    onChanged: (value) {
                                      cubit.changeSwitch(value!);
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 50,
                                      width: double.infinity,
                                      padding: const EdgeInsets.only(
                                          left: 14, right: 14),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          width: 3,
                                          color: ColorManager.white,
                                        ),
                                        color: ColorManager.primary,
                                      ),
                                      elevation: 2,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                        maxHeight: 200,
                                        width: 450,
                                        padding: null,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: ColorManager.white,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: ColorManager.primary,
                                        ),
                                        elevation: 8,
                                        offset: const Offset(5, 0),
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(40),
                                          thickness:
                                              MaterialStateProperty.all(6),
                                          thumbVisibility:
                                              MaterialStateProperty.all(true),
                                        )),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Row(
                                      children: [
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Expanded(
                                          child: Text(
                                            LocaleKeys.Select_complaint.tr(),
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    items: list
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    value: cubit.selectedValue2,
                                    onChanged: (value) {
                                      cubit.changeSwitch2(value!);
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 50,
                                      width: double.infinity,
                                      padding: const EdgeInsets.only(
                                          left: 14, right: 14),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          width: 3,
                                          color: ColorManager.white,
                                        ),
                                        color: ColorManager.primary,
                                      ),
                                      elevation: 2,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                        maxHeight: 200,
                                        width: 450,
                                        padding: null,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: ColorManager.white,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: ColorManager.primary,
                                        ),
                                        elevation: 8,
                                        offset: const Offset(5, 0),
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(40),
                                          thickness:
                                              MaterialStateProperty.all(6),
                                          thumbVisibility:
                                              MaterialStateProperty.all(true),
                                        )),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                  style: const ButtonStyle(
                                      side: MaterialStatePropertyAll(BorderSide(
                                          color: Colors.white, width: 3)),
                                      minimumSize: MaterialStatePropertyAll(
                                          Size(double.infinity, 50))),
                                  onPressed: () => cubit.getImage(),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        LocaleKeys.add_photo.tr(),
                                        style: TextStyle(
                                            color: ColorManager.white),
                                      ),
                                      Icon(
                                        cubit.imagename.isEmpty
                                            ? Icons.camera_alt_outlined
                                            : Icons.check_circle,
                                        color: ColorManager.white,
                                      ),
                                    ],
                                  )),
                              if (cubit.imagename.isNotEmpty)
                                Text(
                                  cubit.imagename,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black54),
                                ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: cubit.linkController,
                                cursorColor: ColorManager.white,
                                maxLines: 1,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return LocaleKeys.Please_Enter_link.tr();
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ColorManager.primary,
                                  focusColor: ColorManager.black,
                                  hoverColor: ColorManager.black,
                                  labelText: LocaleKeys.link.tr(),
                                  labelStyle: TextStyle(
                                      color: ColorManager.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorManager.white,
                                        width: AppSize.s3),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorManager.white, width: 3),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: cubit.docController,
                                cursorColor: ColorManager.white,
                                maxLines: 8,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return LocaleKeys.Please_Enter_Text.tr();
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ColorManager.primary,
                                  focusColor: ColorManager.black,
                                  hoverColor: ColorManager.black,
                                  labelText: LocaleKeys.decscription.tr(),
                                  labelStyle: TextStyle(
                                      color: ColorManager.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorManager.white,
                                        width: AppSize.s3),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorManager.white, width: 3),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              ElevatedButton(
                                style: const ButtonStyle(
                                    side: MaterialStatePropertyAll(BorderSide(
                                        color: Colors.white, width: 3)),
                                    minimumSize: MaterialStatePropertyAll(
                                        Size(150, 50))),
                                onPressed: () {
                                  if (key.currentState!.validate()) {
                                    try {
                                      cubit.addCyberCrimes(
                                        token: cubit.token,
                                        userid: userid,
                                        authority: data,
                                        type: cubit.selectedValue!,
                                        description: cubit.docController.text,
                                        link: cubit.linkController.text,
                                        social: cubit.selectedValue2!,
                                      );
                                    } catch (e) {
                                      print(e);
                                      Fluttertoast.showToast(
                                          msg: LocaleKeys.the_data_correctly
                                              .tr(),
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  }
                                },
                                child: Text(
                                  LocaleKeys.send_complaint.tr(),
                                  style: TextStyle(color: ColorManager.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
