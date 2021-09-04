import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/AddNewProject.dart';
import 'package:flutter_auth/Screens/userprofile/UserProfile.dart';


class ListDesProjet extends StatefulWidget {
  ListDesProjet({Key key}) : super(key: key);

  @override
  _ListDesProjetState createState() => _ListDesProjetState();
}

class _ListDesProjetState extends State<ListDesProjet> {
 
  FirebaseFirestore _db = FirebaseFirestore.instance;
  List<QueryDocumentSnapshot> _list = new List();

  _getList() {
    _db.collection('projects').get().then((res) {
      setState(() {
        _list = res.docs;
      });
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getList();

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text('Tous les projets'),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amberAccent,
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context,  new MaterialPageRoute(builder: (context)=> AddNewProject()));
        },
      ),
      
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context,index){
           Map<String, dynamic> data = _list[index].data();

            return Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
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
                            fontSize: 22, color: Colors.grey.shade800, fontWeight: FontWeight.bold),
                      ),
                      Container(height: 10,),

                      Text(
                        data['description'],
                        style: TextStyle(
                            fontSize: 18, color: Colors.grey.shade800),
                      ),
                      Container(height: 10,),
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