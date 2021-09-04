import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/EditProfile.dart';
import 'package:image_picker/image_picker.dart';
 
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  
    FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  DocumentSnapshot  _user;


  
  final picker = ImagePicker();
  File _image = null;
  ImageSource _source = ImageSource.gallery;

  Future _choosePicture() async {


      // Create button  
  Widget okButton = FlatButton(  
    child: Text("OK"),  
    onPressed: () {  
      Navigator.of(context).pop();  
    },  
  );  
  
  // Create AlertDialog  
  AlertDialog alert = AlertDialog(  
    content: Container(
      height: 65,
      child: Center(
      child: Column(children: [Text('chargement...'),CircularProgressIndicator()],),
    ),
    )
  );  
  
  // show the dialog  
  showDialog(  
    context: context,  
    builder: (BuildContext context) {  
      return alert;  
    },  
  );  



    final pickedFile = await picker.getImage(source: _source);

    if (pickedFile != null) {
      // we have an image
      setState(() {

        _image = File(pickedFile.path);


      });

      FirebaseStorage storage = FirebaseStorage.instance;

       

      try {
        await storage.ref('uploads/${_auth.currentUser.uid}').putFile(_image).then((res) async {
          String photoURL = await res.ref.getDownloadURL();
          _db.collection('members').doc(_auth.currentUser.uid).update({"photoURL":photoURL}).then((value) {_getMembers();});

          _auth.currentUser.updateProfile(photoURL: photoURL).then((value) => Navigator.pop(context));
          
        });
      } on FirebaseException catch (e) {
        print(e.toString());
      }

    }
  }


  



  _getMembers(){
    _db.collection('members').doc(_auth.currentUser.uid).get().then((res){
      setState(() {
        _user = res;
      });
    } );  
  }





  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getMembers();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: (){
              Navigator.push(context, new MaterialPageRoute(builder: (context){
                return new EditProfilePage();
              }));
            },
          )
        ],
      ),
      body: _user != null ?
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 40,left: 15,right: 15),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                _choosePicture();
              },
              child: CircleAvatar(
              radius: 80,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: _user.data()['photoURL'] == null ? null : NetworkImage(_user.data()['photoURL']),
            ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Text(_user.data()['fullname'],style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
            ),
            
            Container(
              padding: EdgeInsets.only(),
              child: Text(_user.data()['email'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal),),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(15),
              child: Text("A propos",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(15),
              child: Text(_user.data()['resume'] != null ? _user.data()['resume']:"a props vide ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal),),
            ),
            

             
            
            
            
          ],
        ),
        )
      ):

      Center(
        child: CircularProgressIndicator(),
      )
    );

  }
}