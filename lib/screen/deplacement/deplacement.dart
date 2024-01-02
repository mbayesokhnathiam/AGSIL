import 'package:ajiledakarv/models/Country.dart';
import 'package:ajiledakarv/models/Region.dart';
import 'package:ajiledakarv/models/Trasnport.dart';
import 'package:ajiledakarv/roviders/notifier.dart';
import 'package:ajiledakarv/services/apiService.dart';
import 'package:ajiledakarv/utils/const.dart';
import 'package:ajiledakarv/widgets/ItemModal.dart';
import 'package:ajiledakarv/widgets/loader.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Deplacement  extends StatefulWidget {

  final  CountryModel country;
  Deplacement ({super.key, required this.country});

  @override
  State<Deplacement > createState() => _DeplacementState();
}

class _DeplacementState extends State<Deplacement > {


  bool _loading=true;
  final _regionKey = GlobalKey<FormFieldState>();
  String? userName;


  List<RegionModel> regions=[];
  List<CountryModel> countries=[];
  List<TransportModel> transports=[];
  CountryModel? country;
  RegionModel? region;

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

  getTransport() async{
    setState(() {
      _loading=true;


    });
    var response;
    await  ApiService().getData("transport/region/${ region!.id}").then((value) =>{
      response=value
    });
    if(response["code"]==200){
      print(response);
      setState(() {
        transports=TransportModel.fromJsonList(response["data"]);

      });
    }
    setState(() {
      _loading=false;


    });
  }

  void getCountry(BuildContext context) async {
    CountryModel counterValue = Provider.of<DNotifier>(context, listen: false).country;
    print('Counter value: ${counterValue.nom_fr_fr}');

    if(counterValue!=country){
      _regionKey.currentState!.reset();

      setState(() {
        region=null;
        country=counterValue;
      });

      await getRegionsByCountries();
      if(region==null){
        regions.length>0?   _regionKey.currentState!.setValue(regions.first):null;
         setState(() {
           region=  regions.length>0? regions.first:null;
         });
          await  getTransport();
      }


    }

  }

  void _showItemModal(BuildContext context, String image, String description, String phoneNumber,String email) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ItemModal(image: image, description: description, phoneNumber: phoneNumber,mail: email,);
      },
    );
  }
  initData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

      userName=prefs.getString(APIConstants.CONNECTED_USER_NAME);

    });
  }


  @override
  void initState() {
    // TODO: implement initState
    initData();
 // getDatas();
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
  getCountry(context);
    return   Loader(
      loadIng: _loading,
      color: Colors.black,
      opacity: .6,
      child:Scaffold(
      body:

      Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child:Container(
          child:ListView(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            child: CircleAvatar(
                              backgroundImage:
                              AssetImage('assets/avatar.png'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(userName!=null?userName!:"",style: TextStyle(fontSize: 18),),
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
                            image: AssetImage('assets/images/logo-agil.png'),
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
                    child:
                    Container(
                       width: 170,
                       // ,
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
                                  Text(items.nom_region.trim()),
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
                          await  getTransport();

                          },
                        )


                    )),
                /*Container(
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
            /*Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: InputSearchCustum(
                Secondary,
                'recherche activité',
                'labetText',
              ),
            ),
            SizedBox(
              height: 20,
            ),*/
         transports.length ==0?Container(
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

    GridView.builder(
             physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.7,
                ),
                itemCount: transports.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      _showItemModal(context, transports[index].image, transports[index].description, transports[index].contact, transports[index].email);

                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailCoutry(activite: HomeController().activiteListe[index])));
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
                                color:                                      Color(0xff64625F),
                                gradient: LinearGradient(
                                  colors: [
                                     Color(0xff64625F),
                                    Color(0xff64625F)
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                )),
                            child: Center(
                              child: Text(
                               "${transports[index].name} / ${transports[index].contact}",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
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
                            offset: Offset(0, 2),
                          ),
                        ],
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image:  NetworkImage("${APIConstants.IMG_BASE_URL}${transports[index].image}"),
                            fit: BoxFit.cover),
                      ),
                    ),

                  );
                },
              ),




          ],

      ),
    ))));
  }
}
