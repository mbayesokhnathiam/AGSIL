import 'package:ajiledakarv/auth/begin.dart';
import 'package:ajiledakarv/auth/login.dart';
import 'package:ajiledakarv/services/apiService.dart';
import 'package:ajiledakarv/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

class MonCompte extends StatefulWidget {
  const MonCompte({super.key});

  @override
  State<MonCompte> createState() => _MonCompteState();
}

class _MonCompteState extends State<MonCompte> {
  String? userName;
  initData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString(APIConstants.CONNECTED_USER_NAME);
    });
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userName == null
          ? Center(
              child: GestureDetector(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();

                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Begin()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.orangeAccent,
                ),
                child: Center(
                  child: Text(
                    'Connexion',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ))
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 100,
                  width: 100,
                  child: const CircleAvatar(
                    backgroundImage: AssetImage('assets/avatar.png'),
                  ),
                ),
                Text(
                  userName != null ? userName! : "",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Share.share(
                        'Agsil est votre guide digital touristique et culturel, la première application mobile qui vous fournit grâce à sa mise à jour quotidienne tout l’agenda culturel de certaines villes: live-music, expos art, théâtre, cinéma, brunchs … plats du jour.Chatter avec Mory votre assistant digital, qui vous guidera après que vous ayez choisi votre centre d’interêt : hôtel, restaurant, galerie d’art, centre culturel, espace co-working, cinéma …. Vous pouvez utilisez les icônes téléphones, géolocalisations directement sans quitter l’application. Agsil rend accessible votre destination ! http://onelink.to/e9azjw');
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Inviter des amis',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                          ),
                        ),
                        const Icon(Icons.share)
                      ],
                    ),
                  ),
                ),

                /*   GestureDetector(
              onTap: () {

              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                              color: Colors.grey[300],

                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Mes Préférences' , style: GoogleFonts.inter(
                      fontSize: 14,

                    ),),
                    const Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),*/
                GestureDetector(
                  onTap: () async {
                    /**/

                    PanaraConfirmDialog.show(
                      context,
                      title: "Suppression",
                      message:
                          "Lorsque vous supprimez votre compte AGSIL, voici les conséquences à prendre en compte : \n 1.Perte de données : Toutes vos informations personnelles et vos préférences seront supprimés. \n 2. Accès aux fonctionnalités : Vous perdrez l'accès aux fonctionnalités réservées aux utilisateurs enregistrés.",
                      confirmButtonText: "Confirmer",
                      cancelButtonText: "Annuler",
                      onTapCancel: () {
                        Navigator.pop(context);
                      },
                      onTapConfirm: () async {
                        var response;
                        await ApiService()
                            .getData1("user/delete")
                            .then((value) => {response = value});
                        if (response["code"] == 200) {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.clear();

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Begin()));
                        } else {
                          Navigator.pop(context);
                        }
                        print(response);
                        // Navigator.pop(context);
                      },
                      panaraDialogType: PanaraDialogType.warning,
                      barrierDismissible:
                          false, // optional parameter (default is true)
                    );
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Supprimer mon compte',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                          ),
                        ),
                        const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Begin()));
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Se deconnecter',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                          ),
                        ),
                        const Icon(Icons.logout)
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
