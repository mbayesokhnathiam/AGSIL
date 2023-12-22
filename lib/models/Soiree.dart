import 'dart:convert';

class Soiree {
  final String? id;
  // ignore: non_constant_identifier_names
  final String? dateEvent;
  // ignore: non_constant_identifier_names
  final String? affiche;
  final String? lieu;
  final String? endroit;

  // ignore: non_constant_identifier_names
  Soiree({this.id, this.dateEvent, this.affiche, this.lieu, this.endroit});

  // ignore: missing_return

  factory Soiree.fromJson(dynamic json) {
    return Soiree(
        id: json['id'] as String,
        dateEvent: json['dateEvent'] as String,
        affiche: json['affiche'] as String,
        lieu: json['lieu'] as String,
        endroit: json['endroit'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateEvent': dateEvent,
      'affiche': affiche,
      'lieu': lieu,
      'endroit': endroit,
    };
  }

  @override
  String toString() {
    return '{ ${this.id},${this.dateEvent},${this.affiche}, ${this.lieu}, ${this.endroit} }';
  }

  static Map<String, dynamic> toMap(Soiree data) => {
        'id': data.id,
        'dataEvent': data.dateEvent,
        'affiche': data.affiche,
        'lieu': data.lieu,
        'endroit': data.endroit
      };

  static String encode(List<Soiree> list) => json.encode(
        list
            .map<Map<String, dynamic>>((panier) => Soiree.toMap(panier))
            .toList(),
      );

  static List<Soiree> decode(String data) =>
      (json.decode(data) as List<dynamic>)
          .map<Soiree>((item) => Soiree.fromJson(item))
          .toList();
}
