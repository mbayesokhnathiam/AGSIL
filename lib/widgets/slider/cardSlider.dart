import 'package:ajiledakarv/utils/const.dart';
import 'package:ajiledakarv/widgets/slider/cardIndicator.dart';
import 'package:flutter/material.dart';


class CardSlider extends StatefulWidget {
  final List cardItems;

  CardSlider({required this.cardItems});

  @override
  _CardSliderState createState() => _CardSliderState();
}

class _CardSliderState extends State<CardSlider> {
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
        return InkWell(
          onTap: (){

          },
        child:

          Center(
          child: Container(
              width: MediaQuery.of(context).size.width,
              //  height: 200,
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,  // Aligner le contenu à gauche
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 260,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),  // BorderRadius pour la partie supérieure droite
                        topLeft: Radius.circular(10.0),  // BorderRadius pour la partie inférieure droite
                      ),
                      image: DecorationImage(
                        image: NetworkImage("${APIConstants.IMG_BASE_URL}${widget.cardItems[index]["image"]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),  // Ajout de marge en haut
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(widget.cardItems[index]["categorie"], style: TextStyle(color: Color(0xFF1EA438))),
                        SizedBox(width: 10,),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),  // Ajout de marge en haut
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        widget.cardItems[index]["titre"],
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

                ],
              )

          ),
        ))
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
