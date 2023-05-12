import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import '../../../resources/color_manager.dart';
import '../../../resources/widgets/button_custom.dart';
import '../../models/add_communications_model.dart';
import 'cubit/cubit.dart';

class SheetCommunicationsBuild extends StatelessWidget {
  const SheetCommunicationsBuild(
      {super.key,
      required this.scrollController,
      required this.communicationsModel,
      required this.cubit,});

  final ScrollController scrollController;

  final CommunicationsModel communicationsModel;
  final CommunicationsCubit cubit;
  @override
  Widget build(BuildContext context) {
    String text = '';
    if (communicationsModel.color == 1) {
      text = 'Accept Request';
    } else if (communicationsModel.color == 2) {
      text = 'Completed';
    }
    return Material(
      child: SizedBox(
        height: double.infinity,
        child: Container(
          height: double.infinity,
          color: ColorManager.grey1.withOpacity(0.7),
          child: SingleChildScrollView(
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
                        ' ${communicationsModel.id2!}',
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
                    imageUrl: communicationsModel.image!,
                    shimmerBaseColor: Colors.grey,
                    shimmerHighlightColor: Colors.white54,
                    height: 650,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
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
                        ' ${communicationsModel.type!}',
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
                          ' ${communicationsModel.description!}',
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
                          .format(communicationsModel.date!.toDate())),
                    ],
                  ),
                ),
                Divider(color: ColorManager.primary, thickness: 2),
                const SizedBox(
                  height: 10,
                ),
                if (communicationsModel.color! < 3)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ButtomCustom(
                          onPressed: () {
                            cubit.updateData(
                              id: communicationsModel.id!,
                              color: communicationsModel.color!,
                              id2: '${communicationsModel.id2}',
                              token: communicationsModel.token!,
                              description: communicationsModel.description!,
                              state: communicationsModel.state!,
                            );
                            Navigator.pop(context);
                          },
                          text: text,
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
