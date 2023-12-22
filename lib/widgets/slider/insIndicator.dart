import 'package:flutter/material.dart';

class InsIndicator extends StatelessWidget {
  final int cardCount;
  final int currentIndex ;

  InsIndicator ({required this.cardCount, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        cardCount,
            (index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: index == currentIndex ?20:20.0,
              height: 3.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                shape: BoxShape.rectangle,
                color: index+1 <= currentIndex ? Colors.green : Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }
}