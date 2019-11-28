import 'dart:convert';
import 'package:aws_whitepapers_guides/models/index.dart';
import 'package:aws_whitepapers_guides/screens/pdf_view_screen.dart';
import 'package:aws_whitepapers_guides/services/download_service.dart';
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
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: '${widget.whitepaperData.item.name}',
              child: Text(widget.whitepaperData.item.additionalFields.docTitle,
                  style: Theme.of(context)
                      .textTheme
                      .headline
                      .copyWith(fontWeight: FontWeight.bold)),
            ),

            Divider(thickness: 2.0, height: 32.0),
            Text(
                widget.whitepaperData.item.additionalFields
                    .getDescriptionText(),
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
                              bookmarkState.removeBookmark(
                                  widget.whitepaperData.item.id);
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
                      icon: Icon(
                        Icons.picture_as_pdf,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return PdfViewScreen(
                              currentWhitepaper: widget.whitepaperData);
                        }));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.file_download,
                          color: Theme.of(context).primaryColor),
                      onPressed: () {
                        DownloadService.downloadWhitepaper(
                            widget.whitepaperData);
                      },
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
