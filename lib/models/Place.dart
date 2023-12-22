import 'dart:convert';

class Place {
  final String? matricule;
  // ignore: non_constant_identifier_names
  final String? nom_endroit;
  // ignore: non_constant_identifier_names
  final String? type_endroit;
  final String? coordonnee;
  final String? phone;
  final String? email;
  final String? adresse;
  // ignore: non_constant_identifier_names
  final String? site_web;
  final String? description;
  // ignore: non_constant_identifier_names
  final String? image_endroit;
  // ignore: non_constant_identifier_names
  final String? image_menu;
  final String? etoiles;
  final String? visite;
  final String? zone;
  final String? menu;

  // ignore: non_constant_identifier_names
  Place(
      {this.matricule,
      // ignore: non_constant_identifier_names
      this.nom_endroit,
      // ignore: non_constant_identifier_names
      this.type_endroit,
      this.coordonnee,
      this.phone,
      this.email,
      this.adresse,
      // ignore: non_constant_identifier_names
      this.site_web,
      this.description,
      // ignore: non_constant_identifier_names
      this.image_endroit,
      // ignore: non_constant_identifier_names
      this.image_menu,
      this.etoiles,
      this.visite,
      this.zone,
      this.menu});
  @override
  String toString() {
    return '{ ${this.matricule}, ${this.nom_endroit}, ${this.type_endroit},${this.coordonnee},${this.phone},${this.email},${this.adresse},${this.site_web},${this.description},${this.image_endroit},${this.image_menu},${this.etoiles},${this.visite},${this.zone}, ${this.menu}   }';
  }

  // ignore: missing_return

  factory Place.fromJson(dynamic json) {
    return Place(
        matricule: json['matricule'] as String,
        nom_endroit: json['nom_endroit'] as String,
        type_endroit: json['type_endroit'] as String,
        coordonnee: json['coordonnee'] as String,
        phone: json['phone'] as String,
        email: json['email'] as String,
        adresse: json['adresse'] as String,
        site_web: json['site_web'] as String,
        description: json['description'] as String,
        image_endroit: json['image_endroit'] as String,
        image_menu: json['image_menu'] as String,
        etoiles: json['etoiles'] as String,
        visite: json['visite'] as String,
        zone: json['zone'] as String,
        menu: json['menu'] as String);
  }

  static Map<String, dynamic> toMap(Place data) => {
        'matricule': data.matricule,
        'nom_endroit': data.nom_endroit,
        'type_endroit': data.type_endroit,
        'coordonnee': data.coordonnee,
        'phone': data.phone,
        'email': data.email,
        'adresse': data.adresse,
        'site_web': data.site_web,
        'description': data.description,
        'image_endroit': data.image_endroit,
        'image_menu': data.image_menu,
        'etoiles': data.etoiles,
        'visite': data.visite,
        'zone': data.zone,
        'menu': data.menu
      };

  static String encode(List<Place> list) => json.encode(
        list
            .map<Map<String, dynamic>>((panier) => Place.toMap(panier))
            .toList(),
      );

  static List<Place> decode(String data) => (json.decode(data) as List<dynamic>)
      .map<Place>((item) => Place.fromJson(item))
      .toList();
}
