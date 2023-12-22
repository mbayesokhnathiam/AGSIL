import 'dart:convert';

class RegionModel {
  int  id;
  String code;
  String nom_region;
  int  pays_id;
  String   image;
  int is_active;
  RegionModel  ({
      this. id:0,
      this. code:"",
      this.nom_region:"",
      this.pays_id:0,
      this.image:"",
      this.is_active:0

  });
  RegionModel  .fromJson(Map<String, dynamic>  map) :
        id= map['id']  ?? 0,
        code= map['code']  ?? "",
        nom_region = map['nom_region']  ?? "",
        pays_id= map['pays_id']  ?? 0,
        image= map['image']  ?? "",
        is_active= map['is_active']  ?? 0
  ;
  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "nom_region" : nom_region,
    "pays_id": pays_id,
    "image": image,
    "is_active": is_active

  };
  static List<RegionModel > fromJsonList(List list) {
    if (list == null) return [];
    return list.map((item) =>RegionModel .fromJson(item)).toList();
  }


}
