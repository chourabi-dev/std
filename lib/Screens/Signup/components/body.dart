import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Page_acceuil/page_acceuil.dart';
import 'package:flutter_auth/Screens/Signup/components/background.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {


  String _login="";
  String _pass="";
  String _name ="";
  
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;
 
  String _errorMessage= '';

  bool _isConnected = false;

  



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "S'inscrire",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              
              hintText: "Votre Nom & prénom",
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
            ),
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
              text: "S'inscrire",
              press: () {


              _auth.createUserWithEmailAndPassword(email: _login.trim(), password: _pass).then((res){
                    print(res.user.uid);

                    // image for the user in the firestore
                    
                    _db.collection('members').doc(res.user.uid).set({
                      'fullname':_name.trim(),
                      'email': _login.trim()
                    }).then((value){
                      // sign in page
                      Navigator.push(context, new MaterialPageRoute(builder: (context) {
                        return Pageacceuil();
                      },));
                    });

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
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
          ] 
        ),  
      ),
    );            
  }
}



 