import 'package:ajiledakarv/common/color.dart';
import 'package:ajiledakarv/models/Categorie.dart';
import 'package:ajiledakarv/models/Option.dart';
import 'package:ajiledakarv/models/activite_model.dart';
import 'package:ajiledakarv/models/place.dart';
import 'package:ajiledakarv/models/place_model.dart';
import 'package:ajiledakarv/screen/explorer/detail_city_explore.dart';
import 'package:ajiledakarv/services/apiService.dart';
import 'package:ajiledakarv/utils/const.dart';
import 'package:ajiledakarv/widgets/loader.dart';
import 'package:ajiledakarv/widgets/modalClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:open_share_pro/open.dart';
import '../../models/Event.dart';
import 'package:maps_launcher/maps_launcher.dart';

class ShowDetail extends StatefulWidget {
  final int id;
  ShowDetail({
    super.key,
    required this.id,
  });

  @override
  State<ShowDetail> createState() => _ExploreDetailState();
}

class _ExploreDetailState extends State<ShowDetail> {
  bool _loading = false;
  String type = "";
  String? token;
  EventModel event = EventModel(
      id: 0,
      event_title: "",
      event_detail: "",
      event_date: "",
      event_time: "",
      event_image: "",
      event_address: "",
      event_telephone: "",
      category_id: 0,
      place_id: 0,
      is_active: 0,
      price: 0);
  CategorieModel categorie = CategorieModel(
      id: 0, code_category: "", libelle_category: "", image_category: "");
  PlaceModel place = PlaceModel(
    id: 0,
    name: "",
    type_id: 0,
    phone: "",
    email: "",
    address: "",
    website: "",
    menu: "",
    description: "",
    image_place: "",
    image_menu: "",
    stars: 0,
    visit: 0,
    zone_id: 0,
    localisation: "",
    is_active: 0,
    price: 0,
  );

  List<OptionModel> options = [];

  getDetails() async {
    setState(() {
      _loading = true;
    });
    var response;
    List msg = [];
    await ApiService()
        .getData("places/show/${widget.id}")
        .then((value) => {response = value});
    setState(() {
      place = PlaceModel.fromJson(response["data"]);
      options = OptionModel.fromJsonList(response["data"]["place_options"]);
      type = response["data"]["type"]["type"];
    });
    print("options");
    print(response["data"]["place_options"]);
    setState(() {
      _loading = false;
    });
    print(response);
  }

  noter(note) async {
    var response;
    var path = "reviews/note";
    Map body = {"note": note, "place_id": place.id};
    await ApiService().postData(body, path).then((value) => {response = value});
    print(response);
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString(APIConstants.TOKEN);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getDetails();
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Loader(
            loadIng: _loading,
            color: Colors.black,
            opacity: .6,
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 50),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(Icons.arrow_back_ios),
                              ),
                            ),
                          )
                        ],
                      ),
                      height: h / 2,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                          color: Colors.red,
                          image: DecorationImage(
                              image: NetworkImage(
                                  "${APIConstants.IMG_BASE_URL}${place.image_place}"),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.house,
                                      color: primary,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(type)
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                  onTap: () {
                                    print(double.parse(
                                        place.localisation.split(",")[0]));
                                    MapsLauncher.launchCoordinates(
                                        double.parse(
                                            place.localisation.split(",")[0]),
                                        double.parse(
                                            place.localisation.split(",")[1]));
                                  },
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: primary,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: Text(place.name))
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text('Notez-ici'),
                                SizedBox(
                                  height: 10,
                                ),
                                IgnorePointer(
                                    ignoring: token == null,
                                    child: Row(
                                      children: [
                                        RatingBar.builder(
                                          initialRating: 0,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemSize:
                                              20, // largeur personnalisée pour chaque étoile

                                          itemCount: 5,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) async {
                                            await noter(rating);
                                            print(rating);
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return RatingDialog(
                                                  title: 'Note enregistrée',
                                                  message:
                                                      'Merci d\'avoir donné votre avis !',
                                                  onOkPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        place.description,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    Open.mail(
                                        toAddress: place.email,
                                        subject: "",
                                        body: "");
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.mail,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),

                                      /*  Container(
                            width: MediaQuery.of(context).size.width/3,
                            child: Text(place.email))*/
                                    ],
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Open.phone(
                                      phoneNumber: event.event_telephone);

                                  //   launchCall(event.event_telephone);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.call,
                                      color: Colors.green,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    //  Text(event.event_telephone)
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.visibility,
                                color: Colors.grey,
                                size: 18,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('${place.visit} vue')
                            ],
                          )
                        ],
                      ),
                    ),
                    Wrap(
                      spacing: 50.0, // Espace horizontal entre chaque élément
                      runSpacing:
                          10.0, // Espace vertical entre chaque ligne d'éléments
                      children: options.map((option) {
                        return GestureDetector(
                          onTap: () async {
                            // Do something
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Icon(
                                  option.icon == "resto"
                                      ? Icons.restaurant_menu
                                      : (option.icon == "wifi"
                                          ? Icons.wifi
                                          : (option.icon == "tv"
                                              ? Icons.tv
                                              : (option.icon == "space"
                                                  ? Icons.space_bar_outlined
                                                  : (option.icon == "piscine"
                                                      ? Icons.water
                                                      : Icons
                                                          .warehouse_outlined)))),
                                  color: primary,
                                  size: 15,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                option.name,
                                style: GoogleFonts.inter(
                                    color: primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 5),
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            )));
  }
}
