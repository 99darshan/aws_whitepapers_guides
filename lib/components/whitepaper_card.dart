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
    return Container(
      //color: Colors.teal,
      margin: EdgeInsets.symmetric(vertical: 12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        //borderRadius: BorderRadius.only(topLeft: Radius.circular(4.0)),
        border: Border(
            top: BorderSide(color: Theme.of(context).primaryColor, width: 4.0),
            left: BorderSide(color: Theme.of(context).primaryColor, width: 4.0),
            right:
                BorderSide(color: Theme.of(context).primaryColor, width: 4.0),
            bottom:
                BorderSide(color: Theme.of(context).primaryColor, width: 8.0)),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black,
        //     blurRadius: 5.0,
        //   ),
        // ],
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget.whitepaperData.item.additionalFields.docTitle,
              style: Theme.of(context)
                  .textTheme
                  .headline
                  .copyWith(fontWeight: FontWeight.bold)),

          Divider(thickness: 2.0, height: 32.0),
          Text(widget.whitepaperData.item.additionalFields.getDescriptionText(),
              style: Theme.of(context).textTheme.subhead),
          // TODO: Tags or Categories
          // TODO: replace them with actual tags, dummy tags for now
          SizedBox(height: 12.0),
          Wrap(
            spacing: 8.0,
            children: <Widget>[
              ActionChip(label: Text("Compute"), onPressed: () {}),
              ActionChip(label: Text("IOT"), onPressed: () {}),
              ActionChip(label: Text("Storage"), onPressed: () {}),
              ActionChip(label: Text("Healthcare"), onPressed: () {})
            ],
          ),
          SizedBox(height: 8.0),
          Divider(thickness: 2.0, height: 12.0),
          //SizedBox(height: 8.0),
          // TODO: replace single child scroll view with a row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // TODO: Replace this row of texts with RichTexts
            children: <Widget>[
              RichText(
                // TODO: check for tags index, place method to retrieve content type, categories and industry with in the tag model or inside whitepaperData and hadle fail safe there
                // index 1 doesn't guarantee content-type
                // loop over the tags array and based on tagNamespaceId distinguish content-type, categories, flag, industries and products
                text: TextSpan(
                    text: '${widget.whitepaperData.getContentType()} | NEW',
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .copyWith(fontWeight: FontWeight.bold)),
              ),
              // Text(widget.whitepaperData.getContentType(),
              //     style: Theme.of(context)
              //         .textTheme
              //         .subhead
              //         .copyWith(fontWeight: FontWeight.bold)),
              // SizedBox(width: 4.0),
              // Text('|'),
              // SizedBox(width: 4.0),
              // Text(
              //   'New',
              //   style: Theme.of(context)
              //       .textTheme
              //       .subhead
              //       .copyWith(fontWeight: FontWeight.bold),
              // )),
              Row(
                children: <Widget>[
                  Consumer<BookmarkState>(
                    builder: (_, bookmarkState, __) {
                      bool isBookmarked = bookmarkState.bookmarks
                          .contains(widget.whitepaperData.item.id);
                      return IconButton(
                        icon: isBookmarked
                            ? Icon(Icons.bookmark,
                                color: Theme.of(context).primaryColor)
                            : Icon(Icons.bookmark_border,
                                color: Theme.of(context).primaryColor),
                        onPressed: () {
                          if (isBookmarked) {
                            bookmarkState
                                .removeBookmark(widget.whitepaperData.item.id);
                          } else {
                            bookmarkState.addBookmark(
                                widget.whitepaperData.item.id,
                                json.encode(widget.whitepaperData.toJson()));
                          }
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.file_download,
                        color: Theme.of(context).primaryColor),
                    onPressed: () {},
                  ),
                  // IconButton(
                  //   icon: Icon(Icons.share),
                  //   onPressed: () {},
                  // ),
                  IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {},
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
