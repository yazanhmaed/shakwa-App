import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../translations/locale_keys.g.dart';
import '../color_manager.dart';
import 'button_custom.dart';
import 'input_text.dart';

class SignUpBuilder extends StatelessWidget {
  const SignUpBuilder({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.nameController,
    this.onPressed,
    this.onPressedobscureText,
    required this.obscureText,
    required this.positive,
  });
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function()? onPressed;
  final Function()? onPressedobscureText;
  final bool obscureText;
  final int positive;

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: positive,
      duration: const Duration(milliseconds: 1500),
      child: SlideAnimation(
        horizontalOffset: 300,
        child: FadeInAnimation(
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: ColorManager.primary.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                InputText(
                  type: TextInputType.name,
                  hintText: '',
                  validator: LocaleKeys.Enter_your_Name.tr(),
                  icon: Icons.person,
                  controller: nameController,
                  labelText: LocaleKeys.name.tr(),
                ),
                InputText(
                  type: TextInputType.emailAddress,
                  hintText: '',
                  validator: LocaleKeys.Enter_your_Email.tr(),
                  icon: Icons.email,
                  controller: emailController,
                  labelText: LocaleKeys.email.tr(),
                ),
                InputText(
                  type: TextInputType.visiblePassword,
                  hintText: '',
                  validator: LocaleKeys.Enter_your_Password.tr(),
                  icon: Icons.password,
                  controller: passwordController,
                  labelText: LocaleKeys.password.tr(),
                  obscureText: obscureText,
                  suffixIcon: IconButton(
                      onPressed: onPressedobscureText,
                      icon: obscureText == true
                          ? Icon(
                              Icons.visibility,
                              color: ColorManager.primary,
                            )
                          : Icon(
                              Icons.visibility_off,
                              color: ColorManager.primary,
                            )),
                ),
                ButtomCustom(
                  onPressed: onPressed,
                  textStyle: TextStyle(color: ColorManager.white),
                  text: LocaleKeys.signup.tr(),
                  color: ColorManager.amber,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
