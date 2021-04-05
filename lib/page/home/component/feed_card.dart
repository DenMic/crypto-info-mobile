import 'package:crypto_info/model/feed_model.dart';
import 'package:flutter/material.dart';

class FeedCard extends StatelessWidget {
  final FeedModel feedModel;
  final Function changePage;

  FeedCard({
    Key key,
    this.feedModel,
    this.changePage
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

          onTap: () => changePage(2, feedModel.id),

          child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
              width: 180,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(2, 2), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 80,
                      width: 180,
                      decoration: BoxDecoration(
                        color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0,
                              blurRadius: 3,
                              offset: Offset(0, 1)
                            )
                          ],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5)),
                          image: DecorationImage(
                              image: AssetImage(
                                  feedModel.image),
                              fit: BoxFit.cover)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        feedModel.title,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
                      child: Text(
                        feedModel.description,
                        // style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ])),
        ),
    );
  }
}