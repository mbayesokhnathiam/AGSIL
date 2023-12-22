
import 'package:ajiledakarv/widgets/slider/cardIndicator.dart';
import 'package:flutter/material.dart';

class CardSliderStack extends StatefulWidget {
  final List cardItems;

  CardSliderStack ({required this.cardItems});

  @override
  _CardSliderState createState() => _CardSliderState();
}

class _CardSliderState extends State<CardSliderStack > {
  final PageController _pageController = PageController();
   int currentIndex =0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
    Expanded(  // Ajout d'Expanded
    child:  PageView.builder(
      controller: _pageController,
      itemCount: widget.cardItems.length,
      itemBuilder: (context, index) {
        return Center(
          child: Container(
              width: MediaQuery.of(context).size.width,
              //  height: 200,
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,  // Aligner le contenu à gauche
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15.0),  // BorderRadius pour la partie supérieure droite
                        topLeft: Radius.circular(15.0),  // BorderRadius pour la partie inférieure droite
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                      image: DecorationImage(
                        image: AssetImage(widget.cardItems[index]["image"]),
                        fit: BoxFit.cover,
                      ),

                    ),
                    child: Stack(
                      children: [
                        Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            top: 0,
                            child: Container(
                              decoration: BoxDecoration( borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15.0),  // BorderRadius pour la partie supérieure droite
                                topLeft: Radius.circular(15.0),  // BorderRadius pour la partie inférieure droite
                                bottomLeft: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0),
                              ),

                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [Colors.green.withOpacity(0.7),Colors.green.withOpacity(0.3),Colors.green.withOpacity(0.0), ],
                                ),
                              ),
                            )
                        ),
                        Positioned(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8.0, 0, 0),  // Ajout de marge en haut
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Economie", style: TextStyle( fontWeight: FontWeight.bold,color: Colors.white)),
                                  SizedBox(width: 10,),
                                  Text("Il y a 2h", style: TextStyle( fontWeight: FontWeight.bold,color: Colors.white)),
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),  // Ajout de marge en haut
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  widget.cardItems[index]["title"],
                                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,color: Colors.white),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        )),

                      ],
                    ),
                  ),



                ],
              )

          ),
        )
        ;
      },
      onPageChanged: (index) {
        print("index__");
        print(index);

        // Mise à jour de l'index courant
        setState(() {
          currentIndex = index;
        });

      },
    )),


        Center(
          child: CardIndicator(
            cardCount: widget.cardItems.length,
            currentIndex:  currentIndex,


          ),
        ),

    ],
    );


  }
}
