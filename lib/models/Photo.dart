import 'dart:convert';

class Photo{
   int? id;
   String? photo;
   String? photoPath;

  Photo({this.photo, this.photoPath, this.id});
  @override
  String toString() {
    return '{ ${this.photo}, ${this.photoPath}, ${this.id} }';
  }

  factory Photo.fromJson(dynamic json) {
    return Photo(
      id: json['id'] as int,
      photo: json['photo'] as String,
      photoPath: json['photoPath'] as String
    );
  }

  static Map<String, dynamic> toMap(Photo panier) => {
        'id': panier.id,
        'photo': panier.photo,
        'photoPath': panier.photoPath
      };

  static String encode(List<Photo> paniers) => json.encode(
        paniers
            .map<Map<String, dynamic>>((panier) => Photo.toMap(panier))
            .toList(),
      );

  static List<Photo> decode(String paniers) =>
      (json.decode(paniers) as List<dynamic>)
          .map<Photo>((item) => Photo.fromJson(item))
          .toList();

}