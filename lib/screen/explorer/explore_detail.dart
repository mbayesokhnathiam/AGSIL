import 'package:ajiledakarv/common/color.dart';
import 'package:ajiledakarv/models/Categorie.dart';
import 'package:ajiledakarv/models/Option.dart';
import 'package:ajiledakarv/models/place_model.dart';
import 'package:ajiledakarv/services/apiService.dart';
import 'package:ajiledakarv/utils/const.dart';
import 'package:ajiledakarv/widgets/loader.dart';
import 'package:ajiledakarv/widgets/modalClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_share_pro/open.dart';
import '../../models/Event.dart';
import 'package:maps_launcher/maps_launcher.dart';

class ExploreDetail extends StatefulWidget {
  final EventModel event;

  ExploreDetail({super.key, required this.event});

  @override
  State<ExploreDetail> createState() => _ExploreDetailState();
}

class _ExploreDetailState extends State<ExploreDetail> {
  bool _loading = true;
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

  void launchCall(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Impossible de lancer l\'appel pour le numéro $phoneNumber';
    }
  }

  getDetails() async {
    setState(() {
      _loading = true;
    });
    var response;
    await ApiService()
        .getData("events/detail/${widget.event.id}")
        .then((value) => {response = value});

    setState(() {
      event = EventModel.fromJson(response["data"]);
      categorie = CategorieModel.fromJson(response["data"]["category"]);
      place = PlaceModel.fromJson(response["data"]["place"]);
      options =
          OptionModel.fromJsonList(response["data"]["place"]["place_options"]);
      _loading = false;
    });
    print(response["data"]["place"]);
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
    return Loader(
        loadIng: _loading,
        color: Colors.black,
        opacity: .6,
        child: Scaffold(
            body: Container(
                child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: MySliverAppBar(
                expandedHeight: h,
                img: event.event_image,
                id: event.id.toString(),
                title: event.event_title,
                location: event.event_address,
                place: place,
              ),
              pinned: true,
            ),
            SliverList(delegate: SliverChildListDelegate([
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
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
                                Icons.event,
                                color: primary,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width:
                                MediaQuery.of(context).size.width / 2,
                                child: Text(event.event_title),
                              )
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
                                      child: Text(event.event_address))
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
                                    itemSize: 20,
                                    // largeur personnalisée pour chaque étoile

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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SingleChildScrollView(
                  child: Text(
                    place.description,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              color: Colors.black87,
                              size: 25,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              place.email,
                              style: TextStyle(fontSize: 14),
                            )
                          ],
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        InkWell(
                          onTap: () {
                            Open.phone(phoneNumber: event.event_telephone);

                            //   launchCall(event.event_telephone);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.call,
                                color: Colors.black87,
                                size: 25,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                event.event_telephone,
                                style: TextStyle(fontSize: 14),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.visibility,
                          color: Colors.black87,
                          size: 25,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('${place.visit} vues',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14))
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Center(
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 8,
                      childAspectRatio: 0.5,
                    ),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
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
                                border: Border.all(
                                    color: Colors.grey.withOpacity(.4)),
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
                                size: 30,
                              ),
                            ),
                            SizedBox(height: 5),
                            Flexible(
                              child: Text(
                                option.name,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    color: primary,
                                    // fontWeight: FontWeight.w,
                                    fontSize: 10),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ]))
          ],
        ))));
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  String? img, id, title, location;
  PlaceModel? place;

  MySliverAppBar({
    required this.expandedHeight,
    this.img,
    this.id,
    this.title,
    this.location,
    this.place
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          width: double.infinity,
          color: Colors.white,
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.only(top: 5),
            child: Text(
              title!,
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Sofia",
                fontWeight: FontWeight.w700,
                fontSize: (expandedHeight / 40) - (shrinkOffset / 40) + 18,
              ),
            ),
          ),
        ),
        Opacity(
          opacity: (1 - shrinkOffset / expandedHeight),
          child: Hero(
            tag: 'hero-tag-$id',
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage("${APIConstants.IMG_BASE_URL}${img!}"),
                ),
                shape: BoxShape.rectangle,
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 130.0),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(0.0, 1.0),
                    stops: [0.0, 1.0],
                    colors: <Color>[
                      Color(0x00FFFFFF),
                      Color(0xFFFFFFFF),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                child: Text(
                  title!,
                  style: TextStyle(
                      color: Colors.black87.withOpacity(0.65),
                      fontSize: 30.5,
                      fontFamily: "Sofia",
                      fontWeight: FontWeight.w700),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    MapsLauncher.launchCoordinates(
                        double.parse(
                            place!.localisation.split(",")[0]),
                        double.parse(
                            place!.localisation.split(",")[1]));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.location_on,
                      size: 25.0,
                      color: Colors.black26,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Text(
                        location!,
                        style: const TextStyle(
                            color: Colors.black26,
                            fontSize: 14.5,
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w800),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                    child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 25),
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_back),
                        )))),
          ],
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
