import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/components.dart';
import '../../../translations/locale_keys.g.dart';
import '../../models/cyber_crimes_model.dart';
import '../cybercrimes/cubit/cubit.dart';

class CyberInfoScreen extends StatefulWidget {
  const CyberInfoScreen(
      {super.key,
      required this.scrollController,
      required this.cyberCrimesModel,
      required this.cubit});
  final ScrollController scrollController;
  final CyberCrimesModel cyberCrimesModel;
  final CyberCrimesCubit cubit;

  @override
  State<CyberInfoScreen> createState() => _CyberInfoScreenState();
}

class _CyberInfoScreenState extends State<CyberInfoScreen>
    with TickerProviderStateMixin {
  Future<void> openUrl() async {
    var nativeUrl = "${widget.cyberCrimesModel.link}";
    var webUrl = "${widget.cyberCrimesModel.link}";

    try {
      await launchUrlString(nativeUrl, mode: LaunchMode.externalApplication);
    } catch (e) {
      print(e);
      await launchUrlString(webUrl, mode: LaunchMode.platformDefault);
    }
  }

  final double infoHeight = 364.0;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;

  late final AnimationController animationController;
  late final Animation<double> animation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future<void> setData() async {
    animationController.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    if (mounted) {
      setState(() {
        opacity1 = 1.0;
      });
    }
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    if (mounted) {
      setState(() {
        opacity2 = 1.0;
      });
    }
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    if (mounted) {
      setState(() {
        opacity3 = 1.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String text = '';

    if (widget.cyberCrimesModel.color == 1) {
      text = LocaleKeys.Accept_Request.tr();
    } else if (widget.cyberCrimesModel.color == 2) {
      text = LocaleKeys.Completed.tr();
    }
    DateTime oldDate = DateTime(
        widget.cyberCrimesModel.timeSpent!.toDate().year,
        widget.cyberCrimesModel.timeSpent!.toDate().month,
        widget.cyberCrimesModel.timeSpent!.toDate().day);
    DateTime newDate = DateTime.now();

    Duration difference = newDate.difference(oldDate);
    int daysBetween = difference.inDays;
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    return Material(
      color: ColorManager.nearlyWhite,
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.2,
                child: GestureDetector(
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (_) => Dialog(
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                widget.cyberCrimesModel.image!),
                                            fit: BoxFit.contain)),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Text(
                                        'X',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                            ));
                  },
                  child: FancyShimmerImage(
                    imageUrl: widget.cyberCrimesModel.image!,
                    shimmerBaseColor: Colors.grey,
                    shimmerHighlightColor: Colors.white54,
                    height: 350,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: ColorManager.nearlyWhite,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(32.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: ColorManager.grey.withOpacity(0.2),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    constraints: BoxConstraints(
                        minHeight: infoHeight,
                        maxHeight:
                            tempHeight > infoHeight ? tempHeight : infoHeight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.only(top: 32.0, left: 18, right: 16),
                          child: Text(
                            '${widget.cyberCrimesModel.type!}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              letterSpacing: 0.27,
                              color: ColorManager.darkerText,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 16, right: 16, bottom: 8, top: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              ElevatedButton(
                                  onPressed: () => openUrl(),
                                  child: Text(LocaleKeys.links.tr())),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  if (widget.cyberCrimesModel.rating != null)
                                    Text(
                                      '${widget.cyberCrimesModel.rating}.0',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 22,
                                        letterSpacing: 0.27,
                                        color: ColorManager.grey,
                                      ),
                                    ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  if (widget.cyberCrimesModel.rating != null)
                                    Icon(
                                      Icons.star,
                                      color: ColorManager.primary,
                                      size: 24,
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          opacity: opacity1,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              child: Row(
                                children: <Widget>[
                                  getTimeBoxUI(
                                      DateFormat.yMd(
                                              draw == false ? 'en' : 'ar')
                                          .format(widget.cyberCrimesModel.date!
                                              .toDate()),
                                      LocaleKeys.date.tr()),
                                  getTimeBoxUI(
                                      '$daysBetween ${LocaleKeys.days.tr()}',
                                      LocaleKeys.Since.tr()),
                                  getTimeBoxUI(
                                      '#${widget.cyberCrimesModel.id2!}',
                                      LocaleKeys.Ref_number.tr()),
                                      if (widget.cyberCrimesModel.note != " ")
                                  GestureDetector(
                                    onTap: () {
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.noHeader,
                                        borderSide: BorderSide(
                                          color: ColorManager.primary,
                                          width: 2,
                                        ),

                                        buttonsBorderRadius:
                                            const BorderRadius.all(
                                          Radius.circular(2),
                                        ),
                                        dismissOnTouchOutside: false,
                                        dismissOnBackKeyPress: false,
                                        body: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: ColorManager.primary,
                                                  width: 2)),
                                          child: Text(
                                              '${widget.cyberCrimesModel.note}'),
                                        ),
                                        headerAnimationLoop: false,
                                        animType: AnimType.bottomSlide,
                                        desc: LocaleKeys
                                            .Complaint_sent_successfully.tr(),
                                        btnOkText: LocaleKeys.ok.tr(),
                                        btnOkOnPress: () {
                                        },
                                      ).show();
                                    },
                                    child: getTimeBoxUI(
                                        LocaleKeys.note.tr(), ''),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Divider(color: ColorManager.primary, thickness: 2),
                        Expanded(
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity2,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 16, right: 16, top: 8, bottom: 8),
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Text(
                                  '${widget.cyberCrimesModel.description!}',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    letterSpacing: 0.27,
                                    color: ColorManager.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (widget.cyberCrimesModel.color! < 3)
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, bottom: 16, right: 16),
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.infoReverse,
                                          borderSide: BorderSide(
                                            color: ColorManager.primary,
                                            width: 2,
                                          ),

                                          buttonsBorderRadius:
                                              const BorderRadius.all(
                                            Radius.circular(2),
                                          ),
                                          dismissOnTouchOutside: false,
                                          dismissOnBackKeyPress: false,
                                          body: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: TextFormField(
                                              controller:
                                                  widget.cubit.noteController,
                                              cursorColor: ColorManager.primary,
                                              style: TextStyle(
                                                  color: ColorManager.black),
                                              maxLines: 3,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return LocaleKeys
                                                      .Please_Enter_Text.tr();
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: ColorManager.white,
                                                focusColor: ColorManager.black,
                                                hoverColor: ColorManager.black,
                                                labelText:
                                                    LocaleKeys.note.tr(),
                                                labelStyle: TextStyle(
                                                    color: ColorManager.primary,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: ColorManager.primary,
                                                      width: 3),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: ColorManager.primary,
                                                      width: 3),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                            ),
                                          ),
                                          headerAnimationLoop: false,
                                          animType: AnimType.bottomSlide,
                                          desc: LocaleKeys
                                              .Complaint_sent_successfully.tr(),
                                          showCloseIcon: true,
                                          btnOkText: LocaleKeys.ok.tr(),
                                          btnOkOnPress: () {
                                            widget.cubit.updateNote(
                                                token: widget
                                                    .cyberCrimesModel.token!,
                                                id: widget.cyberCrimesModel.id!,
                                                id2: widget
                                                    .cyberCrimesModel.id2!,
                                                note: widget
                                                    .cubit.noteController.text);
                                         
                                          },
                                        ).show();
                                      },
                                      icon: Icon(
                                        Icons.note_add,
                                        size: 35,
                                      )),
                                  Expanded(
                                    child: Container(
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: ColorManager.primary,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(16.0),
                                        ),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: ColorManager.grey
                                                  .withOpacity(0.5),
                                              offset: const Offset(1.1, 1.1),
                                              blurRadius: 10.0),
                                        ],
                                      ),
                                      child: Center(
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                            minimumSize: const Size(1000, 48),
                                          ),
                                          onPressed: () {
                                            widget.cubit.updateData(
                                                id: widget.cyberCrimesModel.id!,
                                                color: widget
                                                    .cyberCrimesModel.color!,
                                                id2:
                                                    '${widget.cyberCrimesModel.id2}',
                                                description: widget
                                                    .cyberCrimesModel
                                                    .description!,
                                                state: widget
                                                    .cyberCrimesModel.state!,
                                                token: widget
                                                    .cyberCrimesModel.token!);
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            text,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              letterSpacing: 0.0,
                                              color: ColorManager
                                                  .nearlyWhite,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        SizedBox(
                          height: MediaQuery.of(context).padding.bottom,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          //icon button close
          Positioned(
            top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
            right: 35,
            child: ScaleTransition(
              scale: CurvedAnimation(
                  parent: animationController, curve: Curves.fastOutSlowIn),
              child: Card(
                color: ColorManager.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
                elevation: 10.0,
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: Center(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        minimumSize: const Size(60, 60),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: ColorManager.nearlyWhite,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: ColorManager.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: ColorManager.primary,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: ColorManager.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
