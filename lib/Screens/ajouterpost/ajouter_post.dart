import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/ajouterpost/components/body.dart';
import 'package:sqflite/sqflite.dart';

class AjouterPost extends StatefulWidget {
  AjouterPost({Key key}) : super(key: key);

  @override
  _AjouterPostState createState() => _AjouterPostState();
}

class _AjouterPostState extends State<AjouterPost> {
List<Map> _notes = [];


  _getNotes() async{
    var db = await openDatabase('my_db.db');
    List<Map> list = await db.rawQuery('SELECT * FROM notes');

    setState(() {
      _notes = list;
    });
 
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getNotes();

  }

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
 
        title: Text('Notes app'),
      ),
      body: ListView.builder( itemCount: _notes.length, itemBuilder: (context, index) {
        return ListTile(
          subtitle: Text(_notes[index]['description']),
          trailing: IconButton(
            onPressed: ()async {
               var db = await openDatabase('my_db.db');
               await db.delete('notes', where: 'id = ?', whereArgs: [_notes[index]['id']]);
               _getNotes();

            },
            icon: Icon(Icons.delete,color: Colors.redAccent,),
          ),
          
        );
      }, ) ,
            floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, new MaterialPageRoute(builder: (context) {
            return Body();
          },));
        },
        tooltip: 'Increment',), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}