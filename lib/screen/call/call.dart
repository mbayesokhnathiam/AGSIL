import 'package:ajiledakarv/models/Adress.dart';
import 'package:ajiledakarv/models/Country.dart';
import 'package:ajiledakarv/models/Region.dart';
import 'package:ajiledakarv/roviders/notifier.dart';
import 'package:ajiledakarv/services/apiService.dart';
import 'package:ajiledakarv/utils/const.dart';
import 'package:ajiledakarv/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_share_pro/open.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NumeroUtil extends StatefulWidget {
  final  CountryModel country;
  NumeroUtil({super.key, required this.country});

  @override
  State<NumeroUtil> createState() => _NumeroUtilState();
}

class _NumeroUtilState extends State<NumeroUtil> {
  //final ConnectivityService connectivityService = ConnectivityService();


  bool _loading=false;
  final _regionKey = GlobalKey<FormFieldState>();
  String? userName;


  List<RegionModel> regions=[];
  List<CountryModel> countries=[];
 List<AdressModel> adress=[];
  CountryModel? country;
  RegionModel? region;
  void launchCall(String phoneNumber) async {
    Open.phone(phoneNumber: phoneNumber);
   /* String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Impossible de lancer l\'appel pour le numéro $phoneNumber';
    }*/
  }
  getRegionsByCountries() async{
    setState(() {
      _loading=true;


    });
    var response;
    await  ApiService().getData("localite/region/${ country!.id}").then((value) =>{
      response=value
    });
    if(response["code"]==200){
      print(response);
      setState(() {
        regions=RegionModel.fromJsonList(response["data"]);

      });
    }
    setState(() {
   //   _loading=false;
    });
  }

  getAdress() async{
    setState(() {
      _loading=true;


    });
    var response;
    await  ApiService().getData("adresse/region/${ region!.id}").then((value) =>{
      response=value
    });
    if(response["code"]==200){
      setState(() {
      adress=AdressModel.fromJsonList(response["data"]);
      });
    }
    setState(() {
      _loading=false;


    });
  }

  void getCountry(BuildContext context) async {
    CountryModel counterValue = Provider.of<DNotifier>(context, listen: true).country;
    print('Counter value____: ${counterValue.nom_fr_fr}');

if(!_loading){
    if(counterValue!=country){
      _regionKey.currentState!.reset();

      setState(() {
        region=null;
        country=counterValue;
      });

      await getRegionsByCountries();
      if(region==null){
        _regionKey.currentState!.setValue(regions.first);
        setState(() {
          region=regions.first;
        });
        await  getAdress();
      }


    }
}



  }
  initData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName=prefs.getString(APIConstants.CONNECTED_USER_NAME);
    });
  }

  @override
  void initState() {
    initData();
    // getDatas();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    getCountry(context);
    var w = MediaQuery.of(context).size.width;
    return    Loader(
        loadIng: _loading,
        color: Colors.black,
        opacity: .6,
        child: Scaffold(
     
      body: Container(
          padding:  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        /*Container(
            child: IconButton(
              onPressed: () {

              },
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),*/
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/avatar.png'),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(userName ?? '', style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                      width: 100,
                      child: Image.asset(
                        'assets/images/logo-agil.png',
                        fit: BoxFit.cover,
                      ),
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
                      child:
                      Container(
                          width: 170
                          ,
                          decoration: BoxDecoration(
                            // color:   Colors.grey.shade600,
                            /*  border: Border.all(
                                color: Colors.grey,
                                width: 0.0,
                     ),*/
                            borderRadius: BorderRadius.circular(5.0),
                          ),

                          child :DropdownButtonFormField(
                            style: TextStyle(
                              color: Colors.white, // couleur souhaitée
                              // autres styles de texte ici
                            ),
                            dropdownColor: Colors.black, // couleur de fond souhaitée
                            key: _regionKey,
                            decoration: InputDecoration(


                              //  border: InputBorder.none,
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              filled: true,
                              fillColor: Colors.black,


                              alignLabelWithHint: true,
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              contentPadding: EdgeInsets.fromLTRB(10, 0, 5, 10),
                              labelText: 'Region',
                              hintText: 'Choisir une region',
                            ),

                            //  value: dropdownvalue,
                            icon: const Icon(Icons.keyboard_arrow_down,color: Colors.white,),
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
                                    const Icon(Icons.location_on,color: Colors.white,),
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
                                region=newValue;
                              });
                              await  getAdress();

                            },
                          )


                      )),

                 /* Container(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.notifications,
                            color: Colors.orangeAccent,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.menu,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                  )*/
                ],
              ),
             
              SizedBox(
                height: 10,
              ),

            /*  Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child:                                                     InputSearchCustum(Secondary, 'recherche activité', 'labetText' ,  ),

              
              ),
                SizedBox(
                height: 20,
              ),*/
adress.length==0?Container(
  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/4),
  alignment: Alignment.center,
    child:Center(
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
    )):


Container(
               child: SingleChildScrollView(
                 child: Column(
                  children: adress.map((e) => Container(
                    padding: EdgeInsets.only(right: 10),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Color(0xff64625F),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child:   Stack(
                        children: [ SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      
                      Container(
                        width: w /3,
                        height: double.infinity,
                        decoration:  BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft : Radius.circular(20),
                          )
                        ),
                        child: Container(
                          width: w/3,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                           
                            ),
                            image: DecorationImage(image:
                            NetworkImage("${APIConstants.IMG_BASE_URL}${e.photo}"),

                            fit: BoxFit.cover
                            )
                          ),
                        )
                      ),
                      SizedBox(width: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e.name ,  style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,)),
                          SizedBox(
                            height: 10,
                          ),
                          Text(e.phone.toString() , style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12,

                            fontWeight: FontWeight.bold,
                          ),)
                        ],
                      ),



                    ])),
                          Positioned(
                            top: 5,
                              bottom: 0,
                              right: 1,

                              child:  InkWell(
                            onTap: (){
                              launchCall(e.phone);
                            },
                            child:  Icon(Icons.call , size:28, color: Colors.green,),
                          ))
                        ]
                  ),
                  ),).toList(),
                 ),
               ),
             ) 
             
            ],
          )),
        ));

}}