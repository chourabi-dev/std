import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/userprofile/UserProfile.dart';

class MembersPage extends StatefulWidget {
  MembersPage({Key key}) : super(key: key);

  @override
  _MembersPageState createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {

  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  List<QueryDocumentSnapshot> _list = new List();

  _getMembers(){
    _db.collection('members').get().then((res){
      setState(() {
        _list = res.docs;
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
       title: Text('Members'),
       backgroundColor: Colors.indigoAccent,
      ),
      body:
      ListView.builder(itemCount: _list.length, itemBuilder: (context, index) {
          if( _list[index].id != _auth.currentUser.uid ){
            return ListTile( 
            onTap: (){
              Navigator.push(context, 
              new MaterialPageRoute(builder: (context) {
                return new UserProfile(uid: _list[index].id,);
              },)
              );
            },
            title : Text(_list[index].data()['fullname'] ),
            subtitle: Text(_list[index].data()['email']),
            leading: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              backgroundImage: _list[index].data()['photoURL'] == null ? null : NetworkImage(_list[index].data()['photoURL']),
            ),

            
            );
          }else{
            return Container();
          }
        }, ),
      
      );
      
  }
}