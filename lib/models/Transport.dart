import 'dart:convert';

class Transport {
  final String? id;
  // ignore: non_constant_identifier_names
  final String? nom;
  final String? photo;
  final String? contact;
  // ignore: non_constant_identifier_names
  final String? endroit;
  final String? site;
  final String? description;
  final String? email;

  // ignore: non_constant_identifier_names
  Transport(
      {this.id,
      this.nom,
      this.endroit,
      this.photo,
      this.contact,
      this.site,
      this.description,
      this.email});
  @override
  String toString() {
    return '{ ${this.id}, ${this.nom}, ${this.endroit}, ${this.photo}, ${this.contact}, ${this.site}, ${this.description}, ${this.email}}';
  }

  // ignore: missing_return

  factory Transport.fromJson(dynamic json) {
    return Transport(
        id: json['id'] as String,
        nom: json['nom'] as String,
        photo: json['photo'] as String,
        contact: json['contact'] as String,
        endroit: json['endroit'] as String,
        site: json['site'] as String,
        description: json['description'] as String,
        email: json['email'] as String);
  }

  static Map<String, dynamic> toMap(Transport data) => {
        'id': data.id,
        'nom': data.nom,
        'photo': data.photo,
        'contact': data.contact,
        'endroit': data.endroit,
        'site': data.site,
        'description': data.description,
        'email': data.email
      };

  static String encode(List<Transport> list) => json.encode(
        list
            .map<Map<String, dynamic>>((panier) => Transport.toMap(panier))
            .toList(),
      );

  static List<Transport> decode(String data) =>
      (json.decode(data) as List<dynamic>)
          .map<Transport>((item) => Transport.fromJson(item))
          .toList();
}
