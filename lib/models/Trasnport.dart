import 'dart:convert';

class TransportModel {
  int  id;
  String image;
  String name;
  String website;
  String email;
  String description;
  String contact;



  TransportModel ({
      this. id:0,
      this.name:"",

      this.image:"",
    this.website:"",
    this.email:"",
    this.description:"",
    this.contact:"",


  });
  TransportModel .fromJson(Map<String, dynamic>  map) :
        id= map['id']  ?? 0,
        image= map['image']  ?? "",
        name = map['name']  ?? "",

        website= map['website']  ?? "",
        email = map['email']  ?? "",

        description= map['description']  ?? "",
        contact= map['contact']  ?? ""

  ;
  Map<String, dynamic> toJson() => {
    "id": id,
    " image":  image,
    "name" : name,

    "website": website,
    "email":  email,
    "description" : description,
    "contact" : contact,


  };
  static List<TransportModel> fromJsonList(List list) {
    if (list == null) return [];
    return list.map((item) =>TransportModel .fromJson(item)).toList();
  }


}
