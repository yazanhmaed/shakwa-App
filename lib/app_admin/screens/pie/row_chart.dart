import 'package:flutter/material.dart';

class ReviewChart extends StatelessWidget {
  const ReviewChart(
      {Key? key, required this.label, required this.pct, this.iconData})
      : super(key: key);
  final String label;
  final int pct;
  final IconData? iconData;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(width: 8),
        Icon(
          iconData,
          color: Colors.white,
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
          child: Stack(children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.3)),
              child: Text(''),
            ),
            Container(
              width: MediaQuery.of(context).size.width * (pct / 100) * 2.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.amber),
              child: Text(''),
            ),
          ]),
        ),
      ],
    );
  }
}
