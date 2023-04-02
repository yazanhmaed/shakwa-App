import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pro_test/resources/color_manager.dart';
import 'package:pro_test/screens/follow_complaints/contact%20numbers.dart';

import '../../resources/cache_helper.dart';
import '../../resources/components.dart';
import '../follow_complaints/follow_complaints.dart';
import '../follow_complaints/previous_complaints.dart';
import '../login_screen/login_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final googleSignIn = GoogleSignIn();
   
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          children: [
            Center(
                child: CircleAvatar(
              backgroundColor: ColorManager.grey1,
              child: FaIcon(
                FontAwesomeIcons.user,
                color: Colors.white,
              ),
              radius: 50,
            )),
            SizedBox(
              height: 10,
            ),
            Text(
              nameUser!,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(
              height: 100,
            ),
            ListTile(
              onTap: () => navigateTo(context, FollowComplaints()),
              leading: FaIcon(
                FontAwesomeIcons.user,
                color: Colors.white,
              ),
              title: Text('Follow Complaint'),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              minLeadingWidth: 38,
              onTap: () => navigateTo(context, PreviousComplaints()),
              leading: FaIcon(
                FontAwesomeIcons.user,
                color: Colors.white,
              ),
              title: Text('Previous Complaints'),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () => navigateTo(context, ContactNumbers()),
              leading: FaIcon(
                FontAwesomeIcons.user,
                color: Colors.white,
              ),
              title: Text('Contact Numbers'),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {
                CacheHelper.removeData(key: 'uId')
                    .then((value) => navigateAndFinish(context, LoginScreen()));
                FirebaseAuth.instance.signOut().then((value) {
                  googleSignIn.disconnect();
                });
              },
              leading: FaIcon(
                FontAwesomeIcons.rightFromBracket,
                color: Colors.white,
              ),
              title: Text('LogOut'),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
