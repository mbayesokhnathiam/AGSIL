import 'package:ajiledakarv/auth/register.dart';
import 'package:ajiledakarv/auth/resetPassword.dart';
import 'package:ajiledakarv/bottom_navigation_bar.dart';
import 'package:ajiledakarv/common/color.dart';
import 'package:ajiledakarv/common/input.dart';
import 'package:ajiledakarv/models/Country.dart';
import 'package:ajiledakarv/screen/explorer/explore.dart';
import 'package:ajiledakarv/services/Auth/apiUser.dart';
import 'package:ajiledakarv/utils/const.dart';
import 'package:ajiledakarv/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/apiService.dart';

class Login extends StatefulWidget {
  final CountryModel country;
 Login({super.key, required this.country});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _loginController = TextEditingController();
  TextEditingController  _passwordController = TextEditingController();
  List<CountryModel> countries=[];
  bool _loading =false;
  getUser(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _loading=true;
    });
    var response;
    await  ApiService().getdata("user/info",token).then((value) =>{
      response=value

    });
    if(response["code"]==200){
      prefs.setString(APIConstants.CONNECTED_USER_NAME,"${response["data"]["prenom"] } ${response["data"]["nom"] } ");

    }
    setState(() {
      _loading=false;
    });
   print(response);
  }


  login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _loading=true;
    });
    var response;
    Map body= {
      "email":_loginController.text,
      "password": _passwordController.text
    };
    if(_loginController.text=="" ||_passwordController.text==""){
      MotionToast.error(
          title:  Text("Erreur"),
          description:  Text("Désolé, mais tous les champs sont obligatoires. Veuillez remplir tous les champs requis pour continuer.")
      ).show(context);
      setState(() {
        _loading=false;
      });
      return false;
    }
  else {
      await AuthService().login(body).then((value) {
        response=value;

      });
      print(response);
      if(response["code"]!=200){

        print(response);
        MotionToast.error(
            title:  Text("Erreur"),
            description:  Text(response["error"][0]!=null?response["error"][0].toString():"Email ou mot de passe incorrecte")
        ).show(context);
        setState(() {
          _loading=false;
        });
      } else {
        prefs.setString(APIConstants.TOKEN, response["data"]);
       /* MotionToast.success(
          title:  Text("Success"),
          description:  Text("Connection réussis"),
        ).show(context);*/
        await getUser(response["data"]);
        Future.delayed(Duration(milliseconds: 10), () {
         Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>  bnv(country_d_code: widget.country,)));

          //  Navigator.of(context).pop();
        });

      }
      setState(() {
        _loading=false;
      });
    }
  }
  getDatas() async{
    setState(() {
      _loading=true;


    });

    var response;
    await  ApiService().getData("countrie/list").then((value) =>{
      response=value

    });
    setState(() {
      _loading=false;
      countries=CountryModel.fromJsonList(response["data"]);

    });
  }
  @override
  void initState() {
    // TODO: implement initState
 //   getDatas();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Loader(
         loadIng: _loading,
         color: Colors.black,
         opacity: .6,
         child:SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child:Row(
                        children: [
                          Icon(Icons.arrow_back_ios,color: Colors.grey,),
                          SizedBox(width: 10,),
                          Text('Se connecter',style: TextStyle(color:Colors.grey),)
                        ],
                      )
                  ),


                  TextButton(
                    onPressed: (){
                   /*   Future.delayed(const Duration(milliseconds: 1), () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  bnv(country_d_code:countries.first,)));

                      });*/
                    },
                    child: Text('' ,  style: GoogleFonts.inter(
                    fontSize: 14,
                      color: Colors.grey
                  ),),),


                ],
              ),
              Container(
                
                margin: EdgeInsets.symmetric(vertical: w * 0.14),
              
                child:
                    Image(image: AssetImage('assets/images/logo-agil.png')),
              ),
              Form(
                child: Column(
                  children: [
                 CustomInput(
                      textController: _loginController,
                      isPassword: false,
                      labelText: 'email',
                      hintText: 'email',
                    ),
                    SizedBox(
                      height: w * 0.06,
                    ),
                    CustomInput(
                      textController: _passwordController,
                        isPassword: true,
                        hintText: "password",
                        labelText: 'password'),
                     SizedBox(
                      height: w * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {

    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => ResetPassword()));

    //  Navigator.of(context).pop();

                            },
                            child: Text('Mot de passe oublié' ))
                      ],
                    ),
                    SizedBox(height: 48),
                    GestureDetector(
                      onTap: ()  async{
                       await login();

                      },
                      child: Container(
                       width: w * 0.7,
                       
  height: 45,                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: primary,
                        ),
                        child: Center(
                          child: Text(
                            'Connexion',
                            style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                 /*   SizedBox(
                      height: w * 0.04,
                    ),
                    Text('ou se connecter avec : ' , style: GoogleFonts.inder( fontWeight: FontWeight.w300),),
                     SizedBox(
                      height: w * 0.05 ,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.facebook,
                            color: Colors.blue,
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 56, 56, 56),
                                blurRadius: 4,
                                offset: Offset(0.3, 2), // Shadow position
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                       SizedBox(
                      width: w * 0.05 ,
                    ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.facebook,
                            color: Colors.blue,
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 56, 56, 56),
                                blurRadius: 4,
                                offset: Offset(0.3, 2), // Shadow position
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      ],
                    ),*/
                   SizedBox(
                      height: w * 0.05 ,
                    ),
                    Text("je n'ai pas encore de compte !"),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(onTap: () =>  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Register())),

                      child: Container(
                        width: w * 0.7,
                         height: 45,  
                         decoration: BoxDecoration(
                          border: Border.all(color: Colors.orangeAccent),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            'Inscription',
                            style: TextStyle(
                                color: primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}