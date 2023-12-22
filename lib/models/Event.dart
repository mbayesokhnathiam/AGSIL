import 'dart:convert';

class EventModel {
  int  id;

   String event_title;
  String event_detail;
  String event_date;
  String event_time;
  String event_image;
  String event_address;
  String event_telephone;
   int category_id;
  int place_id;
  int is_active;
  int price;









  EventModel  ({
     this. id:0,

    this.event_title:"",
    this.event_detail:"",
    this.event_date:"",
    this.event_time:"",
    this.event_image:"",
    this.event_address:"",
    this. event_telephone:"",
    this.category_id:0,
    this.place_id:0,
    this.is_active:0,
    this.price:0


  });
  EventModel  .fromJson(Map<String, dynamic>  map) :
        id= map['id']  ?? 0,

        event_title= map['event_title']  ?? "",
  event_detail= map['event_detail']  ?? "",
  event_date= map['event_date']  ?? "",
  event_time= map['event_time']  ?? "",
  event_image= map['event_image']  ?? "",
  event_address= map['event_address']  ?? "",
  event_telephone= map['event_telephone']  ?? "",
  category_id= map['category_id']  ?? 0,
  place_id= map['place_id']  ?? 0,
  is_active= map['is_active']  ?? 0,
  price= map['price']  ?? 0
  ;
  Map<String, dynamic> toJson() => {
    "id": id,

    "event_title":event_title,
    "event_detail":event_detail,
    "event_date":event_date,
    "event_time":event_time,
    "event_image":event_image,
    "event_address":event_address,
    "event_telephone": event_telephone,
    "category_id": category_id,
    "place_id": place_id,
    "is_active":is_active,
    "price":price

  };
  static List<EventModel  > fromJsonList(List list) {
    if (list == null) return [];
    return list.map((item) =>EventModel .fromJson(item)).toList();
  }


}
