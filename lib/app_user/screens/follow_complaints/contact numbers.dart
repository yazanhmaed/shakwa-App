import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../resources/color_manager.dart';
import '../../../translations/locale_keys.g.dart';
import '../home_screen/components.dart';

class ContactNumbers extends StatelessWidget {
  const ContactNumbers({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> name = [
      LocaleKeys.Anti_Cyber_Crimes.tr(),
      LocaleKeys.Amman_City.tr(),
      LocaleKeys.Electric_Power.tr(),
      LocaleKeys.Agriculture.tr(),
      LocaleKeys.Communications.tr(),
      LocaleKeys.Environment.tr(),
      LocaleKeys.Miyahuna.tr(),
      LocaleKeys.Traffic_Department.tr(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.contact_numbers.tr()),
      ),
      body: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              width: 300,
              height: 400,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    backgroundImage: AssetImage(images[index]),
                  ),
                  SizedBox(height: 20),
                  Text(
                    name[index],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    // ignore: deprecated_member_use
                    onTap: () => launch('tel://${phone[index]}'),
                    child: Text(
                      phone[index],
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    location[index],
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(
                thickness: 1.5,
                color: ColorManager.primary,
              ),
          itemCount: name.length),
    );
  }
}
