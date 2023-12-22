import 'dart:convert';

class SoireeParjour {
  final String? id;
  // ignore: non_constant_identifier_names
  final String? affiche;
  final String? lieu;
  final String? endroit;

  // ignore: non_constant_identifier_names
  SoireeParjour({this.id, this.affiche, this.lieu, this.endroit});
  @override
  String toString() {
    return '{ ${this.id},${this.affiche}, ${this.lieu},  ${this.endroit} }';
  }

  // ignore: missing_return

  factory SoireeParjour.fromJson(dynamic json) {
    return SoireeParjour(
        id: json['id'] as String,
        affiche: json['affiche'] as String,
        lieu: json['lieu'] as String,
        endroit: json['endroit'] as String);
  }

  static Map<String, dynamic> toMap(SoireeParjour data) => {
        'id': data.id,
        'affiche': data.affiche,
        'lieu': data.lieu,
        'endroit': data.endroit
      };

  static String encode(List<SoireeParjour> list) => json.encode(
        list
            .map<Map<String, dynamic>>((panier) => SoireeParjour.toMap(panier))
            .toList(),
      );

  static List<SoireeParjour> decode(String data) =>
      (json.decode(data) as List<dynamic>)
          .map<SoireeParjour>((item) => SoireeParjour.fromJson(item))
          .toList();
}
