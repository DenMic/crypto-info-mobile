import 'package:crypto_info/model/feed_model.dart';
import 'package:crypto_info/page/rss_feed/component/post_list.dart';
import 'package:crypto_info/page/rss_feed/component/post_all_feed.dart';
import 'package:crypto_info/common/component/header_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RssFeedPage extends StatefulWidget {
  final int idFeed;

  RssFeedPage({Key key, this.idFeed}) : super(key: key);

  @override
  _RssFeedPageState createState() => _RssFeedPageState(idFeed: idFeed);
}

class _RssFeedPageState extends State<RssFeedPage> {
  int idFeed;
  List<FeedModel> feeds;

  _RssFeedPageState({this.idFeed});

  void viewAllFeed() {
    setState(() {
      idFeed = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    FeedModel feed;

    return FutureBuilder(
      future:
          DefaultAssetBundle.of(context).loadString('assets/config/feeds.json'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Widget childWidget;

          feeds = FeedModel.parseListFeedModel(snapshot.data.toString());

          if (idFeed != -1) {
            feed = feeds.firstWhere((x) => x.id == idFeed);
            childWidget = PostList(feedModel: feed);
          } else {
            childWidget = PostAllFeedList(feedsModel: feeds);
          }

          // return childWidget;
          return SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 55.0),
                  child: childWidget,
                ),
                HeaderTitle(
                  title: AppLocalizations.of(context).rssFeed,
                  rightWidget: MaterialButton(
                    minWidth: 0,
                    height: 35,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    color: Colors.white,
                    shape: CircleBorder(),
                    onPressed: () => viewAllFeed(),
                    child: Text(
                      'All',
                      style: TextStyle(color: Colors.grey[700], fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
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
      },
    );
  }
}
