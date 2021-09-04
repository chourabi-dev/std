import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Page_acceuil/components/ConnectedUser.dart';

class MyMessages extends StatefulWidget {
  MyMessages({Key key}) : super(key: key);

  @override
  _MyMessagesState createState() => _MyMessagesState();
}

class _MyMessagesState extends State<MyMessages> {


  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
List<QueryDocumentSnapshot> _list = new List();
 
  _getMessages(){
    _db.collection('messages').where('destination',isEqualTo: _auth.currentUser.uid).get().then((value){
      setState(() {
        _list = value.docs;
      });
    });  
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getMessages();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages"),
        backgroundColor: Colors.indigoAccent,
      ),


      body:
             ListView.builder(itemCount: _list.length, itemBuilder: (context, index) {
        return FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListTile(
                  onTap: (){
                    _db.collection('messages').doc(_list[index].id).update({"vue":true}).then((value) { _getMessages(); });
                  },
                  title: Text(snapshot.data['fullname'],
                  style: TextStyle(
                    fontWeight: _list[index].data()['vue'] == false ? FontWeight.bold:FontWeight.normal
                  ),
                   ),
                  subtitle: Text(_list[index].data()['message']+'\n'+_list[index].data()['date'].toDate().toString(),
                  style: TextStyle(
                    fontWeight: _list[index].data()['vue'] == false ? FontWeight.bold:FontWeight.normal
                  ),
                  
                   ),
                  isThreeLine: true,

                  leading: Stack(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        child:  CircleAvatar(
              radius: 80,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: snapshot.data.data()['photoURL']   == null ? null : NetworkImage(snapshot.data.data()['photoURL']  ),
            ),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                      ),
                      /*Positioned(
                        right: 0,
                        child: Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                        ),
                      )*/
                    ],
                  ),
                );
            }

            return Container(
              height: 80,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },

          future: _db.collection('members').doc(_list[index].data()['sender']).get(),

        );




      },),

      

 
      
      
      
      
      
      
      

    );
  }
}