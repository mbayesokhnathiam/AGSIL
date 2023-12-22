import 'dart:async';
//import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
/*
class CheckConnection {
  // ignore: cancel_subscriptions
  StreamSubscription<DataConnectionStatus>? listener;
  // ignore: non_constant_identifier_names
  var InternetStatus = "Unknown";
  var contentmessage = "Unknown";

  void _showDialog(String title, String content, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text(title),
              content: new Text(content),
              actions: <Widget>[
                new GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text("Close"))
              ]);
        });
  }

  checkConnection(BuildContext context) async {
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.disconnected:
          InternetStatus = "You are disconnected to the Internet. ";
          contentmessage = "Please check your internet connection";
          _showDialog(InternetStatus, contentmessage, context);
          break;

        default:
      }
    });
    return await DataConnectionChecker().connectionStatus;
  }
}
*/
