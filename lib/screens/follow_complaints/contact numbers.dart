import 'package:flutter/material.dart';
import 'package:pro_test/resources/color_manager.dart';
import 'package:pro_test/screens/home_screen/components.dart';

class ContactNumbers extends StatelessWidget {
  const ContactNumbers({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle st = TextStyle(color: Colors.black);
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Numbers'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(
                Icons.phone,
                color: Colors.black,
              ),
              title: Text(
                name[index],
                style: st,
              ),
              subtitle: Row(
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
                color: ColorManager.primary,
              ),
          itemCount: name.length),
    );
  }
}
