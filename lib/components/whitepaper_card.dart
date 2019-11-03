import 'dart:convert';
import 'package:aws_whitepapers_guides/models/index.dart';
import 'package:aws_whitepapers_guides/state/bookmark_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class WhitepaperCard extends StatefulWidget {
  final WhitepaperData whitepaperData;
  WhitepaperCard({Key key, this.whitepaperData}) : super(key: key);

  @override
  _WhitepaperCardState createState() => _WhitepaperCardState();
}

class _WhitepaperCardState extends State<WhitepaperCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red[
          200], // Card color vary based on whitepapers, guides and reference, use gardient
      child: Container(
        padding: EdgeInsets.all(16.0),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(widget.whitepaperData.item.additionalFields.docTitle,
                style: Theme.of(context).textTheme.headline),
            SizedBox(height: 8.0),
            Text(
              widget.whitepaperData.item.additionalFields.getDescriptionText(),
              style: Theme.of(context).textTheme.subhead,
            ),
            // TODO: Tags or Categories
            SizedBox(height: 16.0),
            Divider(
              height: 0.0,
              color: Colors.white,
            ),
            SizedBox(height: 8.0),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      // TODO: check for tags index, place method to retrieve content type, categories and industry with in the tag model or inside whitepaperData and hadle fail safe there
                      // index 1 doesn't guarantee content-type
                      // loop over the tags array and based on tagNamespaceId distinguish content-type, categories, flag, industries and products
                      Text(widget.whitepaperData.getContentType()),
                      SizedBox(width: 4.0),
                      Text('|'),
                      SizedBox(width: 4.0),
                      Text('New')
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Consumer<BookmarkState>(
                        builder: (_, bookmarkState, __) {
                          bool isBookmarked = bookmarkState.bookmarks
                              .contains(widget.whitepaperData.item.id);
                          return IconButton(
                            icon: isBookmarked
                                ? Icon(Icons.bookmark)
                                : Icon(Icons.bookmark_border),
                            onPressed: () {
                              if (isBookmarked) {
                                bookmarkState.removeBookmark(
                                    widget.whitepaperData.item.id);
                              } else {
                                bookmarkState.addBookmark(
                                    widget.whitepaperData.item.id,
                                    json.encode(
                                        widget.whitepaperData.toJson()));
                              }
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.file_download),
                        onPressed: () {},
                      ),
                      // IconButton(
                      //   icon: Icon(Icons.share),
                      //   onPressed: () {},
                      // ),
                      IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        onPressed: () {},
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
