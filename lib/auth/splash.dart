import 'package:ajiledakarv/auth/begin.dart';
import 'package:ajiledakarv/auth/login.dart';
import 'package:ajiledakarv/common/color.dart';
import 'package:ajiledakarv/models/Country.dart';
import 'package:ajiledakarv/screen/explorer/explore.dart';
import 'package:ajiledakarv/services/apiService.dart';
import 'package:ajiledakarv/utils/HexaColor.dart';
import 'package:ajiledakarv/widgets/loader.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ajiledakarv/utils/const.dart';

import '../bottom_navigation_bar.dart';



class Splash  extends StatefulWidget {
  const Splash    ({super.key});

  @override
  State<Splash   > createState() => _beginState();
}

class _beginState extends State<Splash    > {

  List<CountryModel> countries=[];
  CountryModel? countrie;
  bool _loading=false;
  final _countryKey = GlobalKey<FormFieldState>();


  getDatas() async{
    Future.delayed(Duration(milliseconds: 3000), () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Begin()));

      //  Navigator.of(context).pop();
    });
  }


  @override
  void initState() {
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
      body:   Container(
        alignment: Alignment.center,

        child:
        Image(image: AssetImage('assets/images/logo-agil.png')),
      ),
    ));
  }
}
