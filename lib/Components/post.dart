import 'package:any_link_preview/any_link_preview.dart';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:redditech/constants.dart';

class Post extends StatelessWidget {
  Map<dynamic, dynamic>? _postJson;
  Map<dynamic, dynamic>? _subJson;

  Post(Submission postJson, Subreddit subJson) {
    _postJson = postJson.data;
    _subJson = subJson.data;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Card>[
        Card(
          clipBehavior: Clip.antiAlias,
          child: postTile(context: context, postJson: _postJson, subJson: _subJson)
        ),
      ]
    );
  }
}

Widget? postTile({
  required BuildContext context,
  required Map<dynamic, dynamic>? postJson,
  required Map<dynamic, dynamic>? subJson,
}) {
  return Column(
    children: [
      ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(subJson!["community_icon"].toString().isNotEmpty ? subJson["community_icon"].toString().substring(0, subJson["community_icon"].indexOf('?')) : subJson["icon_img"].toString()),
          backgroundColor: Colors.white,
        ),
        title: Text(postJson!['subreddit_name_prefixed'], style: TextStyle(fontFamily: 'Noto', fontWeight: FontWeight.w900, fontSize: 17)),
        subtitle: Text(
          "Publiée par u/" + postJson['author'] + ' • ' + timePost(postJson: postJson),
          style: TextStyle(color: Colors.black.withOpacity(0.6),
          fontFamily: 'Noto'),
        ),
        onTap: () {
          displayedSubJson = subJson;
          print(displayedSubJson);
          Navigator.of(context).pushNamed('/sub');
        },
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: new ListTile(
          title: Text(postJson['title'], style: TextStyle(fontFamily: 'Noto'),),
          subtitle: subTitlepost(text: postJson["post_hint"], postJson: postJson),
        ),
      ),
    ],
  );
}

String timePost({
  required Map<dynamic, dynamic>? postJson,
}) {
  String printH;
  var createdTime = new DateTime.fromMillisecondsSinceEpoch(postJson!["created_utc"].toInt() * 1000), agePost = DateTime.now().difference(createdTime);
  if (agePost.inDays >= 365) printH = (DateTime.now().difference(createdTime).inDays ~/ 365).toString() + 'ans';
  else if (agePost.inHours >= 24) printH = DateTime.now().difference(createdTime).inDays.toString() + 'd';
  else if (agePost.inHours != 0) printH = DateTime.now().difference(createdTime).inHours.toString() + 'h';
  else printH = DateTime.now().difference(createdTime).inMinutes.toString() + 'm';
  return printH;
}


Widget? subTitlepost({
  required String text,
  required Map<dynamic, dynamic>? postJson,
}) {
  var postHint;
  if (postJson!["post_hint"] == "image") postHint = Image.network(postJson["url"]);
  else if (postJson["post_hint"] == "self") postHint = Text(postJson["selftext"], style: TextStyle(fontFamily: 'Noto'));
  else if (postJson["post_hint"] == "link") postHint = AnyLinkPreview(
    link: postJson["url"],
    displayDirection: uiDirection.uiDirectionHorizontal,
    cache: Duration(hours: 1),
    backgroundColor: Colors.grey[300],
    errorWidget: Container(
      color: Colors.grey[300],
      child: Text('Oops!'),
    ),
  );
  return postHint;
}