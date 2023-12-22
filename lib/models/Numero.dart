import 'dart:convert';

class Numero {
  final String? id;
  // ignore: non_constant_identifier_names
  final String? nom_endroit;
  // ignore: non_constant_identifier_names
  final String? telephone;
  final String? lieu;

  // ignore: non_constant_identifier_names
  Numero({this.id, this.nom_endroit, this.telephone, this.lieu});
  @override
  String toString() {
    return '{ ${this.id}, ${this.nom_endroit}, ${this.telephone}, ${this.lieu}}';
  }

  factory Numero.fromJson(dynamic json) {
    return Numero(
        id: json['id'] as String,
        nom_endroit: json['nom_endroit'] as String,
        telephone: json['telephone'] as String,
        lieu: json['lieu'] as String);
  }

  static Map<String, dynamic> toMap(Numero data) => {
        'id': data.id,
        'nom_endroit': data.nom_endroit,
        'telephone': data.telephone,
        'lieu': data.lieu
      };

  static String encode(List<Numero> list) => json.encode(
        list
            .map<Map<String, dynamic>>((panier) => Numero.toMap(panier))
            .toList(),
      );

  static List<Numero> decode(String data) =>
      (json.decode(data) as List<dynamic>)
          .map<Numero>((item) => Numero.fromJson(item))
          .toList();
}
