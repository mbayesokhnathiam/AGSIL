class Tarif{
  final String? id;
  // ignore: non_constant_identifier_names
  final String? personne;
  // ignore: non_constant_identifier_names
  final String? prix;
  final String? type;
  

  // ignore: non_constant_identifier_names
  Tarif({this.id, this.personne, this.prix, this.type,});
  @override
  String toString() {
    return '{ ${this.id}, ${this.personne}, ${this.prix}, ${this.type},}';
  }

  // ignore: missing_return

  factory Tarif.fromJson(dynamic json) {
    return Tarif(
        id: json['id'] as String,
        personne: json['personne'] as String,
        prix: json['prix'] as String,
        type: json['type'] as String,
        );
       
        
  }

}

