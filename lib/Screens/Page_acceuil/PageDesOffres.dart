import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/userprofile/UserProfile.dart';

class PageDesOffres extends StatefulWidget {
  final int category;

  PageDesOffres({Key key, this.category}) : super(key: key);

  @override
  _PageDesOffresState createState() => _PageDesOffresState();
}

class _PageDesOffresState extends State<PageDesOffres> {
  int _category;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  List<QueryDocumentSnapshot> _list = new List();

  _getList() {
    _db.collection('offres').where('category',isEqualTo: _category).get().then((res) {
      setState(() {
        _list = res.docs;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _category = widget.category;
    _getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> data = _list[index].data();

            return Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*FutureBuilder(
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

        ),*/

                      FutureBuilder(
                        future: _db.collection('members').doc(data['user']).get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return GestureDetector(
                              onTap: (){
                                 Navigator.push(context, 
                                  new MaterialPageRoute(builder: (context) {
                                    return new UserProfile(uid: data['user'],);
                                  },)
                                  );
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.grey.shade300,
                                      backgroundImage: snapshot.data
                                                  .data()['photoURL'] ==
                                              null
                                          ? null
                                          : NetworkImage(
                                              snapshot.data.data()['photoURL']),
                                    ),
                                    Container(
                                      width: 20,
                                    ),
                                    Text(snapshot.data.data()['fullname'])
                                  ],
                                ),
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
                      ),
                      Text(
                        data['titre'],
                        style: TextStyle(
                            fontSize: 22, color: Colors.grey.shade800),
                      ),
                      Text(data['date'].toDate().toString()),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
