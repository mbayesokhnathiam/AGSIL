import 'package:ajiledakarv/service/sizeconfig.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Bubble extends StatefulWidget {
  Color? color;
  String? text;
  Bubble(color, text);

  @override
  _BubbleState createState() => _BubbleState();
}

class _BubbleState extends State<Bubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal! * 30,
      height: SizeConfig.blockSizeVertical! * 5,
      margin: EdgeInsets.only(left: SizeConfig.blockSizeVertical! * 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: widget.color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Center(
          child: Text(widget.text!,
              style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 3))),
    );
  }
}
