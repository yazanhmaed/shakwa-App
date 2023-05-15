import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../app_admin/models/event.dart';
import '../../app_admin/screens/home_screen/cubit/cubit.dart';
import '../color_manager.dart';
import '../widgets/button_custom.dart';

class SheetBuild extends StatelessWidget {
  const SheetBuild(
      {super.key,
      required this.scrollController,
      required this.complaintsModel,
      required this.cubit});

  final ScrollController scrollController;
  //double bottomSheetOffset,
  final ComplaintsModel complaintsModel;
  final ComplaintsCubit cubit;
  @override
  Widget build(BuildContext context) {
    openMapsSheet(context) async {
      try {
        final coords = Coords(double.parse(complaintsModel.latitude!),
            double.parse(complaintsModel.longitude!));
        var title = "${complaintsModel.type}";
        final availableMaps = await MapLauncher.installedMaps;

        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: title,
                        ),
                        title: Text(
                          map.mapName,
                          style: TextStyle(color: ColorManager.primary),
                        ),
                        leading: SvgPicture.asset(
                          map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      } catch (e) {
        print(e);
      }
    }

    String text = '';
    if (complaintsModel.color == 1) {
      text = 'Accept Request';
    } else if (complaintsModel.color == 3) {
      text = 'Completed';
    }
    return Material(
      child: SizedBox(
        height: double.infinity,
        child: Container(
          height: double.infinity,
          color: ColorManager.grey1.withOpacity(0.7),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Container(
                  height: 80,
                  color: ColorManager.primary,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 1,
                      ),
                      const Icon(
                        Icons.numbers,
                        color: Colors.white,
                      ),
                      Text(
                        ' ${complaintsModel.id2!}',
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      const SizedBox(
                        width: 80,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_circle_down_rounded,
                            size: 30,
                            color: Colors.white,
                          )),
                    ],
                  ),
                )),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: FancyShimmerImage(
                    imageUrl: complaintsModel.image!,
                    shimmerBaseColor: Colors.grey,
                    shimmerHighlightColor: Colors.white54,
                    height: 350,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Column(),
                Divider(color: ColorManager.primary, thickness: 2),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.menu_open_outlined),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        ' ${complaintsModel.type!}',
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.description_outlined),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          ' ${complaintsModel.description!}',
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black, height: 2),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.date_range),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(DateFormat.yMd()
                          .format(complaintsModel.date!.toDate())),
                      const Spacer(),
                      ElevatedButton(
                          onPressed: () {
                            openMapsSheet(context);

                            // openMap();
                          },
                          child: const Text('Location')),
                    ],
                  ),
                ),
                Divider(color: ColorManager.primary, thickness: 2),
                const SizedBox(
                  height: 10,
                ),
                if (complaintsModel.color! == 1 || complaintsModel.color! == 3)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ButtomCustom(
                          onPressed: () {
                            cubit.updateData(
                                id: complaintsModel.id!,
                                color: complaintsModel.color!,
                                id2: '${complaintsModel.id2}',
                                description: complaintsModel.description!,
                                state: complaintsModel.state!,
                                token: complaintsModel.token!);
                            Navigator.pop(context);
                          },
                          text: text,
                          color: ColorManager.primary,
                          textStyle: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        )),
                  ),
                if (complaintsModel.color! == 2)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ButtomCustom(
                          onPressed: () {
                            cubit.getImage().then((value) {
                              cubit.updateImage(
                                color: complaintsModel.color!,
                                id: complaintsModel.id!,
                                id2: complaintsModel.id2!,
                                description: complaintsModel.description!,
                                state: complaintsModel.state!,
                                token: complaintsModel.token!,
                              );
                            });
                            Navigator.pop(context);
                          },
                          text: 'Add Images',
                          color: ColorManager.primary,
                          textStyle: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        )),
                  ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
