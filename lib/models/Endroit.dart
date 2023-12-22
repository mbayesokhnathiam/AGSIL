class Endroit {
  final String? id;
  final String? type;
  final String? icone;
  final String? categorie;
  final String? rubrique;

  Endroit({this.id, this.type, this.icone, this.categorie, this.rubrique});
  @override
  String toString() {
    return '{ ${this.id}, ${this.type}, ${this.icone}, ${this.categorie}, ${this.rubrique} }';
  }

  // ignore: missing_return

  factory Endroit.fromJson(dynamic json) {
    return Endroit(
        id: json['id'] as String,
        type: json['type'] as String,
        icone: json['icone'] as String,
        categorie: json['categorie'] as String,
        rubrique: json['rubrique'] as String);
  }
}
