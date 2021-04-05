import 'package:crypto_info/model/feed_model.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

Future<RssFeed> getFeedAsync(String targetUrl) async =>
    http.get(Uri.parse(targetUrl)).then((value) {
      return RssFeed.parse(value.body);
    });

Future<List<RssItem>> getAllRssItemAsync(Iterable<FeedModel> feedsModel) async {
  List<RssItem> rssItems =[];

  for (var feed in feedsModel) {
    var rssFeed = await http.get(Uri.parse(feed.urlRss)).then((value) {
      return RssFeed.parse(value.body);
    });

    rssItems.addAll(rssFeed.items.take(3));
  }

  return rssItems;
}
