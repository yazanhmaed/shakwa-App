import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../color_manager.dart';
import '../styles_manager.dart';
import '../values_manager.dart';

class Fallback extends StatelessWidget {
  const Fallback({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            FontAwesomeIcons.filePdf,
            size: 50,
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          Text(
            'The page is empty',
            style: getMediumStyle(color: ColorManager.black, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
