import 'package:ajiledakarv/models/Region.dart';
import 'package:ajiledakarv/models/chat_model.dart';
import 'package:ajiledakarv/screen/results/resultats.dart';

import 'package:ajiledakarv/widgets/msg.dart';
import 'package:ajiledakarv/widgets/userMsg.dart';
import 'package:flutter/material.dart';

import '../../services/apiService.dart';

class ChatPage extends StatefulWidget {
  RegionModel region;
  ChatPage({super.key, required this.region});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool choosing = false;
  int step = -1;
  int typeId = 0;
  int placeId = 0;

  int zoneId = 0;
  List centres = [];
  List places = [];
  List zones = [];

  String selectedcentre = "";
  String selectedzone = "";
  String selectedplace = "";
  var show;
  final ScrollController _scrollController = ScrollController();

  getMess(path, stp) async {
    print(path);
    var response;
    await ApiService().getData(path).then((value) => {response = value});
    setState(() {
      step = step + 1;
    });
    if (step == 0) {
      setState(() {
        centres = response["data"];
      });
    } else if (stp == 1) {
      print("zzezezeze");
      setState(() {
        zones = response["data"];
        zoneId = 0;
        selectedzone = "";
      });
    } else if (stp == 2) {
      setState(() {
        places = response["data"];
      });
    } else {
      setState(() {
        show = response["data"];
      });
    }
    /*if(step<2){
      msg=response["data"];
      if(msg.length>0){
        setState(() {
          step=step+1;
        });
      }
    }

    msg.forEach((e) {
      setState(() {

        messages.add(Message(
          text:step==0? e["type"]:(step==1?e["zone_name"]:"${e["name"]}-${e["phone"]}"),
          isUser: false,
          id: e["id"],
        ));
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
    setState(() {
      choosing=false;
    });*/
    /* WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });*/
  }

  final List<Message> messages = [
    /*   Message(
      text: 'Bonjour ! Comment puis-je vous aider ?',
      isUser: false,
      id: 0,
    ),*/
  ];


