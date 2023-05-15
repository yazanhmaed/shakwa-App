import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_test/app_user/screens/support/cubit/states.dart';
import 'package:pro_test/resources/components.dart';

import '../../../../resources/widgets/video_player.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../models/support_model.dart';

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
              '${LocaleKeys.HI.tr()} $nameUser ! \n${LocaleKeys.help_you.tr()} ',
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
                addMessege(text: LocaleKeys.How_to_send_a_complaint.tr());
              },
              child:  Text(LocaleKeys.How_to_send_a_complaint.tr()),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                addMessege(text: LocaleKeys.How_to_track_a_complaint.tr());
              },
              child:  Text(LocaleKeys.How_to_track_a_complaint.tr()),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                addMessege(text: LocaleKeys.How_to_delete_the_complaint.tr());
              },
              child:  Text(LocaleKeys.How_to_delete_the_complaint.tr()),
            ),
            SizedBox(height: 10,)
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
    if (text == LocaleKeys.How_to_send_a_complaint.tr()) {
      s.add(SupportModel(
          widget: Column(
            children: [
              Text(
                LocaleKeys.How_to_send_a_complaint.tr(),
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(
                height: 15,
              ),
              AssetVideo(
                video: 'assets/video/send_a_complaint.mp4',
              )
            ],
          ),
          isSender: false));
    } else if (text == LocaleKeys.How_to_track_a_complaint.tr()) {
      s.add(SupportModel(
          widget: Column(
            children: [
              Text(LocaleKeys.How_to_track_a_complaint.tr(),
              style: TextStyle(fontSize: 18, color: Colors.white),),
              SizedBox(
                height: 15,
              ),
              AssetVideo(
                video: 'assets/video/track_a_complaint.mp4',
              )
            ],
          ),
          isSender: false));
    } else {
      s.add(SupportModel(
          widget: Column(
            children: [
              Text(LocaleKeys.How_to_delete_the_complaint.tr(),
              style: TextStyle(fontSize: 18, color: Colors.white),),
              SizedBox(
                height: 15,
              ),
              AssetVideo(
                video: 'assets/video/delete_the_complaint.mp4',
              )
            ],
          ),
          isSender: false));
    }
    emit(SendSupportSuccessState());
    // getWidet();
  }
}
