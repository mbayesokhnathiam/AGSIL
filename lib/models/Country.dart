import 'dart:convert';

class CountryModel {
  int  id;
  int code;
  String alpha2;
  String  alpha3;
  String  nom_fr_fr;
  String  nom_en_gb;
  String   icon;
  int is_active;



  CountryModel ({
     this. id:0,
     this. code:0,
    this.alpha2:"",
      this.alpha3:"",
     this.nom_fr_fr:"",
     this.nom_en_gb:"",
       this.icon:"",
     this.is_active:0

  });
  CountryModel .fromJson(Map<String, dynamic>  map) :
        id= map['id']  ?? 0,
        code= map['code']  ?? 0,
        alpha2 = map['alpha2']  ?? "",
        alpha3= map['alpha3']  ?? "",
        nom_fr_fr = map['nom_fr_fr']  ?? "",
        nom_en_gb= map['nom_en_gb']  ?? "",
        icon= map['icon']  ?? "",
        is_active= map['is_active']  ?? 0
  ;
  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "alpha2" : alpha2,
    "alpha3": alpha3,
    "nom_fr_fr" : nom_fr_fr,
    "nom_en_gb":nom_en_gb,
    "icon": icon,
    "is_active": is_active

  };
  static List<CountryModel> fromJsonList(List list) {
    if (list == null) return [];
    return list.map((item) =>CountryModel.fromJson(item)).toList();
  }


}
