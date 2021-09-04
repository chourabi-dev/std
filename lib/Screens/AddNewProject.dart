import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/rounded_button.dart';

class AddNewProject extends StatefulWidget {
  AddNewProject({Key key}) : super(key: key);

  @override
  _AddNewProjectState createState() => _AddNewProjectState();
}

class _AddNewProjectState extends State<AddNewProject> {
    String _title;
    String _link;
    String _description;
    

  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;


  _addOffre(){
    _db.collection('projects').add({
      "titre":_title, 
      "link":_link, 
      "description":_description, 
      "date": new DateTime.now(),
      "user": _auth.currentUser.uid
    }).then((value){
      _db.collection('notifications').add({
        'title':"nouveau projet",
        'text':_auth.currentUser.email+' a publié une nouvelle projet',
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
        title: Text('Ajouter un project'),
        backgroundColor: Colors.indigoAccent,
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
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[800]),
                hintText: "Titre",
                
                fillColor: Colors.white70),
              
            ),
            
            Container(height: 25,),
            TextField(
              onChanged: (String txt){
                setState(() {
                  _link = txt;
                });
              }, 
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[800]),
                hintText: "Lien github",
                
                fillColor: Colors.white70),
              
            ),
            
            Container(height: 25,),
            TextField(
              onChanged: (String txt){
                setState(() {
                  _description = txt;
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

             
            Container(
              width: MediaQuery.of(context).size.width,
              child: RoundedButton(
                text: "Ajouter",
                press: (){
                  if (_title != '' && _link !='' && _description!='') {
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