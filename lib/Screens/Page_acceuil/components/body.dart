import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_auth/Screens/LatestProjects.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Page_acceuil/PageDesOffres.dart';
import 'package:flutter_auth/Screens/Page_acceuil/components/NotificationsPage.dart';
import 'package:flutter_auth/Screens/Page_acceuil/pages/MembersPage.dart';
import 'package:flutter_auth/Screens/addNewOffer.dart';
import 'package:flutter_auth/Screens/mymessages/messages.dart';
import 'package:flutter_auth/Screens/page%20de%20profil/Pagedeprofil.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  int _notifications = 0;
  int _messages = 0;

  _getNotifications() {
    _db
        .collection('notifications')
        .where('user', whereIn: ['all',_auth.currentUser.uid]) 
        
        .get()
        .then((value) {
      setState(() {
        _notifications = value.docs.length;
      });
    });
  }

  _getMessages() {
    _db
        .collection('messages')
        .where('destination', isEqualTo: _auth.currentUser.uid)
        .get()
        .then((value) {
      setState(() {
        _messages = value.docs.length;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getNotifications();
    _getMessages();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amberAccent,
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context,  new MaterialPageRoute(builder: (context)=> AddNewOffre()));
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 15),
        child: Column(children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Page d'acceuil",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple),
                ),
                Container(
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage: _auth.currentUser.photoURL != null
                            ? NetworkImage(_auth.currentUser.photoURL)
                            : null,
                      )),
                )
              ],
            ),
          ),

          /*Container(
  margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
  decoration: BoxDecoration(
    color: Colors.grey[200],
    borderRadius: BorderRadius.circular(10),
      ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Icon(
        Icons.search,
        color: Colors.grey,
      ),
      SizedBox(width: 10),
      Expanded(
        child: Text(
          'Search',
          style: TextStyle(color: Colors.grey),
        ),
      ),
      Icon(
        Icons.mic_none,
        color: Colors.grey,
      ),
    ],
  ),
),*/

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(25),
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.purple[700],
                  Colors.purple[400],
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _auth.currentUser == null
                      ? 'Chargement...'
                      : _auth.currentUser.email,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Tell us your dream !',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                SizedBox(height: 10),
                Text(
                  "Ajouter votre résumé et vos centres d'interet",
                  style: TextStyle(
                    color: Colors.grey[200],
                    fontSize: 15,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Pagedeprofil()));
                      },
                      color: Colors.purple[900],
                      textColor: Colors.white,
                      child: Text('voir profil'),
                    ),
                    RaisedButton(
                      onPressed: () {
                        _auth.signOut().then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        });
                      },
                      color: Colors.white,
                      textColor: Colors.purple,
                      child: Text('Déconnexion'),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.purpleAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: IconButton(
                            icon: Icon(Icons.new_releases),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NotificationsPage()));
                            }),
                      ),
                      SizedBox(height: 5),
                      Text('Notifications ($_notifications)')
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.purple[600],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.people),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.push(context,
                                new MaterialPageRoute(builder: (context) {
                              return MembersPage();
                            }));
                          },
                        ),
                      ),
                      SizedBox(height: 5),
                      Text('Membres')
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.purple[700],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.message),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyMessages()));
                          },
                        ),
                      ),
                      SizedBox(height: 5),
                      Text('Messages (${_messages})')
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.purple[800],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.lightbulb_outline),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ListDesProjet()));
                          },
                        ),
                      ),
                      SizedBox(height: 5),
                      Text('Projets')
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.all(4),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  color: Colors.indigoAccent,
                  width: 5,
                  height: 25,
                ),
                SizedBox(width: 10),
                Text(
                  'Actualités',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                Container(
                  height: 130,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Container(
                        child: Image.asset(
                          'assets/images/stage.jpg',
                          fit: BoxFit.cover,
                        ),
                        height: 130,
                        width: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'offres de stages',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.grey[500]),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'stages',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RaisedButton(
                                    color: Colors.purple[400],
                                    textColor: Colors.white,
                                    onPressed: () {
                                      Navigator.push(context, new MaterialPageRoute(builder: (context){
                                        return PageDesOffres(category: 0,);
                                      }));
                                    },
                                    child: Text('Details'),
                                    
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 130,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Container(
                        child: Image.asset(
                          'assets/images/formation.jpg',
                          fit: BoxFit.fill,
                        ),
                        height: 130,
                        width: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Les Formations',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.grey[500]),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Formations',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RaisedButton(
                                    color: Colors.purple[400],
                                    textColor: Colors.white,
                                    onPressed: () {
                                      Navigator.push(context, new MaterialPageRoute(builder: (context){
                                        return PageDesOffres(category: 1,);
                                      }));
                                    },
                                    child: Text('Details'),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 130,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Container(
                        child: Image.asset(
                          'assets/images/formation1.jpg',
                          fit: BoxFit.fill,
                        ),
                        height: 130,
                        width: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Les Evenements',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.grey[500]),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'evenements',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RaisedButton(
                                    color: Colors.purple[400],
                                    textColor: Colors.white,
                                    onPressed: () {
                                      Navigator.push(context, new MaterialPageRoute(builder: (context){
                                        return PageDesOffres(category: 2,);
                                      }));
                                    },
                                    child: Text('Details'),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),



Container(
                  height: 130,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Container(
                        child: Image.asset(
                          'assets/images/formation1.jpg',
                          fit: BoxFit.fill,
                        ),
                        height: 130,
                        width: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Autres',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.grey[500]),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'découvrir...',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RaisedButton(
                                    color: Colors.purple[400],
                                    textColor: Colors.white,
                                    onPressed: () {
                                      Navigator.push(context, new MaterialPageRoute(builder: (context){
                                        return PageDesOffres(category: 3,);
                                      }));
                                    },
                                    child: Text('Details'),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),



              ],
            ),
          ),
        ]),
      ),
    );
  }
}
