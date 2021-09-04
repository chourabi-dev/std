import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/Screens/Page_acceuil/page_acceuil.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';


class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);


  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  String _login="";
  String _pass="";
  
    FirebaseAuth _auth = FirebaseAuth.instance;
 
  String _errorMessage= '';

  bool _isConnected = false;

  _checkAuth(){
    
    if (_auth.currentUser != null) {
      // home 
      setState(() {
        _isConnected = true;
      });

    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkAuth();
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: 
      _isConnected == false?
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Se Connecter",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              
              hintText: "Votre Email",
              onChanged: (value) {
                setState(() {
                  _login = value;
                });
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                 setState(() {
                  _pass = value;
                });
              },
            ),
            RoundedButton(
              text: "Se Connecter",
              press: () {


                    _auth.signInWithEmailAndPassword(email: _login, password: _pass).then((res) {
                    
                     Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Pageacceuil();
                    },
                  ),
                );


                   }).catchError((e){
                                         setState(() {
                      _errorMessage = e.message;
                    });
                   });


               
              },
            ),

            _errorMessage != '' ?
            Container(
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width-30,
              decoration: BoxDecoration(
                color: Colors.redAccent

              ),
              child: Text(_errorMessage,style: TextStyle(color: Colors.white),),
            ):
            Container(),


            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Pageacceuil();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ):
      Center(
        child: RoundedButton(
          text: "Go !!",
          press: (){
             Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Pageacceuil();
                    },
                  ),
                );
          },
        ),
      )
    );
  }
}



 
