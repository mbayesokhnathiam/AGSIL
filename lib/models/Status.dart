import 'dart:convert';

class StatusModel {
  int  id;
  String image;
  String titre;
  int place_id;

  StatusModel ({
      this. id:0,
      this.titre:"",

      this.image:"",
    this.place_id:0


  });
  StatusModel .fromJson(Map<String, dynamic>  map) :
        id= map['id']  ?? 0,
        image= map['image']  ?? "",
        titre = map['titre']  ?? "",
        place_id= map['place_id']  ?? 0

  ;
  Map<String, dynamic> toJson() => {
    "id": id,
    "image":  image,
    "titre" : titre,
    "place_id":place_id


  };
  static List<StatusModel > fromJsonList(List list) {
    if (list == null) return [];
    return list.map((item) =>StatusModel .fromJson(item)).toList();
  }


}
