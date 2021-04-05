import 'package:crypto_info/common/client/feed_client.dart';
import 'package:crypto_info/model/feed_model.dart';
import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'package:crypto_info/page/rss_feed/component/post_card.dart';

class PostList extends StatefulWidget {
  final FeedModel feedModel;

  PostList({Key key, this.feedModel}) : super(key: key);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RssFeed>(
        future: getFeedAsync(widget.feedModel.urlRss),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.items.length,
                itemBuilder: (context, index) {
                  return PostCard(rssItem: snapshot.data.items[index]);
                });
          } else if (snapshot.hasError) {
            throw snapshot.error;
          }

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                height: 50.0,
                width: 50.0,
              ),
            ),
          );
        });
  }
}
