// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:pro_test/app_user/screens/login_screen/login_screen.dart';

// import '../../../resources/cache_helper.dart';
// import '../../../resources/components.dart';
// import '../../../resources/string_manager.dart';
// import '../../../resources/widgetAdmin/login.dart';
// import '../communications/communications_screen.dart';
// import '../cybercrimes/cybercrimes_screen.dart';
// import '../home_screen/home_screens.dart';
// import 'cubit/cubit.dart';
// import 'cubit/states.dart';

// class LoginAdminScreen extends StatelessWidget {
//   const LoginAdminScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => UserCubit(),
//       child: BlocConsumer<UserCubit, UserStates>(
//         listener: (context, state) {
//           if (state is UserErrorState) {
//             Fluttertoast.showToast(
//                 msg: "تأكد من الايميل و كلمه المرور",
//                 toastLength: Toast.LENGTH_SHORT,
//                 gravity: ToastGravity.BOTTOM,
//                 timeInSecForIosWeb: 1,
//                 backgroundColor: Colors.red,
//                 textColor: Colors.white,
//                 fontSize: 16.0);
//           }

//           if (state is ComplainChangeSwitchState) {
//             CacheHelper.seveData(key: 'uIdA', value: state.uId).then((value) {
//               print(state.uId);
//               uIdA = CacheHelper.getData(key: 'uIdA');
//             });
//           }
//         },
//         builder: (context, state) {
//           var emailController = TextEditingController();
//           var passwordController = TextEditingController();
//           var key = GlobalKey<FormState>();
//           var cubit = UserCubit.get(context);

//           return Scaffold(
//             body: Container(
//               height: double.infinity,
//               decoration: BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage(AppString.background2),
//                       fit: BoxFit.fill)),
//               child: Form(
//                   key: key,
//                   child: SingleChildScrollView(
//                     physics: const BouncingScrollPhysics(),
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 400),
//                       child: LoginBuilder(
//                         cubit: cubit,
//                         emailController: emailController,
//                         passwordController: passwordController,
//                         onPressed2: () =>
//                             navigateAndFinish(context, LoginScreen()),
//                         onPressed: () async {
//                           if (key.currentState!.validate()) {
//                             if (cubit.selectedValue != 'Select Item') {
//                               if (cubit.selectedValue ==
//                                   'AntiCyberCrimesUnit') {
//                                 print('cyber');
//                                 navigateAndFinish(
//                                     context, const CyberCrimesScreen());
//                               } else if (cubit.selectedValue ==
//                                   'MinistryofCommunications') {
//                                 navigateAndFinish(
//                                     context, const CommunicationsScreen());
//                               } else {
//                                 navigateAndFinish(context, const HomeScreens());
//                               }
//                             }
//                           }
//                         },
//                       ),
//                     ),
//                   )),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
