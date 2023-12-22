import 'package:ajiledakarv/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:open_share_pro/open.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemModal extends StatelessWidget {
  final String image;
  final String description;
  final String phoneNumber;
  final String mail;

  const ItemModal({
    Key? key,
    required this.image,
    required this.description,
    required this.phoneNumber,
    required this.mail,
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
                SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      "${APIConstants.IMG_BASE_URL}/${image}",
                      height: 200,
                      width: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  description,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        IconButton(   onPressed: () {
                          Open.phone(phoneNumber: phoneNumber);
                         // _callNumber(phoneNumber);
                        }, icon: Icon(Icons.call,color: Colors.orange,size: 40,)),
                        SizedBox(height: 5,),
                        Text("Appelez")
                      ],
                    ),
                    SizedBox(width: 10,),
                    Column(
                      children: [
                        IconButton(   onPressed: () {
                          Open.mail(
                              toAddress: mail,
                              subject: "",
                              body: "");
                        }, icon: Icon(Icons.mail,color: Colors.orange,size: 40,)),
                        SizedBox(height: 5,),
                        Text("Mail")
                      ],
                    ),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(   onPressed: () {

                        }, icon: Icon(Icons.date_range,color: Colors.orange,size: 40,)),
                        SizedBox(height: 5,),
                        Text("Reservez",)
                      ],
                    )




                  ],
                ),
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
