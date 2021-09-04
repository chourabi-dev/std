import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/rounded_button.dart';

class AddNewOffre extends StatefulWidget{
  AddNewOffre({Key key}) : super(key: key);

  @override
  _AddNewOffreState createState() => _AddNewOffreState();
}

class _AddNewOffreState extends State<AddNewOffre> {

  int _category = 0;
  String _title;

  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;


  _addOffre(){
    _db.collection('offres').add({
      "titre":_title,
      "category":_category,
      "date": new DateTime.now(),
      "user": _auth.currentUser.uid
    }).then((value){
      _db.collection('notifications').add({
        'title':"nouvelle status",
        'text':_auth.currentUser.email+' a publié  une nouvelle status',
        'date': new DateTime.now(),
        'user':'all',
        'vue':false,
        
      }).then((value) => Navigator.pop(context))
      ;
    }).catchError((e)=>{

    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une status'),
        backgroundColor: Colors.amberAccent,
      ),


      body: SingleChildScrollView(
        
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (String txt){
                setState(() {
                  _title = txt;
                });
              },
              minLines: 5,
              maxLines: 6,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[800]),
                hintText: "Déscription",
                
                fillColor: Colors.white70),
              
            ),

            Container(
              height: 20,
            ),

            Text(
              "Category",
              style:TextStyle(
                fontSize: 20
              )
            ),
            Column(
              children: [
                ListTile(
                  title: Text("Offre de stage"),
                  subtitle: Text('ajouter un offre de stage'),
                  leading: Radio(
                    value: 0,
                    groupValue: _category,
                    onChanged: (int x){
                      setState(() {
                        _category = x;
                      });
                    },
                  ),
                ),

                ListTile(
                  title: Text("Formation"),
                  subtitle: Text('ajouter un offre de formation'),
                  leading: Radio(
                    value: 1,
                    groupValue: _category,
                    onChanged: (int x){
                      setState(() {
                        _category = x;
                      });
                    },
                  ),
                ),

                 ListTile(
                  title: Text("Evenement"),
                  subtitle: Text('ajouter un évenement'),
                  leading: Radio(
                    value: 2,
                    groupValue: _category,
                    onChanged: (int x){
                      setState(() {
                        _category = x;
                      });
                    },
                  ),
                ),

                ListTile(
                  title: Text("Autre"),
                  subtitle: Text("autre type d'information"),
                  leading: Radio(
                    value: 3,
                    groupValue: _category,
                    onChanged: (int x){
                      setState(() {
                        _category = x;
                      });
                    },
                  ),
                ),




              ],
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              child: RoundedButton(
                text: "Ajouter",
                press: (){
                  if (_title != '') {
                    _addOffre();
                  }
                },
              ),
            )


          ],
        ),
        )
      )


    );

  }
}