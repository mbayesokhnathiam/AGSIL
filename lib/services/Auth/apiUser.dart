
import 'dart:convert';
import 'dart:io';
import 'package:ajiledakarv/utils/const.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/networkHelperWithHeader.dart';

class AuthService {
  Future register(body) async {

    try{
      var response ;
      //   SharedPreferences prefs=await SharedPreferences.getInstance();
      // var token=prefs.getString(APIConstants.TOKEN);

      await PostData('${APIConstants.API_BASE_URL}${APIConstants.REGISTER}', "",body).postData().then((value) =>{
        response=value,
      });
      return json.decode(response);
    }catch(e){
      return e;
    }


  }
  Future login(body) async {

    try{
      var response ;
      //   SharedPreferences prefs=await SharedPreferences.getInstance();
      // var token=prefs.getString(APIConstants.TOKEN);

      await PostData('${APIConstants.API_BASE_URL}${APIConstants.LOGIN}', "",body).postData().then((value) =>{
        response=value,
      });
      return json.decode(response);
    }catch(e){
      return e;
    }


  }
  Future postData(body) async {

    try{
      var response ;
      //   SharedPreferences prefs=await SharedPreferences.getInstance();
      // var token=prefs.getString(APIConstants.TOKEN);

      await PostData('${APIConstants.API_BASE_URL}${APIConstants.forgot}', "",body).postData().then((value) =>{
        response=value,
      });
      return json.decode(response);
    }catch(e){
      return e;
    }


  }


}