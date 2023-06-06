import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../resources/widgets/video_player.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../../models/support_model.dart';
import '../../../support/cubit/states.dart';

class SupportCubit extends Cubit<SupportStates> {
  SupportCubit() : super(SupportInitialState());

  static SupportCubit get(context) => BlocProvider.of(context);

  List<SupportModel> s = [];
  void getWidet() {
    emit(SupportLoadingState());
    s.add(SupportModel(
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${LocaleKeys.HI.tr()}! \n${LocaleKeys.help_you.tr()} ',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(height: 30),
            Text(
              LocaleKeys.following_options.tr(),
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                addMessege(text: LocaleKeys.How_to_create_an_account.tr());
              },
              child: Text(LocaleKeys.How_to_create_an_account.tr()),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                addMessege(text: LocaleKeys.How_to_login.tr());
              },
              child: Text(LocaleKeys.How_to_login.tr()),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                addMessege(text: LocaleKeys.Forgot_your_password.tr());
              },
              child: Text(LocaleKeys.Forgot_your_password.tr()),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
        isSender: false));
    emit(SupportSuccessState());
  }

  void addMessege({
    required String text,
  }) {
    s.add(SupportModel(
        widget: Text(
          text,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        isSender: true));
    emit(AddSupportSuccessState(text));
  }

  void sendMessege({
    required String text,
    required BuildContext context,
  }) {
    if (text == LocaleKeys.How_to_create_an_account.tr()) {
      s.add(SupportModel(
          widget: Column(
            children: [
              Text(
                LocaleKeys.How_to_create_an_account.tr(),
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(
                height: 15,
              ),
              AssetVideo(
                video: 'assets/video/signup.mp4',
              )
            ],
          ),
          isSender: false));
    } else if (text == LocaleKeys.How_to_login.tr()) {
      s.add(SupportModel(
          widget: Column(
            children: [
              Text(
                LocaleKeys.How_to_login.tr(),
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(
                height: 15,
              ),
              AssetVideo(
                video: 'assets/video/login.mp4',
              )
            ],
          ),
          isSender: false));
    } else {
      s.add(SupportModel(
          widget: Column(
            children: [
              Text(
                LocaleKeys.Forgot_your_password.tr(),
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(
                height: 15,
              ),
              AssetVideo(
                video: 'assets/video/forgot.mp4',
              )
            ],
          ),
          isSender: false));
    }
    emit(SendSupportSuccessState());
  }
}
