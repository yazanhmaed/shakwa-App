import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pro_test/resources/color_manager.dart';
import 'package:pro_test/screens/home_screen/components.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../translations/locale_keys.g.dart';

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
    TextStyle st = TextStyle(color: Colors.black);
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.contact_numbers.tr()),
      ),
      body: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return ListTile(
              leading: IconButton(
                  // ignore: deprecated_member_use
                  onPressed: () => launch('tel://${phone[index]}'),
                  icon: Icon(
                    Icons.phone,
                    color: Colors.black,
                  )),
              title: Text(
                name[index],
                style: st.copyWith(fontSize: 20),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    phone[index],
                    style: st.copyWith(color: Colors.black.withOpacity(0.7)),
                  ),
                  Text(
                    location[index],
                    style: st.copyWith(
                        color: Colors.black.withOpacity(0.7),
                        overflow: TextOverflow.fade),
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
