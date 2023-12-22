import 'package:ajiledakarv/common/color.dart';
import 'package:ajiledakarv/common/input.dart';
import 'package:ajiledakarv/models/Categorie.dart';
import 'package:ajiledakarv/models/Country.dart';
import 'package:ajiledakarv/models/Event.dart';
import 'package:ajiledakarv/models/Region.dart';
import 'package:ajiledakarv/models/Status.dart';
import 'package:ajiledakarv/models/activite_model.dart';
import 'package:ajiledakarv/models/evenement_modelL.dart';
import 'package:ajiledakarv/screen/Status/StatusBar.dart';
import 'package:ajiledakarv/screen/chat/chat.dart';
import 'package:ajiledakarv/screen/explorer/explore_detail.dart';
import 'package:ajiledakarv/services/apiService.dart';
import 'package:ajiledakarv/services/urlLuncher.dart';
import 'package:ajiledakarv/utils/HexaColor.dart';
import 'package:ajiledakarv/utils/const.dart';
import 'package:ajiledakarv/widgets/loader.dart';
import 'package:ajiledakarv/widgets/slider/cardSlider_opp.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailCity extends StatefulWidget {
  final RegionModel? region;
  final CountryModel country;

  const DetailCity({super.key, this.region, required this.country});

  @override
  State<DetailCity> createState() => _DetailCityState();
}

class _DetailCityState extends State<DetailCity> {
  final _regionKey = GlobalKey<FormFieldState>();
  bool _loading = true;
  DateTime? date;

  List filter = [
    'Recent',
    'Sourée live',
    'Cinéma',
    'Explore/theatre',
    'Plat et brunchs'
  ];
  List<CategorieModel> categories = [];
  List<RegionModel> regions = [];
  List<EventModel> events = [];
  List<StatusModel> status = [];
  List slides = [];
  RegionModel? region;
  CategorieModel? currenteCategorie;

  int current = 0;
  // List<RegionModel> regions=[];
  // String country_d_code="";
  String? userName;

