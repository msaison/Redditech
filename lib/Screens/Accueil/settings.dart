// ignore_for_file: must_be_immutable, unused_field

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:draw/draw.dart';

class SettingsRoute extends StatelessWidget {
  Redditor? _infoProfile;

  void loadInfoProfile(Redditor? infoProfile) {
    _infoProfile = infoProfile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Retour a l'accueil"),
      ),
      body: Center(
        child: Column(
          children: [
            ListTile(
            title: Text('Nom d\'affichage\n', style: TextStyle(fontFamily: 'Noto', fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),
            subtitle: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person, color: Colors.black,),
                  hintText: /*_infoProfile!.data!["subreddit"]['title'].toString()*/'',
                  border: OutlineInputBorder()),
            ),
            ),
            Divider(color: CupertinoColors.systemGrey,),
            ListTile(

            )
          ],
        ),
      ),
    );
  }
}