import 'package:crypto_info/common/client/feed_client.dart';
import 'package:crypto_info/model/feed_model.dart';
import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'package:crypto_info/page/rss_feed/component/post_card.dart';

class PostAllFeedList extends StatefulWidget {
  final Iterable<FeedModel> feedsModel;

  PostAllFeedList({Key key, this.feedsModel}) : super(key: key);

  @override
  _PostAllFeedListState createState() => _PostAllFeedListState();
}

class _PostAllFeedListState extends State<PostAllFeedList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RssItem>>(
      future: getAllRssItemAsync(widget.feedsModel),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return PostCard(rssItem: snapshot.data[index]);
            }
          );
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
      }
    );
  }

}