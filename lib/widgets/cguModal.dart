import 'package:ajiledakarv/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CGUModal extends StatelessWidget {
//  final String image;
  final String description;
  final String titre;

  const CGUModal ({
    Key? key,
  //  required this.image,
    required this.description,
    required this.titre,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        width: MediaQuery.of(context).size.width/2,
        child:Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Text(
                  description,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),


                SizedBox(height: 20,)

              ],
            ),
            Positioned(
              right: 0,

                child: IconButton(icon: Icon(Icons.close,color: Colors.orange,),onPressed: (){
              Navigator.of(context).pop();
            },))
          ],
        )
      )
    );
  }

  void _callNumber(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Impossible d\'appeler $phoneNumber';
    }
  }
}
