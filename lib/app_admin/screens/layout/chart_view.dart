import 'package:flutter/material.dart';

class RevChart extends StatelessWidget {
  const RevChart(
      {Key? key,
      required this.label,
      required this.pct,
      this.iconData,
      required this.mess})
      : super(key: key);
  final String label;
  final String mess;
  final int pct;
  final IconData? iconData;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 13),
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
            Tooltip(
              message: mess,
              textStyle: TextStyle(fontSize: 20, color: Colors.amber),
              child: Container(
                width: MediaQuery.of(context).size.width * (pct / 100) * 2.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.amber),
                child: Text(''),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
