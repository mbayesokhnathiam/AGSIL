import 'package:ajiledakarv/common/color.dart';
import 'package:ajiledakarv/common/input.dart';
import 'package:ajiledakarv/models/Country.dart';
import 'package:ajiledakarv/services/Auth/apiUser.dart';
import 'package:ajiledakarv/services/apiService.dart';
import 'package:ajiledakarv/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:motion_toast/motion_toast.dart';


class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _nomController = TextEditingController();
  TextEditingController _prenomController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
/*  TextEditingController _identifiantController = TextEditingController();
  TextEditingController _telController = TextEditingController();
  */TextEditingController  _passwordController = TextEditingController();
  TextEditingController  _confirmpasswordController = TextEditingController();
  List<CountryModel> countries=[];
  String initialCountry = 'SN';
  PhoneNumber number = PhoneNumber(isoCode: 'SN');

  var _isObscur ;
bool _loading =false;
 register() async {
   setState(() {
     _loading=true;
   });
   var response;
  Map body= {
     "nom": _nomController.text,
     "prenom": _prenomController.text,
     "email": _emailController.text,
     /*"identifiant": _identifiantController.text,
      "telephone": _telController.text,*/
      "password":_passwordController.text,
      "profil_id": 2
   };
   if(_nomController.text=="" || _prenomController.text=="" ||_emailController.text=="" || /*_identifiantController.text==""|| _telController.text=="" ||*/_passwordController.text==""){
     MotionToast.error(
         title:  Text("Erreur"),
         description:  Text("Désolé, mais tous les champs sont obligatoires. Veuillez remplir tous les champs requis pour continuer.")
     ).show(context);
   }
 else  if(_passwordController.text!=_confirmpasswordController.text){
    MotionToast.error(
        title:  Text("Erreur"),
        description:  Text("Désolé, mais les mots de passe saisis ne correspondent pas. Veuillez vérifier et confirmer à nouveau votre mot de passe.")
    ).show(context);
  } else {
   await AuthService().register(body).then((value) {
     response=value;

   });
if(response["code"]!=200){
  MotionToast.error(
      title:  Text("Erreur"),
      description:  Text(response["error"][0].toString())
  ).show(context);
} else {

  MotionToast.success(
    title:  Text("Success"),
    description:  Text(response["message"].toString()),
  ).show(context);
  Future.delayed(Duration(milliseconds: 5000), () {
   Navigator.of(context).pop();
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
  //  getDatas();
    super.initState();
    _isObscur = true ; 
  }
  @override
  Widget build(BuildContext context) {
    
    var w = MediaQuery.of(context).size.width;
    return Loader(

       loadIng: _loading,
       color: Colors.black,
       opacity: .5,
       child: Scaffold(
      body: SingleChildScrollView(
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
                          Icon(Icons.arrow_back_ios,color:Colors.grey),
                          SizedBox(width: 10,),
                          Text('Creation de compte',style: TextStyle(color:Colors.grey),)
                        ],
                      )
                  ),
                  TextButton(
                    
                      onPressed: () {
                       /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => bnv(country_d_code: countries.where((e) =>e.code=="SN" ).first,)));*/
                      },
                      child: Text('' , style:TextStyle(
                            decoration: TextDecoration.underline,
                       color: Colors.grey
                      ) ,))
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: w * 0.14),
                height: 120,
                child: Image(image: AssetImage('assets/images/logo-agil.png')),
              ),
              Form(
                child: Column(
                  children: [
                    CustomInput(

                        SufixIcon : Icon(Icons.person),
                        isPassword: false,
                        hintText: "Nom",
                        labelText: 'Nom',
                        textController: _nomController,

                    ),

                    SizedBox(
                      height: w * 0.06,
                    ),
                    CustomInput(
                        textController:_prenomController,
                        SufixIcon : Icon(Icons.person),
                        isPassword: false,
                        hintText: "Prenom",
                        labelText: 'Prenom'),

                    SizedBox(
                      height: w * 0.06,
                    ),
                    CustomInput(
                        textController:_emailController,
                        SufixIcon : Icon(Icons.mail),
                        isPassword: false,
                        hintText: "Email",
                        labelText: 'Email'),

                    /* SizedBox(
                      height: w * 0.06,
                    ),
     InternationalPhoneNumberInput(
                      inputDecoration: InputDecoration(
                        hintText: 'Numéro de téléphone',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),

                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        suffixIcon: Icon(Icons.call),

                        labelText: 'Numéro de téléphone',
                        hintStyle: const TextStyle(color: Colors.black26),
                       // prefixIcon: Icon(Icons.call as IconData?),
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.orangeAccent, width: 1.0),
                          borderRadius: BorderRadius.circular(100),
                        ),




                      ),
                      onInputChanged: (PhoneNumber number) {
                        print(number.phoneNumber);
                      },
                      onInputValidated: (bool value) {
                        print(value);
                      },
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: TextStyle(color: Colors.black),
                      initialValue: number,
                      textFieldController: _telController,

                      formatInput: true,
                      keyboardType:
                      TextInputType.numberWithOptions(signed: true, decimal: true),
                      inputBorder: OutlineInputBorder(),
                      onSaved: (PhoneNumber number) {
                        print('On Saved: $number');
                      },

                    ),


                    SizedBox(
                      height: w * 0.06,
                    ),
                    CustomInput(
                        textController:_identifiantController,
                        SufixIcon : Icon(Icons.verified_user),
                        isPassword: false,
                        hintText: "Identifiant",
                        labelText: 'Identifiant'),*/

                    SizedBox(
                      height: w * 0.06,
                    ),
                    CustomInput(
                        textController:_passwordController,
                        isPassword: _isObscur ? true :false,
                        SufixIcon: IconButton(
                          focusColor: primary ,
                          onPressed: () {
                          setState(() {
                            _isObscur = !_isObscur;
                          });
                        }, icon: _isObscur ? Icon(Icons.visibility): Icon(Icons.visibility_off)),
                        hintText: "Mot de passe",
                        labelText: 'Mot de passe'),
                     SizedBox(
                      height: w * 0.06,
                    ),
                    CustomInput(
                       textController: _confirmpasswordController,
                        isPassword: _isObscur ? true :false,
                        SufixIcon: IconButton(onPressed: () {
                          setState(() {
                            _isObscur = !_isObscur;
                          });
                        }, icon: _isObscur ? Icon(Icons.visibility): Icon(Icons.visibility_off)),
                        hintText: "Confimer mot de passe",
                        labelText: 'Confirmer mot de passe'),
                       SizedBox(
                      height: 45,
                    ),
                    GestureDetector(
                      onTap: () async {
                      await   register();
                        /*  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Login()));*/
                      },
                      child: Container(
                        width: w * 0.7,
 height: 45,                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: primary,
                        ),
                        child: const Center(
                          child: Text(
                            'Inscription',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 40),
                    ),
                  /*  const Text('ou se connecter avec :'),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          child:  Icon(
                            Icons.facebook,
                            color: Colors.blue,
                          ),
                          decoration: BoxDecoration(
                            boxShadow: const [
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
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 56, 56, 56),
                                blurRadius: 4,
                                offset: Offset(0.3, 2), // Shadow position
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: const Icon(
                            Icons.access_alarm,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),*/
                    const SizedBox(
                      height: 20,
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