  initData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      region = widget.region;
      userName = prefs.getString(APIConstants.CONNECTED_USER_NAME);
    });
    var regionResponse;
    var catResponse;
    prefs.getString(APIConstants.COUNTRY_CODE);
    var response;
    await ApiService()
        .getData("localite/region/${widget.country.id}")
        .then((value) => {response = value});
    if (response["code"] == 200) {
      print(response);
      setState(() {
        regions = RegionModel.fromJsonList(response["data"]);
      });
    }

    await ApiService()
        .getData("category/list")
        .then((value) => {catResponse = value});
    setState(() {
      categories = CategorieModel.fromJsonList(catResponse["data"]);
    });
    if (regions.length != 0)
      _regionKey.currentState!
          .setValue(regions.where((e) => e.id == widget.region!.id).first);
    await getStories();
    /////inti datas///
    await getEvents();

  }

  getEvents() async {
    setState(() {
      _loading = true;
    });
    var response;
    await ApiService()
        .getData(
            "events/search/inregion/${region!.id}/${categories[current].id}?date=${formatDate(date!, 'yyyy-MM-dd')}")
        .then((value) => {response = value});
    print(response);
    print("events/search/inregion/${region!.id}/${categories[current].id}");
    print(categories[current].libelle_category);
    setState(() {
      events = EventModel.fromJsonList(response["data"]);
      _loading = false;
    });
  }

  getStories() async {
    print("koko story/list/${widget.region!.id}");
    print("story/list/${region!.id}");
    var response;
  //  story/list/${region!.id}
    await ApiService()
        .getData("pubs")
        .then((value) => {response = value});

    print("slides");

    print(response);
    setState(() {

  slides=response["data"];
      //status = StatusModel.fromJsonList(response["data"]);
    });
  }

  String formatDate(DateTime date, String format) {
    // HH:mm
    DateFormat formatter = DateFormat(format);
    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      date = DateTime.now();
    });
    initData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.green.withOpacity(.7),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                margin: EdgeInsets.only(bottom: 40),
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Besoin d’aide ?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      "Chattez avec Mory",
                      style: TextStyle(
                          fontWeight: FontWeight.w300, color: Colors.white),
                    ),
                  ],
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatPage(
                                  region: region!,
                                )),
                      );
                    },
                    child: Image(
                      image: AssetImage('assets/images/chat_icon.png'),
                    )),
                Text(
                  "Mory",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
        body: Loader(
          loadIng: _loading,
          color: Colors.black,
          opacity: .6,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 5),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(Icons.arrow_back_ios)),
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/avatar.png'),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  userName != null ? userName! : "",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/logo-agil.png'),
                                fit: BoxFit.cover)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Form(
                        //   key: _formKey,
                        //  autovalidateMode: _autoValidate,
                        child: Container(
                            width: 170,
                            //  ,
                            decoration: BoxDecoration(
                              // color:   Colors.grey.shade600,
                              /*  border: Border.all(
                       color: Colors.grey,
                       width: 0.0,
                     ),*/
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: DropdownButtonFormField(
                              style: TextStyle(
                                color: Colors.white, // couleur souhaitée
                                // autres styles de texte ici
                              ),
                              dropdownColor:
                                  Colors.black, // couleur de fond souhaitée
                              key: _regionKey,
                              decoration: InputDecoration(
                                //  border: InputBorder.none,
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                filled: true,
                                fillColor: Colors.black,

                                alignLabelWithHint: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 0, 5, 10),
                                labelText: 'Region',
                                hintText: 'Choisir une region',
                              ),

                              //  value: dropdownvalue,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                              /*  validator: FormBuilderValidators.compose([
                                                                  FormBuilderValidators.required(
                                                                      errorText: "la région est  obligatoire!!!"),
                                                                  /*  FormBuilderValidators.minLength(3,
                                                           errorText:
                                                      'Le prenom doit contenir minimum 3 carateres !!!'),*/
                                                             ]),*/
                              items: regions.map((RegionModel items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                      ),
                                      /*   Image.network(
                              "${APIConstants.IMG_BASE_URL}${items.image}",
                              width: 24,
                              height: 24,
                            ),*/
                                      SizedBox(width: 8),
                                      Text(items.nom_region),
                                    ],
                                  ),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (RegionModel? newValue) async {
                                setState(() {
                                  region = newValue;
                                });
                                await getEvents();
                              },
                            ))),
                    InkWell(
                        onTap: () async {
                          DateTime? date1 = await showDatePickerDialog(
                            context: context,
                            currentDateColor: Colors.orangeAccent,

                            initialDate: DateTime.now(),
                            minDate: DateTime(2000, 1, 1),
                            maxDate: DateTime(3023, 12, 31),
                            // todayTextStyle: const TextStyle(),
                            daysNameTextStyle: TextStyle(),

                            slidersColor: Colors.orangeAccent,
                            highlightColor: Colors.orangeAccent,
                            splashColor: Colors.orangeAccent,
                            selectedCellColor: Colors.orangeAccent,

                            /* enabledDaysTextStyle: const TextStyle(),
                                selectedDayTextStyle: const TextStyle(),
                                disbaledDaysTextStyle: const TextStyle(),
                                todayDecoration: const BoxDecoration(),
                                enabledDaysDecoration: const BoxDecoration(),
                                selectedDayDecoration: const BoxDecoration(),
                                disbaledDaysDecoration: const BoxDecoration(),*/
                          );
                          print(date);
                          if (date1 != null) {
                            setState(() {
                              date = date1;
                              _loading = true;
                            });
                            await getEvents();
                          }
                        },
                        child: Container(
                          child: Row(
                            children: [
                              date != null
                                  ? Text(formatDate(date!, 'dd/MM/yyyy'))
                                  : Container(),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.date_range,
                                color: Colors.orangeAccent,
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                if (slides.length > 0)
                  Container(
                    alignment: Alignment.centerLeft,
                      height: 100,
                    width:  MediaQuery.of(context).size.width,
                    child:  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (var pub in slides)
                        Row(
                          children: [
                            InkWell(
                                onTap: (){
                                  UrlLauncher().launchUniversalLinkIos(Uri.parse(pub["link"]));

                                },
                                child:

                                Container(
                                  width:  300,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.0),  // BorderRadius pour la partie supérieure droite
                                      topLeft: Radius.circular(10.0),  // BorderRadius pour la partie inférieure droite
                                      bottomRight: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0),
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                         /// "https://www.ideas-factory.net/wp-content/uploads/sites/34/2020/06/evenement-public-scaled.jpg"
                                         "${APIConstants.IMG_BASE_URL}/${pub["image"]}"

                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),



                                )),
                            SizedBox(width: 5,),
                          ],
                        )
                        ],
                      ),
                    )



                    //CardSlider_opp(cardItems: slides,),
                  ),

                 // StatusBar(statuses: status, regionId: region!.id.toString()),

                /* SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: InputSearchCustum(
                Secondary,
                'recherche activité',
                'labetText',
              ),
            ),*/
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 30,
                  width: double.infinity,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: categories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        return GestureDetector(
                          onTap: () async {
                            setState(() {
                              current = index;
                            });
                            await getEvents();
                          },
                          child: AnimatedContainer(
                            duration: const Duration(microseconds: 300),
                            child: Center(
                                child: Text(
                              categories[index].libelle_category,
                              style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: current == index
                                      ? Colors.white
                                      : Colors.black),
                            )),
                            margin: EdgeInsets.only(left: 5),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: current == index ? primary : Secondary,
                            ),
                          ),
                        );
                      }),
                ),
                events.length == 0
                    ? Expanded(
                        child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.hourglass_empty,
                              size: 50.0,
                              color: Colors.black,
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'Pas de resultats',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ))
                    : Expanded(
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 20,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: events.length,
                          itemBuilder: (_, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ExploreDetail(
                                              event: events[index],
                                            )));
                              },
                              child: Container(
                                margin: EdgeInsets.all(3),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(8),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadiusDirectional.only(
                                                    bottomEnd:
                                                        Radius.circular(8),
                                                    bottomStart:
                                                        Radius.circular(8)),
                                            color: Colors.white,
                                            gradient: LinearGradient(
                                              colors: [
                                                const Color(0xffffffff),
                                                Color(0xffffffff)
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            )),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 30,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/icond.png'),
                                              )),
                                            ),
                                            Flexible(
                                                child: Text(
                                              events[index].event_title,
                                              style: GoogleFonts.inter(
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: 12,
                                              color: Colors.black,
                                            )
                                          ],
                                        ))
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 186, 184, 184)
                                          .withOpacity(0.5), //color of shadow
                                      spreadRadius: 3, //spread radius
                                      blurRadius: 4, // blur radius
                                      offset: Offset(
                                          0, 2), // changes position of shadow
                                      //first paramerter of offset is left-right
                                      //second parameter is top to down
                                    ),
                                  ],
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        "${APIConstants.IMG_BASE_URL}${events[index].event_image}",
                                      ),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        ));
  }
}
