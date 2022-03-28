import 'package:flutter/material.dart';

Widget createHeader({
  required String background,
  required NetworkImage avatar,
}) {
  return DrawerHeader(
    padding: EdgeInsets.symmetric(horizontal: 30),
    margin: EdgeInsets.zero,
    decoration: BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.fill,
        image:  NetworkImage(background))),
        child: CircleAvatar(
          backgroundImage: avatar,
          backgroundColor: Colors.white70,
        )
    );
}

Widget createBanner({
  required String background,
  required NetworkImage avatar,
}) {
  if (background.isNotEmpty) {
    return DrawerHeader(
        padding: EdgeInsets.symmetric(horizontal: 30),
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(background))),
        child: CircleAvatar(
          backgroundImage: avatar,
          backgroundColor: Colors.white70,
        )
    );
  } else {
    return DrawerHeader(
        padding: EdgeInsets.symmetric(horizontal: 30),
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage("https://i2.wp.com/squarepictures.tv/wp-content/uploads/2019/01/other-Blue-banner.jpg?ssl=1"))),
        child: CircleAvatar(
          backgroundImage: avatar,
          backgroundColor: Colors.white70,
        )
    );
  }
}

Widget templateMenuItem({
  required String text,
  required IconData icon,
  required String secondtext,
}) {
  final color = Colors.black;
  return ListTile(
    leading:  Icon(icon, color: color),
    title: Text(text, style: TextStyle(
      color: color,
      fontFamily: 'IBMPlex',
      ),
    ),
    subtitle: Text(secondtext,
      style: TextStyle(
        fontFamily: 'IBMPlex',
      ),
    ),
    hoverColor: Colors.white70,
    onTap: () {},
  );
}

Text templateTxt({
  required String text,
  required double sizeFont,
  required Color color,
}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
    fontSize: sizeFont,
    fontFamily: 'Noto',
    fontWeight: FontWeight.w300,
    color: color
    ),
  );
}