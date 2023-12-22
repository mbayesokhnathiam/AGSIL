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
import 'package:ajiledakarv/screen/explorer/explore_detail.dart';
import 'package:ajiledakarv/screen/results/show_detail.dart';
import 'package:ajiledakarv/services/apiService.dart';
import 'package:ajiledakarv/utils/HexaColor.dart';
import 'package:ajiledakarv/utils/const.dart';
import 'package:ajiledakarv/widgets/loader.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/place_model.dart';

class Resultat extends StatefulWidget {
    final int idType;
    final int idZone;
    final String zone;
  const Resultat({super.key, required this.idType, required this.idZone, required this.zone,  });

  @override
  State<Resultat> createState() => _DetailCityState();
}

class _DetailCityState extends State<Resultat> {
  final _regionKey = GlobalKey<FormFieldState>();
  List <PlaceModel> places =[];
  bool _loading=false;

  List filter = [
    'Recent',
    'Sourée live',
    'Cinéma',
    'Explore/theatre',
    'Plat et brunchs'
  ];
  List<CategorieModel> categories=[];
  List<RegionModel> regions=[];
  List<EventModel> events=[];
  List<StatusModel> status=[];
  RegionModel? region;
  CategorieModel? currenteCategorie;

  int current = 0;
 // List<RegionModel> regions=[];
  // String country_d_code="";

  initData() async{

setState(() {
  _loading=true;
});
    var response;
    List msg =[];
    await  ApiService().getData("places/search/${widget.idType}/${widget.idZone}").then((value) =>{
      response=value

    });
    setState(() {
      places=PlaceModel.fromJsonList(response["data"])

      ;
    });
setState(() {
  _loading=false;
});
    print(places);



  }


  getDetails(id) async{

    setState(() {
      _loading=true;
    });
    var response;
    List msg =[];
    await  ApiService().getData("places/show/${id}").then((value) =>{
      response=value

    });
    setState(() {


      ;
    });
    setState(() {
      _loading=false;
    });
    print(response);



  }

  @override
  void initState() {
    // TODO: implement initState
    initData();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {
            Navigator.of(context).pop();
          }, icon: Icon(Icons.arrow_back_ios , color: Colors.black,)),
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(widget.zone , style: TextStyle(
            color: Colors.black,
          ),),
        ),

      body:     Loader(
        loadIng: _loading,
        color: Colors.black,
        opacity: .6,
        child:  places.length>0?Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 5),
        child:  Column(
          children: [


            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.7,
                ),
                itemCount: places.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                   //   getDetails(places[index].id);
                       Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShowDetail( id: places[index].id,)));
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
                                  borderRadius: BorderRadiusDirectional.only(
                                      bottomEnd: Radius.circular(8),
                                      bottomStart: Radius.circular(8)),
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
                                    width:
                                        MediaQuery.of(context).size.width / 20,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/icond.png'),
                                    )),
                                  ),
                                  Flexible(child:
                                  Text(
                                    places[index].name,
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
                            offset: Offset(0, 2), // changes position of shadow
                            //first paramerter of offset is left-right
                            //second parameter is top to down
                          ),
                        ],
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image:   NetworkImage(
                              "${APIConstants.IMG_BASE_URL}${places[index].image_place}",
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


      ):Center(
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
        ),


    )


    );
  }
}









