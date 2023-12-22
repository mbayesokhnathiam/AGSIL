
import 'package:flutter/material.dart';

class Favoris{
  final String? id;
  final String? endroit;
  final String? user;
  Color likeColor = Colors.black;

  Favoris({this.id, this.endroit, this.user});
  @override
  String toString() {
    return '{ ${this.id}, ${this.endroit}, ${this.user} }';
  }

  // ignore: missing_return

  factory Favoris.fromJson(dynamic json) {
    return Favoris(
        id: json['id'] as String,
        endroit: json['endroit'] as String,
        user: json['user'] as String
    );
  }

}

