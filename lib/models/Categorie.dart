import 'dart:convert';

class CategorieModel {
  int  id;

   String code_category;
  String libelle_category;
  String image_category;


  CategorieModel   ({
     this. id:0,
     this. code_category:"",
     this.libelle_category:"",
     this.image_category:""

  });
  CategorieModel  .fromJson(Map<String, dynamic>  map) :
        id= map['id']  ?? 0,
        code_category= map['code_category']  ?? "",
        libelle_category= map['libelle_category']  ?? "",
        image_category= map['image_category']  ?? ""
  ;
  Map<String, dynamic> toJson() => {
    "id": id,
    "code_category": code_category,
    "libelle_category": libelle_category,
    "image_category": image_category

  };
  static List<CategorieModel  > fromJsonList(List list) {
    if (list == null) return [];
    return list.map((item) =>CategorieModel  .fromJson(item)).toList();
  }


}
