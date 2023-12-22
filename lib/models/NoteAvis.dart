

class NoteAvis{
  final String? id;
  final String? user;
  final String? endroit;
  final String? note;
  final String? avis;
  final String? maxNote;
  final String? prenom;
  final String? nom;
  final String? telephone;
  final String? login;
  final String? mdp;

  NoteAvis({this.id, this.user, this.endroit, this.note, this.avis, this.maxNote, this.prenom, this.telephone, this.nom, this.login, this.mdp});
  @override
  String toString() {
    return '{ ${this.id}, ${this.user}, ${this.endroit}, ${this.note}, ${this.avis}, ${this.maxNote}, ${this.prenom}, ${this.nom}, ${this.telephone}, ${this.login}, ${this.mdp} }';
  }

  // ignore: missing_return

  factory NoteAvis.fromJson(dynamic json) {
    return NoteAvis(
      id: json['id'] as String,
      user: json['user'] as String,
      endroit: json['endroit'] as String,
      note: json['note'] as String,
      avis: json['avis'] as String,
      maxNote : json['Max(note)'] as String,
      prenom: json['prenom'] as String,
      nom: json['nom'] as String,
      telephone: json['telephone'] as String,
      login: json['login'] as String,
      mdp: json['mdp'] as String,
    );
  }

}

