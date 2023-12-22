import 'dart:convert';

class LocaliteModel {
  int  id;

   String zone_name;
   int region_id;
  int is_active;



  LocaliteModel  ({
     this. id:0,
     this. region_id:0,
      this.zone_name:"",

     this.is_active:0

  });
  LocaliteModel  .fromJson(Map<String, dynamic>  map) :
        id= map['id']  ?? 0,
        region_id= map['region_id']  ?? 0,

        zone_name= map['zone_name']  ?? "",
        is_active= map['is_active']  ?? 0
  ;
  Map<String, dynamic> toJson() => {
    "id": id,
    "region_id": region_id,
    "zone_name": zone_name,
    "is_active": is_active

  };
  static List<LocaliteModel > fromJsonList(List list) {
    if (list == null) return [];
    return list.map((item) =>LocaliteModel .fromJson(item)).toList();
  }


}
