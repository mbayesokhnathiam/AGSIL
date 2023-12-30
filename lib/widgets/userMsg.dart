import 'package:flutter/material.dart';

class UserMsg extends StatelessWidget {
  final String msg;


  UserMsg ({ required this.msg});

  @override
  Widget build(BuildContext context) {
    var  blockSizeHorizontal = MediaQuery.of(context).size.width / 100;
    var   blockSizeVertical =MediaQuery.of(context).size.height / 100;

    return  Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Container(
                  padding: EdgeInsets.all(14),
                  margin: EdgeInsets.only(
                      top: 10),
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: Center(
                      child: Text(msg,
                          style: TextStyle(
                              fontSize:
                              blockSizeHorizontal *
                                  3.8,
                              color: Colors.white))),
                ),
                Container(
                  height: blockSizeVertical * 7,
                  width: blockSizeHorizontal * 15,
                  margin: EdgeInsets.all(
                      10),
                  padding: EdgeInsets.all(6),
                  child: Image.asset('assets/avatar.png'),
                ),
              ],
            ),



      ],
    )


    ;
  }
}
