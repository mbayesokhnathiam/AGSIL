class User{
  final String? id;
  final String? prenom;
  final String? nom;
  final String? telephone;
  final String? login;
  final String? mdp;
  final String? idMax;
  final String? nomMax;
  final String? prenomMax;

  User({this.id, this.prenom, this.telephone, this.nom, this.login, this.mdp, this.idMax, this.nomMax, this.prenomMax});
  @override
  String toString() {
    return '{ ${this.id}, ${this.prenom}, ${this.nom}, ${this.telephone}, ${this.login}, ${this.mdp}, ${this.idMax}, ${this.nomMax}, ${this.prenomMax} }';
  }


  factory User.fromJson(dynamic json) {
    return User(
        id: json['id'] as String,
        prenom: json['prenom'] as String,
        nom: json['nom'] as String,
        telephone: json['telephone'] as String,
        login: json['login'] as String,
        mdp: json['mdp'] as String,
        idMax : json['MAX(id)'] as String,
        nomMax : json['MAX(nom)'] as String,
        prenomMax : json['MAX(prenom)'] as String
    );
       
  }
}