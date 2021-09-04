import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/send_message/send_message_page.dart';

class UserProfile extends StatefulWidget {
  final String uid;
  
  UserProfile({Key key, this.uid}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {


  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  DocumentSnapshot  _user;

  _getMembers(){
    _db.collection('members').doc(widget.uid).get().then((res){
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
      ),
      body: _user != null ?
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 40,left: 15,right: 15),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: _user.data()['photoURL'] == null ? null : NetworkImage(_user.data()['photoURL']),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Text(_user.data()['fullname'],style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
            ),

            Container(
              padding: EdgeInsets.only(bottom: 15),
              child: Text(_user.data()['email'],style: TextStyle(color: Colors.grey, fontSize: 18,fontWeight: FontWeight.normal),),
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
            

             

            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  FlatButton(
                    onPressed: (){
                      Navigator.push(context, new MaterialPageRoute(builder: (context){
                        return SendMessage(uid: widget.uid,fullname: _user.data()['fullname'].toString(),);

                      }));
                    },
                    child: Column(
                    children: [
                      
                      Icon(Icons.message),
                      Text('message')
                    ],
                  ),),

                  
                  


                ],
              ),
            )
            
            
            
            
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