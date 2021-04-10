import 'package:flutter/material.dart';
import 'package:crypto_info/common/component/header_title.dart';
import 'package:crypto_info/model/feed_model.dart';
import 'package:crypto_info/page/home/component/feed_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FeedComponent extends StatefulWidget {
  final Function changePage;

  FeedComponent({Key key, this.changePage}) : super(key: key);

  @override
  _FeedComponentState createState() => _FeedComponentState();
}

class _FeedComponentState extends State<FeedComponent> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          DefaultAssetBundle.of(context).loadString('assets/config/feeds.json'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<FeedModel> feeds =
              FeedModel.parseListFeedModel(snapshot.data.toString());

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderTitle(
                title: AppLocalizations.of(context).news,
                rightWidget: null,
              ),
              Container(
                height: 280,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: feeds.length,
                    itemBuilder: (context, index) {
                      return FeedCard(
                          feedModel: feeds[index],
                          changePage: widget.changePage);
                    }),
              ),
            ],
          );
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
