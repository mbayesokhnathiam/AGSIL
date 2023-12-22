import 'package:delayed_display/delayed_display.dart';
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
                  width: blockSizeHorizontal * 60,
                  height: blockSizeVertical * 6,
                  margin: EdgeInsets.only(
                      top: 30),
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    /*  boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],*/
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  child: Center(
                      child: Text(msg,
                          style: TextStyle(
                              fontSize:
                              blockSizeHorizontal *
                                  3.0,
                              color: Colors.white))),
                ),
                Container(
                  height: blockSizeVertical * 7,
                  width: blockSizeHorizontal * 15,
                  margin: EdgeInsets.all(
                      10),
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.all(Radius.circular(100)),
                    image: DecorationImage(
                      image: AssetImage('assets/avatar.png'),
                      fit: BoxFit.fill,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(
                            0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              ],
            ),



      ],
    )


    ;
  }
}
