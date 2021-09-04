import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Page_acceuil/components/Messages.dart';
import 'package:flutter_auth/Screens/Page_acceuil/page_acceuil.dart';
import 'package:flutter_auth/Screens/ajouterpost/ajouter_post.dart';
import 'package:sqflite/sqflite.dart';

class Body extends StatefulWidget {
   Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
   int _selectedIndex = 1;
  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text('Ajouter un Post'),),
      bottomNavigationBar: BottomNavigationBar(
      
        currentIndex: _selectedIndex ,
          onTap: (int i){
            setState(() {
                _selectedIndex = i;
            });
          },
        items: [
          BottomNavigationBarItem(
             icon: IconButton(
              icon: Icon(Icons.home),
              onPressed: ( (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>Pageacceuil()));
              }),
            ),
            title: Text('Home')),
          BottomNavigationBarItem(
             icon: IconButton(
              icon: Icon(Icons.add_comment),
              onPressed: ( (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>AjouterPost()));
              }),
            ),
            title: Text('Ajouter un post')),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.mail),
              onPressed: ( (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>MessagePage()));
              }),
            ),
            title: Text('Messages')
          ),
        ],
      ),
      body:Container(
        child: SingleChildScrollView( 
          child: Column(
            
            children: [
             
               Container(
                padding: EdgeInsets.all(15),
                child: TextField(
                  maxLines: 5,
                  controller: _description,
                  decoration: InputDecoration(
                    hintText: 'Note Title'
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                child:  RaisedButton(
                  onPressed: () async {
                    // call db 
                    //inset

                    var db = await openDatabase('my_db.db');
                    // before insert

                    // check if TABLE notes exist or not !!!

                    await db.execute('CREATE TABLE IF NOT EXISTS notes (id INTEGER PRIMARY KEY AUTOINCREMENT , title TEXT, description TEXT )');

                    // insert
                    await db.insert('notes', {
                    
                      'description':_description.text
                    }).then((value) {
                      Navigator.pop(context);
                    });

                    
                  },
                  child: Text('Ajouter'),
                )
              ),
              
            ],
          ),
        ), 
      ), 
    );
  }
}