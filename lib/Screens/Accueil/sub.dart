import 'package:flutter/material.dart';
import 'package:redditech/Components/widget.dart';

import '../../constants.dart';

class SubRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var urlBannerSub = displayedSubJson!['banner_background_image'].toString();
    if (urlBannerSub.isNotEmpty) urlBannerSub = urlBannerSub.substring(0, displayedSubJson!['banner_background_image'].toString().indexOf('?'));
    NetworkImage iconImage = new NetworkImage(displayedSubJson!["community_icon"].toString().isNotEmpty ? displayedSubJson!["community_icon"].toString().substring(0, displayedSubJson!["community_icon"].indexOf('?')) : displayedSubJson!["icon_img"].toString());
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              createBanner(background: urlBannerSub, avatar: iconImage),
              const SizedBox(height:25),
              templateTxt(text: displayedSubJson!['title'], sizeFont: 20, color: Colors.black),
              const SizedBox(height:25),
              templateTxt(text: displayedSubJson!['subscribers'].toString() + ' .membres', sizeFont: 15, color: Colors.black),
              const SizedBox(height:25),
              templateTxt(text: displayedSubJson!['public_description'], sizeFont: 12, color: Colors.black),
            ]
        )
      ),
    );
  }
}