class Activite {
   late String name ;
   late String imgUrl;

   Activite({required this.name , required this.imgUrl });
}


  final List<Activite> activiteListe = [
    Activite(name: 'Dakar', imgUrl: 'assets/images/dakar.jpeg'),
    Activite(name: 'Casamance', imgUrl: 'assets/images/casa.jpeg'),
    Activite(name: 'île de Gorée', imgUrl: 'assets/images/gore.jpeg'),
    Activite(name: 'lac rose', imgUrl: 'assets/images/lac.jpeg'),
    Activite(name: 'île de ngor', imgUrl: 'assets/images/ngor.jpeg'),
    Activite(name: 'Petite cote', imgUrl: 'assets/images/petitecote.jpeg'),
    Activite(name: 'Saint Louis', imgUrl: 'assets/images/sl.jpeg'),
    Activite(name: 'île du Saloum', imgUrl: 'assets/images/dakar.jpeg'),
  ];
  