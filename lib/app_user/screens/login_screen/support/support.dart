import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



import '../../../../resources/color_manager.dart';
import '../../../../resources/widgets/support_widget.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../support/cubit/states.dart';
import 'cubit/cubit.dart';

class SupportLoginScreen extends StatelessWidget {
  const SupportLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SupportCubit()..getWidet(),
      child: BlocConsumer<SupportCubit, SupportStates>(
        listener: (context, state) async {
          if (state is AddSupportSuccessState) {
            await Future.delayed(const Duration(milliseconds: 800), () {
              SupportCubit.get(context)
                  .sendMessege(text: state.text, context: context);
            });
          }
        },
        builder: (context, state) {
          var cubit = SupportCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                title: Text(LocaleKeys.help.tr()),
              ),
              body: Column(children: [
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: cubit.s.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: chatMess(
                          widget: cubit.s[index].widget!,
                          isSender: cubit.s[index].isSender!),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ]));
        },
      ),
    );
  }

  BubbleChat chatMess({
    required Widget widget,
    required bool isSender,
  }) {
    return BubbleChat(
      text: widget,
      isSender: isSender,
      color: ColorManager.primary.withOpacity(0.8),
      tail: true,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
    );
  }
}
