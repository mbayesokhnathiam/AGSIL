import 'package:ajiledakarv/auth/login.dart';
import 'package:ajiledakarv/auth/register.dart';
import 'package:ajiledakarv/common/color.dart';
import 'package:ajiledakarv/models/Country.dart';
import 'package:ajiledakarv/screen/explorer/explore.dart';
import 'package:ajiledakarv/services/apiService.dart';
import 'package:ajiledakarv/services/urlLuncher.dart';
import 'package:ajiledakarv/utils/HexaColor.dart';
import 'package:ajiledakarv/widgets/loader.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ajiledakarv/utils/const.dart';

import '../bottom_navigation_bar.dart';



class Begin  extends StatefulWidget {
  const Begin  ({super.key});

  @override
  State<Begin > createState() => _beginState();
}

class _beginState extends State<Begin  > {

  List<CountryModel> countries=[];
  CountryModel? countrie;
  bool _loading=false;
  final _countryKey = GlobalKey<FormFieldState>();
  List slides = [];


  getDatas() async{
    setState(() {
      _loading=true;


    });

    var response;
    await  ApiService().getData("countrie/list").then((value) =>{
      response=value

    });
    setState(() {
      _loading=false;
      countries=CountryModel.fromJsonList(response["data"]);
      countrie=countries.where((c) => c.id==193).first;

    });
  }


  getStories() async {

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
  @override
  void initState() {
    getStories();
    // TODO: implement initState
    getDatas();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {


   
     var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return
      Loader(
      loadIng: _loading,
      color: Colors.black,
      opacity: .6,
      child:Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 50),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 20,right: 20),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: w * 0.14),
              
                child:
                    Image(image: AssetImage('assets/images/logo-agil.png')),
                ),
                if (slides.length > 0)
                SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (var pub in slides)
                              Row(
                                children: [
                                  GestureDetector(
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
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(

                                            image: NetworkImage(
                                               // "https://www.ideas-factory.net/wp-content/uploads/sites/34/2020/06/evenement-public-scaled.jpg"
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




                    //CardSlider_opp(cardItems: slides,),
                  ),
                SizedBox(height: 10,),
                Form(
                  child: Column(
                    children: [
                      DropdownButtonFormField(
                        key: _countryKey,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: HexColor("#F6F6F6"),
                          alignLabelWithHint: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 5, 10),
                          labelText: 'Pays',
                          hintText: 'Choisir un pays',
                        ),

                        //  value: dropdownvalue,
                        icon: const Icon(Icons.keyboard_arrow_down),
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
                            child:Row(
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

                           setState((){
                            // _loading=true;
                             countrie=newValue;
                           });
                        Future.delayed(const Duration(milliseconds: 100), () {
                             Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                     builder: (context) =>  bnv(country_d_code:newValue,)));

                           });


                          setState(() {
                       //     country=newValue;
                          });
                       //   await getRegionsByCountries();


                        },
                      ),


                      Container(
                        margin: EdgeInsets.fromLTRB(0, 45, 0, 8),
                        child: Text(
                          'Choisissez votre pays!',
                          style:GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      SizedBox(height: 12,),

                    GestureDetector(
                      onTap: (){
                        print("oklm");
                        if(countrie!=null)
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));

                      },
                      child: Container(
                       width: w * 0.7,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.orangeAccent,
                        ),
                        child: Center(
                          child: Text(
                            'Inscription',
                            style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "j'ai deja un compte :",
                              style:GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w300
                              ),
                            ),
                            TextButton(
                              onPressed:  () =>   (){
                             // if(countrie!=null)
                                if(countrie!=null)
                               Navigator.push(
                          context,
                           MaterialPageRoute(
                              builder: (context) => Login(country: countrie!,)));
                                  
                              },
                              child: Text('me connecter !',
                                  style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primary
                              ),),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
