import 'package:ajiledakarv/utils/const.dart';
import 'package:ajiledakarv/widgets/slider/cardIndicator.dart';
import 'package:flutter/material.dart';


class CardSlider_opp extends StatefulWidget {
  final List cardItems;

  CardSlider_opp ({required this.cardItems});

  @override
  _CardSliderState createState() => _CardSliderState();
}

class _CardSliderState extends State<CardSlider_opp > {
  final PageController _pageController = PageController();
   int currentIndex =0;


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return   PageView.builder(
      controller: _pageController,
      itemCount: widget.cardItems.length,

      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){

          },
        child:

         Container(
                width:  10,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),  // BorderRadius pour la partie supérieure droite
                    topLeft: Radius.circular(10.0),  // BorderRadius pour la partie inférieure droite
                    bottomRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://www.ideas-factory.net/wp-content/uploads/sites/34/2020/06/evenement-public-scaled.jpg"
                       // "${APIConstants.IMG_BASE_URL}${widget.cardItems[index]["image"]}"

                    ),
                    fit: BoxFit.fill,
                  ),
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
    );
        /*Center(
          child: CardIndicator(
            cardCount: widget.cardItems.length,
            currentIndex:  currentIndex,


          ),
        ),*/




  }
}
