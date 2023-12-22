//import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class Cookies {
  static SharedPreferences? prefs;

  void newInstance() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  void myUsercookies(String user, String id) {
    prefs!.setString("user", user);
    prefs!.setString("id", id);

    print("in myusercookies");
    print(prefs!.getString("id"));
  }

  void tuto(String tuto) {
    prefs!.setString("tuto", tuto);
  }

  Future<String> getMyUserName() async {
    print("in getusername");
    return prefs!.getString("user")!;
  }

  Future<String> getMyUserId() async {
    print("in getusername id id");
    return prefs!.getString("id")!;
  }

  Future<String> getTuto() async {
    return prefs!.getString("tuto")!;
  }

  void removeCookie() {
    prefs!.clear();
  }

  // for keeping data locally

  void setdataSoireeLives(String data) {
    prefs!.setString('Lives', data);
  }

  void setdataExpo(String data) {
    prefs!.setString('Expos', data);
  }

  void setdataCinema(String data) {
    prefs!.setString('Cinema', data);
  }

  void setdataMenu(String data) {
    prefs!.setString('Menu', data);
  }

  void setdataPlaces(String data) {
    prefs!.setString('Places', data);
  }

  void setdataNumeros(String data) {
    prefs!.setString('Numeros', data);
  }

  void setdataTransport(String data) {
    prefs!.setString('Transport', data);
  }

  void setdataEndroits(String data, String dataType) {
    /* switch (dataType) {
      case 'Hebergement':
        prefs.setString('Hebergement', data);
        break;
      case 'Restauration':
        prefs.setString('Restauration', data);
        break;
      case 'Distraction':
        prefs.setString('Distraction', data);
        break;
      case 'Decouverte':
        prefs.setString('Decouverte', data);
        break;
      case 'Culture':
        prefs.setString('Culture', data);
        break;
      case 'Service':
        prefs.setString('Service', data);
        break;
      case 'Biennale':
        prefs.setString('Biennale', data);
        break;
      default:
    } */
    prefs!.setString('$dataType', data);
  }

  //read local data
  Future<String> getdataSoireeLives() async {
    return prefs!.getString('Lives')!;
  }

  Future<String> getdataExpo() async {
    return prefs!.getString('Expos')!;
  }

  Future<String> getdataCinema() async {
    return prefs!.getString('Cinema')!;
  }

  Future<String> getdataMenu() async {
    return prefs!.getString('Menu')!;
  }

  Future<String> getdataPlaces() async {
    return prefs!.getString('Places')!;
  }

  Future<String> getdataNumeros() async {
    return prefs!.getString('Numeros')!;
  }

  Future<String> getdataTransport() async {
    return prefs!.getString('Transport')!;
  }

  Future<String> getdataEndroits(String dataType) async {
    //print("data stockes");
    if (dataType == 'Hebergement') {
      return prefs!.getString('Hebergement')!;
    } else if (dataType == 'Restauration') {
      return prefs!.getString('Restauration')!;
    } else if (dataType == 'Distraction') {
      return prefs!.getString('Distraction')!;
    } else if (dataType == 'Decouverte') {
      return prefs!.getString('Decouverte')!;
    } else if (dataType == 'Culture') {
      return prefs!.getString('Culture')!;
    } else if (dataType == 'Service') {
      return prefs!.getString('Service')!;
    } else {
      return prefs!.getString('Biennale')!;
    }
  }

  //delete data for refresh
  void deleteLocalData() {
    prefs!.remove('Cinema');
    prefs!.remove('Menu');
    prefs!.remove('Places');
    prefs!.remove('Numeros');
    prefs!.remove('Transport');
    prefs!.remove('Hebergement');
    prefs!.remove('Restauration');
    prefs!.remove('Distraction');
    prefs!.remove('Decouverte');
    prefs!.remove('Culture');
    prefs!.remove('Service');
    prefs!.remove('Biennale');
  }
}
