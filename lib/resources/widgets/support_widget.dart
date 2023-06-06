import 'package:flutter/material.dart';

class BubbleChat extends StatelessWidget {
  final double bubbleRadius;
  final bool isSender;
  final Color color;
  final Widget text;
  final bool tail;
  final bool sent;
  final bool delivered;
  final bool seen;
  final TextStyle textStyle;

  const BubbleChat({
    Key? key,
    required this.text,
    this.bubbleRadius = 16,
    this.isSender = true,
    this.color = Colors.white70,
    this.tail = true,
    this.sent = false,
    this.delivered = false,
    this.seen = false,
    this.textStyle = const TextStyle(
      color: Colors.black87,
      fontSize: 16,
    ),
  }) : super(key: key);

  ///chat bubble builder method
  @override
  Widget build(BuildContext context) {
    bool stateTick = false;
    Icon? stateIcon;
    if (sent) {
      stateTick = true;
      stateIcon = const Icon(
        Icons.done,
        size: 18,
        color: Color(0xFF97AD8E),
      );
    }
    if (delivered) {
      stateTick = true;
      stateIcon = const Icon(
        Icons.done_all,
        size: 18,
        color: Color(0xFF97AD8E),
      );
    }
    if (seen) {
      stateTick = true;
      stateIcon = const Icon(
        Icons.done_all,
        size: 18,
        color: Color(0xFF92DEDA),
      );
    }

    return Row(
      children: <Widget>[
        isSender
            ? const Expanded(
                child: SizedBox(
                  width: 5,
                ),
              )
            : Container(),
        Container(
          color: Colors.transparent,
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(bubbleRadius),
                  topRight: Radius.circular(bubbleRadius),
                  bottomLeft: Radius.circular(
                      
                          bubbleRadius
                        
                      ),
                  bottomRight: Radius.circular(
                     
                          
                           bubbleRadius
                     ),
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: stateTick
                        ? const EdgeInsets.fromLTRB(12, 6, 28, 6)
                        : const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 12),
                    child: text,
                  ),
                  stateIcon != null && stateTick
                      ? Positioned(
                          bottom: 4,
                          right: 6,
                          child: stateIcon,
                        )
                      : const SizedBox(
                          width: 1,
                        ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
