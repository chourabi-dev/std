
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Page_acceuil/components/NotificationBloc.dart';

class NotificationsPage extends StatefulWidget {
  NotificationsPage({Key key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  List<QueryDocumentSnapshot> _list = new List();

  _getNotifications(){
    _db.collection('notifications').where('user', whereIn: ['all',_auth.currentUser.uid]).get().then((res){
      setState(() {
        _list = res.docs;
      });
    } );  
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getNotifications();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
       title: Text('Notifications'),
       backgroundColor: Colors.indigoAccent,
      ),
      body:
      ListView.builder(itemCount: _list.length, itemBuilder: (context, index) {
          return NotificationBloc(text: _list[index].data()['text'], title: _list[index].data()['title'], vue:_list[index].data()['vue'],heure:_list[index].data()['date'].toDate().toString() );
        }, ),
      
      );
      
     
    
  }
}