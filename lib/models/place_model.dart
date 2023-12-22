


class PlaceModel{
 int  id;

 String name;
 int  type_id;
 String   phone;
 String   email;
 String  address;
 String  website;
 String   menu;
 String   description;
 String  image_place;
 String  image_menu;
 int  stars;
 int visit;
 int zone_id;
 String  localisation;
 int  is_active;
 int price;

 PlaceModel({
 this.id:0,

  this.name:"",
  this.type_id:0,
  this. phone:"",
  this. email:"",
  this. address:"",
  this.website:"",
  this. menu:"",
  this.description:"",
  this.image_place:"",
  this. image_menu:"",
  this.stars:0,
  this.visit:0,
  this.zone_id =0,
  this. localisation:"",

  this.is_active:0,
  this.price:0,}

 );
 PlaceModel .fromJson(Map<String, dynamic>  map) :
      id= map['id']  ?? 0,
      name= map['name']  ?? "",
      type_id= map['type_id']  ?? 0,
      phone= map['phone']  ?? "",
      email= map['email']  ?? "",
      address= map['address']  ?? "",
      website= map['website']  ?? "",
      menu= map['menu']  ?? "",
      description= map['description']  ?? "",
      image_place= map['image_place']  ?? "",
      image_menu= map['image_menu']  ?? "",
      stars= map['stars']  ?? "",

      visit= map['visit']  ??0,
      zone_id= map['zone_id']  ?? 0,
      localisation= map['localisation']  ?? "",

      is_active= map['is_active']  ?? 0,
      price= map['price']  ?? 0;

 Map<String, dynamic> toJson() => {
  "id": id,
  "name":name,
  "type_id":type_id,
  "phone":phone,
  "email":email,
  "address":address,
  "website":website,
  "menu":menu,
  "description":description,
  "image_place":image_place,
  "image_menu":image_menu,
  "stars":stars,
  "visit":visit,
  "zone_id":zone_id,
  "localisation":localisation,

  "is_active":is_active,
  "price":price

 };
 static List<PlaceModel> fromJsonList(List list) {
  if (list == null) return [];
  return list.map((item) =>PlaceModel .fromJson(item)).toList();
 }


}


