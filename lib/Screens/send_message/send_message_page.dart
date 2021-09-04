import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SendMessage extends StatefulWidget {
  final String uid;
  final String fullname;
  
  SendMessage({Key key, this.uid, this.fullname}) : super(key: key);

  @override
  _SendMessageState createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {

  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _messageCtrl = new TextEditingController();

  String _message = "";


  _sendMessage(){
    if (_message != '') {
      _db.collection('messages').add({
        'destination':widget.uid,
        'sender':_auth.currentUser.uid,
        "message":_message.trim(),
        "vue":false,
        'date': new DateTime.now()

      }).then((value) {
        _messageCtrl.text="";
        setState(() {
          _message="";

        });


      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.send),
            onPressed: (){
              _sendMessage();
            },
          )
        ],
      ),
      body :Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('To : ${widget.fullname}',style: TextStyle(fontSize: 25),),
            Container(height: 25,),
            Text('Message :',style: TextStyle(fontSize: 18),),
            Container(height: 15,),
            TextField(
              controller: _messageCtrl,
              onChanged: (v){
                setState(() {
                  _message = v;
                });
              },
              maxLines: 8,
              decoration: InputDecoration(
                hintText: "votre message...",
                
                border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(4.0)))
              ),
            )
          ],
        ),
      )
    );
  }
}