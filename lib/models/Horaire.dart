class Horaire{
  final String? id;
  // ignore: non_constant_identifier_names
  final String? jour;
  // ignore: non_constant_identifier_names
  final String? hD;
  // ignore: non_constant_identifier_names
  final String? lD;
  // ignore: non_constant_identifier_names
  final String? type;
  

  // ignore: non_constant_identifier_names
  Horaire({this.id, this.jour, this.hD, this.lD, this.type,});
  @override
  String toString() {
    return '{ ${this.id}, ${this.jour}, ${this.hD}, ${this.lD}, ${this.type},}';
  }

  // ignore: missing_return

  factory Horaire.fromJson(dynamic json) {
       return Horaire(
        id: json['id'] as String,
        jour: json['jour'] as String,
        hD: json['HD'] as String,
        lD: json['LD'] as String,
        type: json['type'] as String);
  }

}

