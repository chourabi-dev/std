import 'package:flutter/material.dart';

class ConnectedUser extends StatelessWidget {
  const ConnectedUser({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(right: 20),
        height: 100,
        width: 100,
        child: Stack(
          children: [

            Container(
              height: 95,
              width: 95,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://www.pngarts.com/files/11/Avatar-PNG-Transparent-Image.png'),
              ),
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
            ),

            Positioned(
              right: 0,

              child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.all(Radius.circular(50))),
               
            ),)
          ],
        ));
  }
}
