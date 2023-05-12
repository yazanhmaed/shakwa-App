import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../app_admin/screens/login_screen/cubit/cubit.dart';
import '../color_manager.dart';
import 'button_custom.dart';

class LoginBuilder extends StatelessWidget {
  const LoginBuilder({
    super.key,
    required this.emailController,
    required this.passwordController,
    this.onPressed,
    this.onPressed2,
    required this.cubit,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function()? onPressed;
  final Function()? onPressed2;
  final UserCubit cubit;

  @override
  Widget build(BuildContext context) {
    List<String> nameData = [
      'AntiCyberCrimesUnit',
      'AmmanCity',
      'ElectricPower',
      'MinistryOfAgriculture',
      'MinistryofCommunications',
      'MinistryofEnvironment',
      'Miyahuna',
      'TrafficDepartment',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: ColorManager.primary.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.menu,
                              color: ColorManager.primary,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Select Item',
                              style: TextStyle(
                                fontSize: 16,
                                //fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.6),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  items: nameData
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.8),
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
                    height: 53,
                    padding: const EdgeInsets.only(left: 20, right: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      border: Border.all(
                        width: 1,
                        color: ColorManager.amber,
                      ),
                      color: ColorManager.white,
                    ),
                    elevation: 1,
                  ),
                  dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      width: 300,
                      padding: null,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorManager.white,
                      ),
                      elevation: 8,
                      offset: const Offset(-20, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all(6),
                        thumbVisibility: MaterialStateProperty.all(true),
                      )),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                    padding: EdgeInsets.only(left: 14, right: 14),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // InputText(
              //   hintText: '',
              //   validator: 'Enter your Password',
              //   obscureText: true,
              //   icon: Icons.password,
              //   controller: passwordController,
              //   labelText: '  Password',
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtomCustom(
                    onPressed: onPressed2,
                    textStyle: const TextStyle(color: Colors.black),
                    text: 'Back',
                    color: ColorManager.amber,
                  ),
                  ButtomCustom(
                    onPressed: onPressed,
                    textStyle: const TextStyle(color: Colors.black),
                    text: 'Login',
                    color: ColorManager.amber,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
