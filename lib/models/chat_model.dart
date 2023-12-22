import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Message {
   late String text ;
   late DateTime date;
   late bool isSentByME ;
   

   Message({required this.date , required this.text , required this.isSentByME });
} 