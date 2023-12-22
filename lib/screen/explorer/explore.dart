import 'package:ajiledakarv/auth/begin.dart';
import 'package:ajiledakarv/auth/login.dart';
import 'package:ajiledakarv/common/color.dart';
import 'package:ajiledakarv/common/input.dart';
import 'package:ajiledakarv/models/Country.dart';
import 'package:ajiledakarv/models/Region.dart';
import 'package:ajiledakarv/models/activite_model.dart';
import 'package:ajiledakarv/roviders/notifier.dart';
import 'package:ajiledakarv/screen/chat/chat.dart';
import 'package:ajiledakarv/screen/chat/chatBoot.dart';
import 'package:ajiledakarv/screen/explorer/detail_city_explore.dart';
import 'package:ajiledakarv/services/apiService.dart';
import 'package:ajiledakarv/services/connectivityService.dart';
import 'package:ajiledakarv/utils/HexaColor.dart';
import 'package:ajiledakarv/utils/const.dart';
import 'package:ajiledakarv/widgets/loader.dart';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExplorePage extends StatefulWidget {
  final CountryModel country;
  ExplorePage({super.key, required this.country});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final _countryKey = GlobalKey<FormFieldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? userName;
  DateTime? date;
  bool _loading = false;

  List<RegionModel> regions = [];
  List<CountryModel> countries = [];
  CountryModel? country;
  RegionModel? region;
  // String country_d_code="";

  initData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      country = widget.country;
      userName = prefs.getString(APIConstants.CONNECTED_USER_NAME);
    });

    await getRegionsByCountries();
    await getDatas();
//print(country_d_code);
  }

  initNotifier(DNotifier not) async {
    not.setCountry(country!);
//print(country_d_code);
  }

  getDatas() async {
    var response;
    await ApiService()
        .getData("countrie/list")
        .then((value) => {response = value});
    setState(() {
      countries = CountryModel.fromJsonList(response["data"]);
    });
    _countryKey.currentState!
        .setValue(countries.where((e) => e.id == country!.id).first);
  }

  getRegionsByCountries() async {
    setState(() {
      _loading = true;
    });
    var response;
    await ApiService()
        .getData("localite/region/${country!.id}")
        .then((value) => {response = value});
    if (response["code"] == 200) {
      print(response);
      setState(() {
        regions = RegionModel.fromJsonList(response["data"]);
      });
    }
    setState(() {
      _loading = false;
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
    setState(() {
      country = widget.country;
      date = DateTime.now();
    });
    // TODO: implement initState
    initData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    final DNotifier dNotifier = Provider.of<DNotifier>(context);
    initNotifier(dNotifier);

    return Scaffold(
        key: _scaffoldKey,

        /*   FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatPage()),
          );
        },
        backgroundColor: primary,
        child: Image(
          image: AssetImage('assets/images/chat_icon.png'),
        ),
      ),*/
        drawer: Drawer(
          child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.close,
                            size: 40,
                            color: Color(0xff7B7B7B),
                          )),
                      Divider(),
                      /*  TextButton(onPressed: () {}, child: Text('Mon Profil' , style: GoogleFonts.inter(color: Color(0xff7B7B7B) , fontSize: 20 ) ,)),
                  Divider(),
                  TextButton(onPressed: () {}, child: Text('Notifications' , style: GoogleFonts.inter(color: Color(0xff7B7B7B) , fontSize: 20 ) ,)),
                  Divider(),
                  TextButton(onPressed: () {}, child: Text('Paramètres' , style: GoogleFonts.inter(color: Color(0xff7B7B7B) , fontSize: 20 ) ,)),
                  Divider(),
                  TextButton(onPressed: () {}, child: Text('Besoin d’aide ?' , style: GoogleFonts.inter(color: Color(0xff7B7B7B) , fontSize: 20 ) ,)),*/
                      //    Divider(),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Conditions d’ut.',
                            style: GoogleFonts.inter(
                                color: Color(0xff7B7B7B), fontSize: 20),
                          )),
                      Divider(),
                    ],
                  ),
                  userName != null
                      ? TextButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.clear();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Begin()));
                          },
                          child: Row(
                            children: [
                              Text(
                                'Déconnexion',
                                style: GoogleFonts.inter(
                                    color: Color(0xff7B7B7B),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.output_rounded,
                                color: Colors.black,
                              )
                            ],
                          ))
                      : SizedBox(),
                ],
              )),
        ),
        body: Loader(
          loadIng: _loading,
          color: Colors.black,
          opacity: .6,
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  height: w * 0.16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Form(
                          //   key: _formKey,
                          //  autovalidateMode: _autoValidate,
                          child: Container(
                              width: 160,
                              //padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: DropdownButtonFormField(
                                style: TextStyle(
                                  color: Colors.white, // couleur souhaitée
                                  // autres styles de texte ici
                                ),
                                dropdownColor:
                                    Colors.black, // couleur de fond souhaitée
                                key: _countryKey,
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
                                  labelText: 'Pays',
                                  hintText: 'Choisir un pays',
                                ),

                                //  value: dropdownvalue,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                /*  validator: FormBuilderValidators.compose([
                                                                  FormBuilderValidators.required(
                                                                      errorText: "la région est  obligatoire!!!"),
                                                                  /*  FormBuilderValidators.minLength(3,
                                                           errorText:
                                                      'Le prenom doit contenir minimum 3 carateres !!!'),*/
                                                             ]),*/
                                items: countries.map((CountryModel items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Row(
                                      children: [
                                        Image.network(
                                          "${APIConstants.IMG_BASE_URL}${items.icon}",
                                          width: 24,
                                          height: 24,
                                        ),
                                        SizedBox(width: 8),
                                        Text(items.nom_fr_fr),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (CountryModel? newValue) async {
                                  setState(() {
                                    country = newValue;
                                  });
                                  dNotifier.setCountry(newValue!);
                                  await getRegionsByCountries();
                                },
                              ))),
                      Container(
                        child: Row(
                          children: [
                            Container(
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
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Choisissez votre localité',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      /*  SizedBox(
                    height: 25,
                  ),
                  Container(
                    child: InputSearchCustum(
                      Secondary,
                      'recherche activité',
                      'labetText',
                    ),
                  ),*/
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: regions.length,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailCity(
                                        region: regions[index],
                                        country: country!,
                                      )));
                        },
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadiusDirectional.only(
                                        bottomEnd: Radius.circular(8),
                                        bottomStart: Radius.circular(8)),
                                    color: Colors.white,
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xffffffff),
                                        Color(0xffffffff)
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    )),
                                child: Center(
                                  child: Text(
                                    regions[index].nom_region,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  ),
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 186, 184, 184)
                                    .withOpacity(0.5), //color of shadow
                                spreadRadius: 3, //spread radius
                                blurRadius: 4, // blur radius
                                offset:
                                    Offset(0, 2), // changes position of shadow
                                //first paramerter of offset is left-right
                                //second parameter is top to down
                              ),
                            ],
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(
                                  "${APIConstants.IMG_BASE_URL}${regions[index].image}",
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
