import 'package:ajiledakarv/models/Country.dart';
import 'package:flutter/material.dart';

class DNotifier extends ChangeNotifier {
  CountryModel _country =  CountryModel (
     id:0,
     code:0,
     alpha2:"",
      alpha3:"",
    nom_fr_fr:"",
    nom_en_gb:"",
    icon:"",
    is_active:0

  );

  CountryModel get country => _country;
  void setCountry(CountryModel c) {
    _country=c;
    notifyListeners();
  }
}