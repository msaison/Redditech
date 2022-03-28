import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:redditech/Components/post.dart';
import 'package:redditech/constants.dart';

class PostList extends StatefulWidget {
  final String sortBy;
  const PostList(this.sortBy);

  @override
  _PostListState createState() => _PostListState(sortBy);
}

class _PostListState extends State<PostList> {
  bool _firstLoadRunning = false;
  bool _loadMoreRunning = false;

  int _index_subs = 0;
  int _limit_subs = 10;
  List<Subreddit> _subs = [];

  List<int> _index_posts = [];
  int _limit_posts = 20;
  List _posts = [];

  late final String _sortBy;
  _PostListState(String sortBy) { this._sortBy = sortBy; }

  Future<List> _getSubscibedSubs() async {
    Map<String, String> params = {'count': _index_subs.toString()};
    final newSubs = await redditAuth.reddit!.user.subreddits(limit: _limit_subs, params: params).toList();

    _subs.addAll(newSubs);
    _index_subs += newSubs.length;
    newSubs.forEach((element) { _index_posts.add(0); });

    return (_subs);
  }

  Future<List> _getSubscibedSubsPosts() async {
    await _getSubscibedSubs();
    int index = 0;
    List newPosts = [];

    _subs.forEach((sub) async {
      Map<String, String> params = {'count': _index_posts[index].toString()};
      switch (_sortBy) {
        case "hot":
          newPosts = await sub.hot(limit: _limit_posts, params: params).toList(); break;
        case "top":
          newPosts = await sub.top(limit: _limit_posts, params: params).toList(); break;
        case "newest":
          newPosts = await sub.newest(limit: _limit_posts, params: params).toList(); break;
        default:
          newPosts = await sub.newest(limit: _limit_posts, params: params).toList(); break;
      }

      _posts.addAll(newPosts);
      _index_posts[index++] += newPosts.length;
    });

    await _subs.first.newest(limit: _limit_posts).toList();
    return (_posts);
  }

  void _firstLoad() async {
    setState(() {
      _firstLoadRunning = true;
    });
    try {
      await _getSubscibedSubsPosts();

      switch (_sortBy) {
        case "hot":
          _posts.sort((a, b) => b.data["score"].toInt().compareTo(a.data["score"].toInt())); break;
        case "top":
          _posts.sort((a, b) => b.data["score"].toInt().compareTo(a.data["score"].toInt())); break;
        case "newest":
          _posts.sort((a, b) => b.data["created_utc"].toInt().compareTo(a.data["created_utc"].toInt())); break;
        default:
          _posts.sort((a, b) => b.data["created_utc"].toInt().compareTo(a.data["created_utc"].toInt())); break;
      }

      setState(() {});
    } catch (err) {
      print('Something went wrong');
    }

    setState(() {
      _firstLoadRunning = false;
    });
  }

  void _loadMore() async {
    if (_firstLoadRunning == false &&
        _loadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _loadMoreRunning = true;
      });
      try {
        await _getSubscibedSubsPosts();

        switch (_sortBy) {
          case "hot":
            _posts.sort((a, b) => b.data["score"].toInt().compareTo(a.data["score"].toInt())); break;
          case "top":
            _posts.sort((a, b) => b.data["score"].toInt().compareTo(a.data["score"].toInt())); break;
          case "newest":
            _posts.sort((a, b) => b.data["created_utc"].toInt().compareTo(a.data["created_utc"].toInt())); break;
          default:
            _posts.sort((a, b) => b.data["created_utc"].toInt().compareTo(a.data["created_utc"].toInt())); break;
        }

        setState(() {});
      } catch (err) {
        print('Something went wrong!');
      }

      setState(() {
        _loadMoreRunning = false;
      });
    }
  }

  // The controller for the ListView
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = new ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _firstLoadRunning
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount: _posts.length,
                itemBuilder: (_, index) =>
                    Post(_posts[index], _subs.where((element) => element.data!['display_name'] == _posts[index].data['subreddit']).first)
            ),
          ),

          if (_loadMoreRunning)
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 40),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}