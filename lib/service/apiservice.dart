import 'dart:convert';
import 'package:ajiledakarv/models/NoteAvis.dart';
import 'package:ajiledakarv/models/Pub.dart';
import 'package:ajiledakarv/models/User.dart';
import 'package:ajiledakarv/models/SoireeParJour.dart';
import 'package:ajiledakarv/utils/const.dart';
import 'package:dio/dio.dart';
import '../models/Annonce.dart';
import '../models/Endroit.dart';
import '../models/Horaire.dart';
import '../models/Numero.dart';
import '../models/Place.dart';
import '../models/Soiree.dart';
import '../models/Tarif.dart';
import '../models/Transport.dart';

class ApiService {
  ApiService._instantiate();
  ApiService();
  static final ApiService instance = ApiService._instantiate();
  // ignore: non_constant_identifier_names
  final base_url = "https://morysd.com/api/services.php?";
  var dio = Dio();

  Future<List<Endroit>> fetchEndroitBycat(categorie) async {
    try {
      final response = await dio
          .get(base_url + 'service=alltypesbyCat&categorie=' + categorie);

      var convertDataJson = jsonDecode(response.data) as List;

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        // ignore: non_constant_identifier_names
        List<Endroit> typeEndroit = convertDataJson
            // ignore: non_constant_identifier_names
            .map((EndroitJson) => Endroit.fromJson(EndroitJson))
            .toList();

        return typeEndroit;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    } catch (e) {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Endroit>> fetchEndroitByCatAndRub(categorie, rubrique) async {
    try {
      final response = await dio.get(base_url +
          'service=alltypesbyCatAndRub&categorie=$categorie&rubrique=$rubrique');

      var convertDataJson = jsonDecode(response.data) as List;

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        // ignore: non_constant_identifier_names
        List<Endroit> typeEndroit = convertDataJson
            // ignore: non_constant_identifier_names
            .map((EndroitJson) => Endroit.fromJson(EndroitJson))
            .toList();

        return typeEndroit;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    } catch (e) {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Place>> fetchPlaces(typeId) async {
    final response =
        await dio.get(base_url + 'service=getplaces&typeId=' + typeId);

    var convertDataJson = jsonDecode(response.data) as List;

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // ignore: non_constant_identifier_names
      List<Place> listeEndroit = convertDataJson
          // ignore: non_constant_identifier_names
          .map((PlaceJson) => Place.fromJson(PlaceJson))
          .toList();

      return listeEndroit;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<List<Place>> initPlace(rubrique, categorie) async {
    final response = await dio.get(base_url +
        'service=initialEndroit&rubrique="$rubrique"&categorie="$categorie"');

    var convertDataJson = jsonDecode(response.data) as List;

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // ignore: non_constant_identifier_names
      List<Place> listeEndroit = convertDataJson
          // ignore: non_constant_identifier_names
          .map((PlaceJson) => Place.fromJson(PlaceJson))
          .toList();

      return listeEndroit;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  //pour la pagination
  Future<List<Place>> initPlaceScroll(rubrique, categorie, page, limit) async {
    final response = await dio.get(base_url +
        'service=initialEndroitScroll&rubrique="$rubrique"&categorie="$categorie"&page=$page&limit=$limit');

    var convertDataJson = jsonDecode(response.data) as List;

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // ignore: non_constant_identifier_names
      List<Place> listeEndroit = convertDataJson
          // ignore: non_constant_identifier_names
          .map((PlaceJson) => Place.fromJson(PlaceJson))
          .toList();

      return listeEndroit;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<List<Soiree>> fetchEvenement(lieu) async {
    //final response = await dio.get(base_url+'service=getSoireeByLieu&lieu='+lieu);
    final response =
        await dio.get(base_url + 'service=getSoireeByLieu&lieu=' + lieu);

    var convertDataJson = jsonDecode(response.data) as List;

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // ignore: non_constant_identifier_names
      List<Soiree> listSoiree = convertDataJson
          // ignore: non_constant_identifier_names
          .map((SoireeJson) => Soiree.fromJson(SoireeJson))
          .toList();

      return listSoiree;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<List<Soiree>> fetchFolk(lieu) async {
    final response =
        await dio.get(base_url + 'service=getFolkByLieu&lieu=' + lieu);

    var convertDataJson = jsonDecode(response.data) as List;

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // ignore: non_constant_identifier_names
      List<Soiree> listSoiree = convertDataJson
          // ignore: non_constant_identifier_names
          .map((SoireeJson) => Soiree.fromJson(SoireeJson))
          .toList();

      return listSoiree;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  /*Future<List<Soiree>> fetchAccous(lieu) async {
      print("accccxccccoooooouuuuussssssxzz");
      final response = await http.get(Uri.https(base_url, 'service=getAccousByLieu&lieu='+lieu);
      print("accccxccccoooooouuuuussssssxzz afteeeer url");
      var convertDataJson = jsonDecode(response.data) as List;
      print("accccxccccoooooouuuuussssssxzz afteeeer url end after decode");
      if (response.statusCode==200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        // ignore: non_constant_identifier_names
        List<Soiree> listSoiree =convertDataJson.map((SoireeJson) => Soiree.fromJson(SoireeJson)).toList();
        print("accccxccccoooooouuuuussssssxzz afteeeer url end after decode and mappping");
        return listSoiree;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    }*/

  Future<List<Soiree>> fetchAccous(lieu) async {
    final response =
        await dio.get(base_url + 'service=getAccousByLieu&lieu=' + lieu);

    var convertDataJson = jsonDecode(response.data) as List;

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // ignore: non_constant_identifier_names
      List<Soiree> listSoireeJour = convertDataJson
          // ignore: non_constant_identifier_names
          .map((SoireeJson) => Soiree.fromJson(SoireeJson))
          .toList();

      return listSoireeJour;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<List<SoireeParjour>> fetchEvenementParJour(lieu) async {
    final response =
        await dio.get(base_url + 'service=getSoireeJourByLieu&lieu=' + lieu);

    var convertDataJson = jsonDecode(response.data) as List;

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // ignore: non_constant_identifier_names
      List<SoireeParjour> listSoireeJour = convertDataJson
          // ignore: non_constant_identifier_names
          .map((SoireeParjourJson) => SoireeParjour.fromJson(SoireeParjourJson))
          .toList();

      return listSoireeJour;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<List<SoireeParjour>> fetchCinema(lieu) async {
    final response =
        await dio.get(base_url + 'service=getCinemaByLieu&lieu=' + lieu);

    var convertDataJson = jsonDecode(response.data) as List;

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // ignore: non_constant_identifier_names
      List<SoireeParjour> listSoireeJour = convertDataJson
          // ignore: non_constant_identifier_names
          .map((SoireeParjourJson) => SoireeParjour.fromJson(SoireeParjourJson))
          .toList();

      return listSoireeJour;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<List<SoireeParjour>> fetchExpo(lieu) async {
    final response =
        await dio.get(base_url + 'service=getExpoByLieu&lieu=' + lieu);

    var convertDataJson = jsonDecode(response.data) as List;

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // ignore: non_constant_identifier_names
      List<SoireeParjour> listSoireeJour = convertDataJson
          // ignore: non_constant_identifier_names
          .map((SoireeParjourJson) => SoireeParjour.fromJson(SoireeParjourJson))
          .toList();

      return listSoireeJour;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<List<Numero>> fetchNumero(lieu) async {
    final response =
        await dio.get(base_url + 'service=getNumeroByLieu&lieu=' + lieu);

    var convertDataJson = jsonDecode(response.data) as List;

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // ignore: non_constant_identifier_names
      List<Numero> listSoiree = convertDataJson
          // ignore: non_constant_identifier_names
          .map((NumeroJson) => Numero.fromJson(NumeroJson))
          .toList();

      return listSoiree;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<List<Annonce>> fetchAnnonce(lieu) async {
    final response =
        await dio.get(base_url + 'service=getAnnonceByLieu&lieu=' + lieu);

    var convertDataJson = jsonDecode(response.data) as List;

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // ignore: non_constant_identifier_names
      List<Annonce> listSoiree = convertDataJson
          // ignore: non_constant_identifier_names
          .map((AnnonceJson) => Annonce.fromJson(AnnonceJson))
          .toList();

      return listSoiree;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<List<Transport>> fetchTransport(endroit) async {
    final response =
        await dio.get(base_url + 'service=gettransports&endroit=' + endroit);

    var convertDataJson = jsonDecode(response.data) as List;

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // ignore: non_constant_identifier_names
      List<Transport> typeEndroit = convertDataJson
          // ignore: non_constant_identifier_names
          .map((TransportJson) => Transport.fromJson(TransportJson))
          .toList();

      return typeEndroit;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<List<Tarif>> fetchTarif(endroit) async {
    final response =
        await dio.get(base_url + 'service=gettarifs&transport=' + endroit);

    var convertDataJson = jsonDecode(response.data) as List;

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // ignore: non_constant_identifier_names
      List<Tarif> listSoiree = convertDataJson
          // ignore: non_constant_identifier_names
          .map((TarifJson) => Tarif.fromJson(TarifJson))
          .toList();

      return listSoiree;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<List<Horaire>> fetchhoraire(endroit) async {
    final response =
        await dio.get(base_url + 'service=gethoraires&transport=' + endroit);

    var convertDataJson = jsonDecode(response.data) as List;

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // ignore: non_constant_identifier_names
      List<Horaire> listSoiree = convertDataJson
          // ignore: non_constant_identifier_names
          .map((HoraireJson) => Horaire.fromJson(HoraireJson))
          .toList();

      return listSoiree;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<List<Place>> fetchallPlaces(lieu) async {
    final response = await dio.get(base_url + 'service=allplaces&lieu=' + lieu);

    var convertDataJson = jsonDecode(response.data) as List;

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // ignore: non_constant_identifier_names
      List<Place> listSoiree = convertDataJson
          // ignore: non_constant_identifier_names
          .map((PlaceJson) => Place.fromJson(PlaceJson))
          .toList();

      return listSoiree;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  void updateVisite(id, visite) async {
    await dio
        .get(base_url + 'service=updateVisite&id=' + id + '&visite=' + visite);
  }

  Future connexion(login, mdp) async {
    try {
      final response = await dio.get(base_url +
          'service=Connexion&login="${login.text}"&mdp="${mdp.text}"');

      var convertDataJson = jsonDecode(response.data);

      return convertDataJson;
    } catch (e) {
      return e;
    }
  }

  Future<User> inscrire(prenom, nom, telephone, login, mdp) async {
    try {
      final response = await dio.get(base_url +
          'service=inscriptionUser&prenom=${prenom.text}&nom=${nom.text}&telephone=${telephone.text}&login=${login.text}&mdp=${mdp.text}');

      var convertDataJson = jsonDecode(response.data);

      User user = User.fromJson(convertDataJson);

      return user;
    } catch (e) {
      throw Exception('Failed to load album');
    }
  }

  Future liker(endroit, user) async {
    try {
      final response =
          await dio.get(base_url + 'service=liker&endroit=$endroit&user=$user');

      var convertDataJson = jsonDecode(response.data);
      return convertDataJson;
    } catch (e) {
      return e;
    }
  }

  Future<List<Place>> getMylikes(user) async {
    final response = await dio.get(base_url + 'service=getlikes&user=' + user);

    var convertDataJson = jsonDecode(response.data) as List;

    if (response.statusCode == 200) {
      // ignore: non_constant_identifier_names
      List<Place> listSoiree = convertDataJson
          // ignore: non_constant_identifier_names
          .map((PlaceJson) => Place.fromJson(PlaceJson))
          .toList();
      return listSoiree;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Place>> getSecteurs(typeId) async {
    final response =
        await dio.get(base_url + 'service=getSecteur&typeId=' + typeId);

    var convertDataJson = jsonDecode(response.data) as List;

    if (response.statusCode == 200) {
      // ignore: non_constant_identifier_names
      List<Place> listSoiree = convertDataJson
          // ignore: non_constant_identifier_names
          .map((PlaceJson) => Place.fromJson(PlaceJson))
          .toList();
      return listSoiree;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Place>> getMySearch(typeId, secteur) async {
    print("secteur secteur secteur secteur secteur");
    print(secteur);
    final response = await dio
        .get(APIConstants.API_BASE_URL+ "places/search/${typeId}/${secteur}");

    var convertDataJson = jsonDecode(response.data) as List;

    if (response.statusCode == 200) {
      // ignore: non_constant_identifier_names
      List<Place> listSoiree = convertDataJson
          // ignore: non_constant_identifier_names
          .map((PlaceJson) => Place.fromJson(PlaceJson))
          .toList();
      return listSoiree;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future isLike(endroit, user) async {
    try {
      final response = await dio
          .get(base_url + 'service=isLike&endroit=$endroit&user=$user');

      var convertDataJson = jsonDecode(response.data);
      return convertDataJson;
    } catch (e) {
      return e;
    }
  }

  Future unlike(endroit, user) async {
    try {
      final response = await dio
          .get(base_url + 'service=unlike&endroit=$endroit&user=$user');

      var convertDataJson = jsonDecode(response.data);
      return convertDataJson;
    } catch (e) {
      return e;
    }
  }

  Future verifTelephone(telephone) async {
    try {
      final response =
          await dio.get(base_url + 'service=verifnumero&telephone=$telephone');

      var convertDataJson = jsonDecode(response.data);
      return convertDataJson;
    } catch (e) {
      return e;
    }
  }

  Future<List<SoireeParjour>> fetchEvenementByEndroit(endroit) async {
    final response =
        await dio.get(base_url + 'service=EvByEndroit&endroit=' + endroit);

    var convertDataJson = jsonDecode(response.data) as List;

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // ignore: non_constant_identifier_names
      List<SoireeParjour> listSoireeJour = convertDataJson
          // ignore: non_constant_identifier_names
          .map((SoireeParjourJson) => SoireeParjour.fromJson(SoireeParjourJson))
          .toList();

      return listSoireeJour;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<NoteAvis> fetchNote(endroit) async {
    final response =
        await dio.get(base_url + 'service=getNotes&endroit=' + endroit);

    var convertDataJson = jsonDecode(response.data);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // ignore: non_constant_identifier_names
      NoteAvis listSoireeJour = NoteAvis.fromJson(convertDataJson);

      return listSoireeJour;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<List<NoteAvis>> fetchAvis(endroit) async {
    final response =
        await dio.get(base_url + 'service=getAvis&endroit=' + endroit);

    var convertDataJson = jsonDecode(response.data) as List;

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // ignore: non_constant_identifier_names
      List<NoteAvis> listSoireeJour = convertDataJson
          // ignore: non_constant_identifier_names
          .map((NoteAvisJson) => NoteAvis.fromJson(NoteAvisJson))
          .toList();

      return listSoireeJour;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future noter(endroit, user, note) async {
    try {
      final response = await dio.get(
          base_url + 'service=Note&endroit=$endroit&user=$user&etoiles=$note');

      var convertDataJson = jsonDecode(response.data);
      return convertDataJson;
    } catch (e) {
      return e;
    }
  }

  Future donnerAvis(endroit, user, avis) async {
    try {
      final response = await dio.get(base_url +
          'service=giveAvis&endroit=$endroit&user=$user&avis="$avis"');

      var convertDataJson = jsonDecode(response.data);
      return convertDataJson;
    } catch (e) {
      return e;
    }
  }

  Future<Place> fetchEndroit(endroitid) async {
    final response =
        await dio.get(base_url + 'service=getEndroit&endroit=' + endroitid);

    var convertDataJson = jsonDecode(response.data);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // ignore: non_constant_identifier_names
      Place listSoireeJour = Place.fromJson(convertDataJson);

      return listSoireeJour;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<List<Pub>> fetchPub() async {
    final response = await dio.get(base_url + 'service=getPubs');

    var convertDataJson = jsonDecode(response.data) as List;

    print(convertDataJson);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // ignore: non_constant_identifier_names
      List<Pub> listSoireeJour =
          // ignore: non_constant_identifier_names
          convertDataJson.map((PubJson) => Pub.fromJson(PubJson)).toList();

      return listSoireeJour;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<List<Place>> fecthSearch(name, rubrique, categorie) async {
    final response = await dio.get(base_url +
        'service=searchNew&name=$name&rubrique=$rubrique&categorie=$categorie');

    var convertDataJson = jsonDecode(response.data) as List;

    print(convertDataJson);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // ignore: non_constant_identifier_names
      List<Place> listSoireeJour = convertDataJson
          // ignore: non_constant_identifier_names
          .map((PlaceJson) => Place.fromJson(PlaceJson))
          .toList();

      return listSoireeJour;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<Endroit> getCat(String idCat) async {
    final response =
        await dio.get(base_url + 'service=getCategorie&categorie=' + idCat);

    var convertDataJson = jsonDecode(response.data);

    if (response.statusCode == 200) {
      Endroit listSoireeJour = Endroit.fromJson(convertDataJson);

      return listSoireeJour;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
