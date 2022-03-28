import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redditech/constants.dart';
import 'package:redditech/Screens/Accueil/navigation_drawer.dart';
import 'package:redditech/Components/postList.dart';

final GlobalKey<ScaffoldState> _key = GlobalKey();

class Body extends StatefulWidget {
  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<Body> {
  late Future<Redditor?> _infoProfile;
  String? _sortBy = "newest";

  @override

  void initState() {
    super.initState();
    _infoProfile = redditAuth.reddit!.user.me();
  }

  Widget build(BuildContext context) {
    var sidebarWidget = new SidebarWidget();
    return Scaffold(
      key: _key,
      drawer: sidebarWidget,
      body: PostList(_sortBy!),
      appBar: AppBar( // status bar color
          backgroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white),
          leading: FutureBuilder<Redditor?> (
            future: _infoProfile,
            builder: (BuildContext context, AsyncSnapshot<Redditor?> snapshot) {
              if (snapshot.hasData) {
                return IconButton(
                  icon: Image.network(snapshot.data!.data!['snoovatar_img'].toString().isNotEmpty ? snapshot.data!.data!['snoovatar_img'] : snapshot.data!.data!['icon_img']),
                  onPressed:() async {
                    sidebarWidget.loadInfoProfile(await redditAuth.reddit!.user.me());
                    _key.currentState!.openDrawer();
                  }
                );
              } else {
                return IconButton(
                  icon: Image.asset('assets/images/defaultavatar.png'),
                  onPressed: () {},
                );
              }
            },
          ),
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: CupertinoColors.extraLightBackgroundGray,
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        /* Clear the search field */
                      },
                    ),
                    hintText: "Rechercher",
                    border: InputBorder.none),
              ),
            ),
          ),
          actions: <Widget>[
            PopupMenuButton(
            child: Icon(Icons.filter_list, color: Colors.black54,),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Radio(
                      groupValue: _sortBy,
                      onChanged: (String? value) {
                        setState(() {
                          _sortBy = value;
                        });
                      },
                      value: "Newest",
                    ),
                    Text("Newest"),
                  ],
                ),
              ),
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Radio(
                      groupValue: _sortBy,
                      onChanged: (String? value) {
                        setState(() {
                          _sortBy = value;
                        });
                      },
                      value: "Hot",
                    ),
                    Text("Hot"),
                  ],
                ),
              ),
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Radio(
                      groupValue: _sortBy,
                      onChanged: (String? value) {
                        setState(() {
                          _sortBy= value;
                        });
                      },
                      value: "Top",
                    ),
                    Text("Top"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}