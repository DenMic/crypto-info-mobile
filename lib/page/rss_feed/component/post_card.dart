import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webfeed/webfeed.dart';

class PostCard extends StatefulWidget {
  final RssItem rssItem;

  PostCard({Key key, this.rssItem}) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    var urlImg = "";

    if (widget.rssItem.media.contents.length > 0) {
      var contentImg = widget.rssItem.media.contents
          .where((element) => element.medium == "image");

      if (contentImg.length > 0) {
        urlImg = contentImg.first.url;
      }
    } else if (widget.rssItem.content.images.length > 0) {
      urlImg = widget.rssItem.content.images.first;
    }

    return GestureDetector(
      onTap: () async {
        if (await canLaunch(widget.rssItem.link)) {
          await launch(widget.rssItem.link);
        } else {
          throw 'Could not launch ${widget.rssItem.link}';
        }
      },
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0)),
                  child: Image.network(urlImg,
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 15.0, left: 10.0, right: 10.0, bottom: 10.0),
                child: Text(
                  "${widget.rssItem.title}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              //   child: Divider(),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       FaIcon(
              //         FontAwesomeIcons.facebook,
              //         color: Colors.blue[700],
              //         size: 30,
              //       ),
              //       SizedBox(
              //         width: 20,
              //       ),
              //       FaIcon(
              //         FontAwesomeIcons.twitter,
              //         color: Colors.blue[200],
              //         size: 30,
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
