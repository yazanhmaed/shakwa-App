import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../app_admin/models/event.dart';
import '../../translations/locale_keys.g.dart';
import '../components.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({super.key, required this.complaintsModel});

  final ComplaintsModel complaintsModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: _getBGClr(complaintsModel.color),
      ),
      child: Row(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  complaintsModel.type!,
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_filled_rounded,
                      size: 18,
                      color: Colors.grey[200],
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${DateFormat.yMd(draw == false ? 'en' : 'ar').format(complaintsModel.date!.toDate())} ',
                      style: TextStyle(fontSize: 13, color: Colors.grey[100]),
                    )
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
          )),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            color: Colors.grey[200]!.withOpacity(0.7),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              complaintsModel.state == 'Waiting'
                  ? LocaleKeys.waiting.tr()
                  : complaintsModel.state == 'Prosses'
                      ? LocaleKeys.Prosses.tr()
                      : LocaleKeys.Success.tr(),
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[200],
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  _getBGClr(int? color) {
    switch (color) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.amber;
      case 3:
        return Colors.amber;
      default:
        return Colors.green;
    }
  }
}
