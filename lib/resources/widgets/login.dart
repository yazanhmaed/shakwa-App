import 'package:flutter/material.dart';
import 'package:pro_test/resources/components.dart';
import 'package:pro_test/screens/password_reset/password_reset.dart';
import 'package:text_divider/text_divider.dart';

import '../color_manager.dart';
import '../string_manager.dart';
import '../styles_manager.dart';
import 'button_custom.dart';
import 'input_text.dart';

class LoginBuilder extends StatelessWidget {
  const LoginBuilder({
    super.key,
    required this.emailController,
    required this.passwordController,
    this.onPressed,
    required this.obscureText,
    this.onPressedobscureText,
    this.onTap,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function()? onPressed;
  final Function()? onPressedobscureText;
  final Function()? onTap;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              color: ColorManager.primary.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              InputText(
                type: TextInputType.emailAddress,
                hintText: '',
                validator: 'Enter your Email',
                icon: Icons.email,
                controller: emailController,
                labelText: 'Email',
              ),
              InputText(
                type: TextInputType.visiblePassword,
                hintText: '',
                validator: 'Enter your Password',
                icon: Icons.password,
                controller: passwordController,
                labelText: 'Password',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text(
                        'Forgot password?',
                        style: getBoldStyle(color: ColorManager.black),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () => navigateTo(context, PasswordResetScreen()),
                        child: Text(
                          'click',
                          style:
                              getBoldStyle(color: Colors.amber, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  ButtomCustom(
                    onPressed: onPressed,
                    textStyle: TextStyle(color: ColorManager.white),
                    text: 'Login',
                    color: ColorManager.amber,
                  ),
                ],
              ),
              TextDivider.horizontal(
                  color: ColorManager.amber.withOpacity(0.6),
                  text: const Text('Or'),
                  thickness: 5),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: onTap,
                child: Image.asset(
                  AppString.google,
                  width: 50,
                  height: 50,
                ),
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
