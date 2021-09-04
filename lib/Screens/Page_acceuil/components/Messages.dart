
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Page_acceuil/components/ConnectedUser.dart';
import 'package:flutter_auth/Screens/Page_acceuil/page_acceuil.dart';
import 'package:flutter_auth/Screens/ajouterpost/ajouter_post.dart';


class MessagePage extends StatefulWidget {
  MessagePage({Key key}) : super(key: key);


  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
   int _selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
         
        currentIndex: _selectedIndex ,
         iconSize: 5,
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
            title: Text('ajouter un post')),
         
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

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 50,
              left: 15,
            ),
            height: 90,
            child: Text(
              'Chat',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          // section one connected users
          Container(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ConnectedUser(),
                ConnectedUser()
              ]
            ),
          ),
          // section two chat
          Container(
            height: h - (268),
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('John wick'),
                  subtitle: Text('last message from this user'),
                  trailing: Text('15:60'),
                  leading: Stack(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://www.pngarts.com/files/11/Avatar-PNG-Transparent-Image.png'),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                      ),
                      Positioned(
                        right: 0,
                        child: Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
