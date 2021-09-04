import 'package:flutter/material.dart';

class NotificationBloc extends StatelessWidget {
  final String title;
  final String text;
  final String heure;
  final bool vue;

  const NotificationBloc({Key key, this.title, this.text, this.vue, this.heure}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
              style: TextStyle( fontWeight: vue == false ? FontWeight.bold : FontWeight.normal ),
            ),
            Text(text,
              style: TextStyle( fontWeight: vue == false ? FontWeight.bold : FontWeight.normal ),
            ),
            Text(heure,
              style: TextStyle( fontWeight: vue == false ? FontWeight.bold : FontWeight.normal ),
            ),
          ],
        ),
        )
      )
    );
  }
}