import 'dart:convert';

class OptionModel {
  int  id;
  String name;
  String icon;


  OptionModel ({
      this. id:0,
      this.name:"",

      this.icon:"",


  });
  OptionModel .fromJson(Map<String, dynamic>  map) :
        id= map['id']  ?? 0,
        name= map['name']  ?? "",
        icon = map['icon']  ?? ""

  ;
  Map<String, dynamic> toJson() => {
    "id": id,
    "name":  name,
    "icon" : icon


  };
  static List<OptionModel> fromJsonList(List list) {
    if (list == null) return [];
    return list.map((item) =>OptionModel .fromJson(item["option"])).toList();
  }


}
