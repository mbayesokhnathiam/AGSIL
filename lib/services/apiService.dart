
import 'dart:convert';
import 'dart:io';

import 'package:ajiledakarv/helpers/networkHelperWithHeader.dart';
import 'package:ajiledakarv/utils/const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';



import 'package:shared_preferences/shared_preferences.dart';

class ApiService {


  Future getdata(path,token) async {
    print('${APIConstants.API_BASE_URL}${path}');

    var value1 ;


    try{
      Map<String, String> newHeader = {
        // 'Authorization':'Bearer $freshToken'
      };
      await GetData('${APIConstants.API_BASE_URL}${path}', token,).getData1().then((value) =>{
        print(value),
        value1=value

      });


      return  value1;


    }catch(e){
      print(e);

      return "error";
    }
  }

  Future getData(path) async {
    print('${APIConstants.API_BASE_URL}${path}');

    var value1 ;


    try{
      Map<String, String> newHeader = {
        // 'Authorization':'Bearer $freshToken'
      };
      await GetData('${APIConstants.API_BASE_URL}${path}', "",).getData1().then((value) =>{
        print(value),
        value1=value

      });


      return  value1;


    }catch(e){
      print(e);

      return "error";
    }
  }
  Future getData1(path) async {
    print('${APIConstants.API_BASE_URL}${path}');

    var value1 ;
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.getString(APIConstants.TOKEN);

    try{
      Map<String, String> newHeader = {
        // 'Authorization':'Bearer $freshToken'
      };
      await GetData('${APIConstants.API_BASE_URL}${path}', token!,).getData1().then((value) =>{
        print(value),
        value1=value

      });


      return  value1;


    }catch(e){
      print(e);

      return "error";
    }
  }

  Future postData(body,path) async {
    var value1 ;
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.getString(APIConstants.TOKEN);
    await PostData('${APIConstants.API_BASE_URL}${path}', token!,body).postData().then((value) =>{
      value1=value,
      print(value1)
    });
    return json.decode(value1);

  }



}