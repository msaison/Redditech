import 'package:flutter/cupertino.dart';
import 'package:redditech/Components/rounded_button.dart';
import 'package:redditech/Components/widget.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:redditech/Screens/Accueil/settings.dart';
import 'package:redditech/constants.dart';

class SidebarWidget extends StatelessWidget {
  late Redditor? _infoProfile;

  void loadInfoProfile(Redditor? infoProfile) {
    _infoProfile = infoProfile;
  }

  @override
  Widget build(BuildContext context) {
    var settingsRoute = SettingsRoute();
    var nowTime = new DateTime.now();
    var createdTime = new DateTime.fromMillisecondsSinceEpoch(_infoProfile!.data!['created'].toInt() * 1000);
    var ageReddit = nowTime.difference(createdTime);
    var avatarImage = new NetworkImage(_infoProfile!.data!['snoovatar_img'].toString().isNotEmpty ? _infoProfile!.data!['snoovatar_img'] : _infoProfile!.data!['icon_img'],scale: 0.5);
    final urlBannerprofile = _infoProfile!.data!["subreddit"]['banner_img'].toString().substring(0, _infoProfile!.data!["subreddit"]['banner_img'].toString().indexOf('?'));
    return Drawer(
      child: Material(
        color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              createHeader(background: urlBannerprofile, avatar: avatarImage),
              const SizedBox(height:25),
              templateTxt(text: _infoProfile!.data!["subreddit"]['title'], sizeFont: 15, color: Colors.black),
              templateTxt(text: "u/" + _infoProfile!.data!["name"], sizeFont: 11, color: Colors.grey),
              templateTxt(text: _infoProfile!.data!["subreddit"]['public_description'], sizeFont: 11, color: Colors.grey),
              const SizedBox(height: 15),
              Divider(color: CupertinoColors.separator),
              const SizedBox(height: 25),
              templateMenuItem(text: 'Abonné(e)', icon: Icons.account_circle_outlined, secondtext: _infoProfile!.data!['num_friends'].toString()),
              templateMenuItem(text: 'Karma', icon: Icons.kayaking, secondtext: _infoProfile!.data!['total_karma'].toString()),
              templateMenuItem(text: 'Age Reddit', icon: Icons.cake_rounded, secondtext: ageReddit.inDays.toString() + 'j'),
              const SizedBox(height: 60),
              RoundedButton (text: "Paramètres", textColor: PrimaryLightColor, color: CupertinoColors.activeBlue,
                press:() {
                  settingsRoute.loadInfoProfile(_infoProfile);
                  Navigator.of(context).pushNamed('/settings');
                }
              ),
              Divider(color: CupertinoColors.systemGrey),
              RoundedButton (text: "Logout", textColor: PrimaryLightColor, color: CupertinoColors.destructiveRed,
                press: () {
                  redditAuth.logout();
                  Navigator.of(context).pushReplacementNamed('/');
                },
              ),
          ],
        ),
      )
    );
  }
}

