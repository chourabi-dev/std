import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/rounded_button.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
    String _fullname; 
    String _description;


    TextEditingController _fullnameC = new TextEditingController();
    TextEditingController _descriptionC = new TextEditingController();
    
    

  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;


  _addOffre(){
        _db.collection("members").doc(_auth.currentUser.uid).update({
          "fullname":_fullnameC.text,
          "resume":_fullnameC.text
        }).then((value){
          Navigator.pop(context);
          Navigator.pop(context);
          
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _db.collection("members").doc(_auth.currentUser.uid).get().then((value){
      _fullnameC.text = value.data()['fullname'];
      _descriptionC.text = value.data()['resume'] != null ? value.data()['resume'] : '';
      
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier profile'),
        backgroundColor: Colors.indigoAccent,
      ),  


      body: SingleChildScrollView(
        
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _fullnameC,
              onChanged: (String txt){
                setState(() {
                  _fullname = txt;
                });
              }, 
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[800]),
                hintText: "Nom & prénom",
                
                fillColor: Colors.white70),
              
            ),
            
            
            
            Container(height: 25,),
            TextField(
              controller: _descriptionC,
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
                hintText: "A propos",
                
                fillColor: Colors.white70),
              
            ),

            Container(
              height: 20,
            ),

             
            Container(
              width: MediaQuery.of(context).size.width,
              child: RoundedButton(
                text: "Mettre a jour",
                press: (){
                  if (_fullname != '' &&    _description!='') {
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