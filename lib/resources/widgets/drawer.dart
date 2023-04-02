import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pro_test/screens/follow_complaints/follow_complaints.dart';
import 'package:pro_test/screens/login_screen/login_screen.dart';

import '../../screens/follow_complaints/previous_complaints.dart';
import '../cache_helper.dart';
import '../color_manager.dart';
import '../components.dart';
import '../styles_manager.dart';

class DrawerBuilder extends StatelessWidget {
  const DrawerBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final googleSignIn = GoogleSignIn();
    return Drawer(
        backgroundColor: ColorManager.primary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: ColorManager.secondary,
              child: Column(
                children: [
                  Image.asset('assets/images/app.png'),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Your Name',
                    style: getBoldStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            TextButton.icon(
                onPressed: () => navigateTo(context, FollowComplaints()),
                icon: Icon(
                  FontAwesomeIcons.personDigging,
                  color: Colors.black,
                  size: 30,
                ),
                label: Text(
                  'Follow up on complaints',
                  style: getBoldStyle(color: Colors.white, fontSize: 20),
                )),
            TextButton.icon(
                onPressed: () => navigateTo(context, PreviousComplaints()),
                icon: Icon(
                  Icons.history,
                  color: Colors.black,
                  size: 30,
                ),
                label: Text(
                  'Previous complaints',
                  style: getBoldStyle(color: Colors.white, fontSize: 20),
                )),
            TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.phone,
                  color: Colors.black,
                  size: 30,
                ),
                label: Text(
                  'Contact Numbers',
                  style: getBoldStyle(color: Colors.white, fontSize: 20),
                )),
            TextButton.icon(
                onPressed: () {
                  CacheHelper.removeData(key: 'uId').then(
                      (value) => navigateAndFinish(context, LoginScreen()));
                  FirebaseAuth.instance.signOut().then((value) {
                    googleSignIn.disconnect();
                  });
                },
                icon: Icon(
                  FontAwesomeIcons.rightFromBracket,
                  color: Colors.black,
                  size: 30,
                ),
                label: Text(
                  'Log out',
                  style: getBoldStyle(color: Colors.white, fontSize: 20),
                )),
            SizedBox(
              height: 100,
            ),
            Center(
              child: Text(
                'version 1.0.2',
                style: TextStyle(color: Colors.black45, fontSize: 12),
              ),
            )
          ],
        ));
  }
}
