import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  const CustomInput(
      {super.key,
      this.titleText = '',
      this.titleTextAlign = TextAlign.center,
      required this.isPassword,
      required this.hintText,
      this.labelText,
      this.textController,
      this.prefixIcon, this.SufixIcon,});

  final String titleText;
  final TextAlign titleTextAlign;
  final bool isPassword;
  final String hintText;
  final TextEditingController? textController;
  final String? labelText;
  final String? prefixIcon;
  final Widget? SufixIcon;




  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  @override
  Widget build(BuildContext context) {
    return 
     
       TextFormField(
         controller:widget.textController ,
      obscureText: widget.isPassword,
      decoration: InputDecoration(
        suffixIcon: widget.SufixIcon,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
        hintText: widget.hintText,
        labelText: widget.labelText,
        hintStyle: const TextStyle(color: Colors.black26),
        prefixIcon: Icon(widget.prefixIcon as IconData?),
        labelStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.orangeAccent, width: 1.0),
          borderRadius: BorderRadius.circular(100),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      style: const TextStyle(color: Colors.black),
    
    );
  }
}






Widget InputSearchCustum(Color bg, String hintText, String labetText) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      color: bg,
    ),
    child: TextFormField(
      decoration: InputDecoration(
        hintStyle: TextStyle(fontSize: 14, color: Colors.black),
        hintText: hintText,
        suffixIcon: Icon(
          Icons.search,
          color: Colors.black,
        ),

        // labelText: labetText ,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: bg,
          ),
          borderRadius: BorderRadius.circular(100),
        ),

        border: InputBorder.none,
      ),
    ),
  );
}

Widget InputSimple(
  Color bg,
  String hintText,
  String labetText,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: bg,
    ),
    child: TextFormField(
      decoration: InputDecoration(
        hintStyle: TextStyle(fontSize: 14, color: Colors.black),
        hintText: hintText,
        suffixIcon: Icon(
          Icons.search,
          color: Colors.black,
        ),

        // labelText: labetText ,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: bg,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),

        border: InputBorder.none,
      ),
    ),
  );
}

Widget btnLarge(
  Color bg,
  String title,
) {
  return Container(
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ));
}
