import 'package:flutter/material.dart';

class Msg extends StatelessWidget {
  final String msg;
  final String msg1;

  Msg({required this.msg, required this.msg1});

  @override
  Widget build(BuildContext context) {
    var blockSizeHorizontal = MediaQuery.of(context).size.width / 100;
    var blockSizeVertical = MediaQuery.of(context).size.height / 100;

    return Column(
      children: [
        Row(
          children: [
            Container(
              height: blockSizeVertical * 7,
              width: blockSizeHorizontal * 15,
              margin: EdgeInsets.all(10),
              child: Image.asset('assets/images/messager.png'),
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: Center(
                    child: Text(msg,
                        style: TextStyle(
                            fontSize: blockSizeHorizontal * 3.8,
                            color: Colors.black))),
              ),
            ),
          ],
        ),
        Row(
          //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: blockSizeVertical * 7,
              width: blockSizeHorizontal * 10,
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.all(14),
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Text(msg1,
                        style: TextStyle(
                            fontSize: blockSizeHorizontal * 3.8,
                            color: Colors.black))),
              ),
            ),
          ],
        )
      ],
    );
  }
}
