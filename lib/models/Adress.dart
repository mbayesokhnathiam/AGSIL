import 'dart:convert';

class AdressModel {
  int  id;
  String photo;
  String name;
  String phone;
  String email;



  int  region_id;






  AdressModel ({
      this. id:0,
    this. region_id:0,
      this.name:"",

      this.photo:"",
    this.phone:"",
    this.email:"",



  });
  AdressModel .fromJson(Map<String, dynamic>  map) :
        id= map['id']  ?? 0,
        region_id= map['region_id']  ?? 0,
        photo= map['photo']  ?? "",
        name = map['name']  ?? "",

        phone= map['phone']  ?? "",
        email = map['email']  ?? ""



  ;
  Map<String, dynamic> toJson() => {
    "id": id,
    "region_id":  region_id,
    "name" : name,

    "photo": photo,
    "email":  email,
    "phone" : phone,



  };
  static List<AdressModel> fromJsonList(List list) {
    if (list == null) return [];
    return list.map((item) =>AdressModel.fromJson(item)).toList();
  }


}
