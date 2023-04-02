import 'package:flutter/material.dart';
import 'package:pro_test/screens/home_screen/components.dart';

import '../../resources/color_manager.dart';
import '../../resources/components.dart';

import '../../resources/values_manager.dart';
import 'add_antiCyber.dart';

class AntiCyber extends StatelessWidget {
  const AntiCyber({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.secondary,
      appBar: AppBar(
        title: const Text(
          'Anti Cyber Crimes Unit',
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () async {
        //         CacheHelper.removeData(key: AppString.tokenKey);
        //         CacheHelper.removeData(key: AppString.passKey);
        //         CacheHelper.removeData(key: AppString.emailKey);
        //         CacheHelper.removeData(key: 'fav');
        //         var sharedPreferences = await SharedPreferences.getInstance();
        //         sharedPreferences.remove('l');
        //         navigateAndFinish(context, LoginScreen());
        //       },
        //       icon: Icon(
        //         Icons.login_outlined,
        //         color: ColorManager.white,
        //         size: 30,
        //       )),
        //   const SizedBox(
        //     width: 10,
        //   )
        // ],
      ),
      body: GridView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: cyberScreen.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          // mainAxisExtent: 250,
          // mainAxisSpacing: 50,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => navigateTo(
                context,
                AddAntiCyber(
                  title: cyberName[index],
                )),
            //Container Card Style
            child: Container(
              padding: const EdgeInsets.all(AppPadding.p25),
              margin: const EdgeInsets.all(AppMargin.m8),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: ColorManager.lightGrey, width: Appwidth.w5),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(AppSize.s2, AppSize.s5),
                      blurRadius: AppSize.s2,
                      color: ColorManager.white,
                      //  inset: true,
                    ),
                  ],
                  // borderRadius: BorderRadius.circular(AppSize.s20),
                  color: ColorManager.primary),
              child: Icon(
                cyberIcon[index],
                size: 100,
              ),
            ),
          );
        },
      ),
    );
  }
}
