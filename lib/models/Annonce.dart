import 'dart:convert';

class Annonce {
  final String? id;
  // ignore: non_constant_identifier_names
  final String? affiche;
  // ignore: non_constant_identifier_names
  final String? dateAnnonce;
  final String? lieu;
  final String? endroit;

  // ignore: non_constant_identifier_names
  Annonce({this.id, this.affiche, this.dateAnnonce, this.lieu, this.endroit});
  @override
  String toString() {
    return '{ ${this.id}, ${this.affiche},${this.dateAnnonce},${this.lieu},${this.endroit}}';
  }

  // ignore: missing_return

  factory Annonce.fromJson(dynamic json) {
    return Annonce(
        id: json['id'] as String,
        affiche: json['affiche'] as String,
        dateAnnonce: json['dateAnnonce'] as String,
        lieu: json['lieu'] as String,
        endroit: json['endroit'] as String);
  }

  static Map<String, dynamic> toMap(Annonce data) => {
        'id': data.id,
        'affiche': data.affiche,
        'dateAnnonce': data.dateAnnonce,
        'lieu': data.lieu,
        'endroit': data.endroit
      };

  static String encode(List<Annonce> list) => json.encode(
        list
            .map<Map<String, dynamic>>((panier) => Annonce.toMap(panier))
            .toList(),
      );

  static List<Annonce> decode(String data) =>
      (json.decode(data) as List<dynamic>)
          .map<Annonce>((item) => Annonce.fromJson(item))
          .toList();
}
