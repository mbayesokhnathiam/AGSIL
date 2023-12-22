class Pub {
  final String? idPub;
  // ignore: non_constant_identifier_names
  final String? affiche;
  final String? contact;

  // ignore: non_constant_identifier_names
  Pub({this.idPub, this.affiche, this.contact});
  @override
  String toString() {
    return '{ ${this.idPub}, ${this.affiche}, ${this.contact}}';
  }

  // ignore: missing_return

  factory Pub.fromJson(dynamic json) {
    return Pub(
        idPub: json['idPub'] as String,
        affiche: json['affiche'] as String,
        contact: json['contact'] as String);
  }
}