  userMessage(id, msg) async {
    /* var   path="";

    if(!choosing){
      setState(() {
        messages.add(Message(text: msg, isUser: true, id: id,));
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
      setState(() {
        choosing=true;
      });
      if(step==0){
        path = "centres/zone/list/${id}/";
        setState(() {
          type=id;
        });
      } else if(step==1){
        path = "places/search/${type}/${id}";
        setState(() {
          zone=id;
        });
      } else if(step==2){
        path = "places/show/${id}";
        setState(() {
          zone=id;
        });
      }


      await  getMess(path);*/

    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    getMess("centres/list/${widget.region.id}", step);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var blockSizeVertical = MediaQuery.of(context).size.height / 100;
    print("tailleListe");
    //print(tailleListe!);
    // print(snapshot.data.length ~/ 3);

    if (centres.length ~/ 3 == 0) {
    } else if (centres.length ~/ 3 <= 1) {
    } else if (centres.length ~/ 3 == 2) {
    } else {
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Chat',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          controller: _scrollController,
          children: [
            Msg(
              msg: 'Salut , ravi de vous retrouver !',
              msg1: "Choisissez votre centre d'intérêt.",
            ),

            /////type grid
            if (centres.length > 0)
              Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                padding: EdgeInsets.all(blockSizeVertical),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Wrap(
                  spacing: 6, // Espace horizontal entre les enfants
                  runSpacing: 6, // Espace vertical entre les lignes d'enfants
                  alignment: WrapAlignment.spaceAround,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: List.generate(centres.length, (index) {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            setState(() {
                              selectedcentre = centres[index]["type"];
                              setState(() {
                                typeId = centres[index]["id"];
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  _scrollController.animateTo(
                                    _scrollController.position.maxScrollExtent,
                                    duration: Duration(milliseconds: 1000),
                                    curve: Curves.easeOut,
                                  );
                                });
                              });

                              /* WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        });*/
                              var path =
                                  "centres/zone/list/${typeId}/${widget.region.id}";
                              print(path);
                              getMess(path, 1);
                            });
                          });
                        },
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Container(
                            width: 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: selectedcentre == centres[index]["type"]
                                  ? Colors.orangeAccent
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.all(6),
                            //  margin: EdgeInsets.all(5),
                            child: Text(centres[index]["type"],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:
                                      selectedcentre == centres[index]["type"]
                                          ? Colors.white
                                          : Colors.black,
                                  fontSize: 13,
                                )),
                          ),
                        ));
                  }),
                ),

                /*    GridView.count(

                  //childAspectRatio: 0.7, // set the aspect ratio to control the height of items

                  //   color: Colors.grey[200], // set the background color of the grid
                  //controller: controller,
                  shrinkWrap: true,
                  primary: false,
                  crossAxisCount: 3,
                  childAspectRatio: 2.2,
                  children: List.generate(centres.length, (index) {
                    //print(_selectedIndexs);
                    // print(_isSelected);
                    // print(index);
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            setState(() {
                              selectedcentre = centres[index]["type"];
                              setState(() {
                                typeId = centres[index]["id"];
                              });
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: Duration(milliseconds: 1000),
                                  curve: Curves.easeOut,
                                );
                              });
                              /* WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        });*/
                              var path =
                                  "centres/zone/list/${typeId}/${widget.region.id}";
                              print(path);
                              getMess(path, 1);
                            });
                          });
                        },
                        child: Container(
                          // color: Colors.cyanAccent,
                          alignment: Alignment.center,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: selectedcentre == centres[index]["type"]
                                  ? Colors.orangeAccent
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.all(2),
                            margin: EdgeInsets.all(5),
                            child: Text(centres[index]["type"],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:
                                      selectedcentre == centres[index]["type"]
                                          ? Colors.white
                                          : Colors.black,
                                  fontSize: 12,
                                )),
                          ),
                        ));
                  }),
                ),*/
              ), /////

            ///Affiche le typpe selected
            if (selectedcentre != "")
              UserMsg(
                msg: selectedcentre,
              ),
            if (selectedcentre != "")
              Msg(
                msg: 'Vous avez choisi ${selectedcentre}',
                msg1: 'Choisissez une zone',
              ),

            ///grid zones
            if (zones.length != 0 && selectedcentre != "")
              /////type grid
              Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                padding: EdgeInsets.all(blockSizeVertical),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Wrap(
                  spacing: 6, // Espace horizontal entre les enfants
                  runSpacing: 6, // Espace vertical entre les lignes d'enfants
                  alignment: WrapAlignment.spaceAround,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: List.generate(zones.length, (index) {
                    return GestureDetector(
                        onTap: () {
                          var path =
                              "places/search/${typeId}/${zones[index]["id"]}";
                          print(path);
                          getMess(path, 2);

                          setState(() {
                            zoneId = zones[index]["id"];
                            selectedzone = zones[index]["zone_name"];
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: Duration(milliseconds: 1000),
                                curve: Curves.easeOut,
                              );
                            });
                          });
                        },
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Container(
                            width: 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: selectedzone == zones[index]["zone_name"]
                                  ? Colors.orangeAccent
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.all(7),
                            child: Text(
                              zones[index]["zone_name"].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: selectedzone == zones[index]["zone_name"]
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ));
                  }),
                ),

                /* GridView.count(
                  //controller: controller,
                  shrinkWrap: true,
                  primary: false,
                  crossAxisCount: 3,
                  //childAspectRatio: 2.2,
                  children: List.generate(zones.length, (index) {
                    //print(_selectedIndexs);
                    // print(_isSelected);
                    // print(index);
                    return GestureDetector(
                        onTap: () {
                          var path =
                              "places/search/${typeId}/${zones[index]["id"]}";
                          print(path);
                          getMess(path, 2);

                          setState(() {
                            zoneId = zones[index]["id"];
                            selectedzone = zones[index]["zone_name"];
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: Duration(milliseconds: 1000),
                                curve: Curves.easeOut,
                              );
                            });
                          });
                        },
                        child: Container(
                            //  width: 100,

                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: selectedzone == zones[index]["zone_name"]
                                  ? Colors.orangeAccent
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(5),
                            child: Text(
                              zones[index]["zone_name"].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: selectedzone == zones[index]["zone_name"]
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            )));
                  }),
                ),*/
              ), /////

            ///Affiche la  zone selected

            if (selectedzone != "")
              UserMsg(
                msg: selectedzone,
              ),
            if (selectedzone != "")
              Msg(
                msg: "Super! vous avez choisi ${selectedzone}",
                msg1:
                    'Voici la liste des ${selectedcentre} qui se trouve à ${selectedzone}',
              ),
            if (selectedzone != "")
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) {
                          return Resultat(
                            idType: typeId,
                            idZone: zoneId,
                            zone: selectedzone,
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: 30, left: 60,right: 16),
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 114, 110, 110),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Center(
                        child: Text(
                          "Explorer",
                          style: TextStyle(color: Colors.white),
                        ),
                      ))),

            SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}
