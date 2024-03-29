import 'dart:convert';
import 'package:aws_whitepapers_guides/models/index.dart';
import 'package:aws_whitepapers_guides/screens/pdf_view_screen.dart';
import 'package:aws_whitepapers_guides/services/download_service.dart';
import 'package:aws_whitepapers_guides/services/permission_service.dart';
import 'package:aws_whitepapers_guides/state/bookmark_state.dart';
import 'package:aws_whitepapers_guides/state/downloads_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class WhitepaperCard extends StatefulWidget {
  final WhitepaperData whitepaperData;
  final Function onBookmarkDeleteAnimation;
  final isBookmarkScreen;
  WhitepaperCard(
      {Key key,
      this.whitepaperData,
      this.onBookmarkDeleteAnimation,
      this.isBookmarkScreen = false})
      : super(key: key);

  @override
  _WhitepaperCardState createState() => _WhitepaperCardState();
}

class _WhitepaperCardState extends State<WhitepaperCard> {
  @override
  void initState() {
    super.initState();
    //FlutterDownloader.registerCallback((id, status, progress) {});
  }

  static Function downloadCallback = (id, status, int) {};

  @override
  Widget build(BuildContext context) {
    if (widget.whitepaperData.item.additionalFields.contentType ==
        "Reference Architecture Diagram")
      widget.whitepaperData.item.additionalFields.contentType =
          "Architecture Diagram";
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      margin: EdgeInsets.symmetric(vertical: 4.0),
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(widget.whitepaperData.item.additionalFields.docTitle,
                style: Theme.of(context).textTheme.headline),
            Divider(thickness: 2.0, height: 32.0),
            Text(
                widget.whitepaperData.item.additionalFields
                    .getDescriptionText(),
                style: Theme.of(context).textTheme.body1),
            SizedBox(height: 12.0),
            // Text(widget.whitepaperData.item.additionalFields
            //     .getIndustriesProductsTags()
            //     .join("|")),
            Wrap(
              spacing: 8.0,
              children: widget.whitepaperData.item.additionalFields
                  .getIndustriesProductsTags()
                  .map((item) => Chip(
                          label: Text(
                        item,
                        style: Theme.of(context)
                            .textTheme
                            .body1
                            .copyWith(fontSize: 12.0),
                      )))
                  .toList(),
            ),
            SizedBox(height: 8.0),
            Divider(thickness: 2.0, height: 12.0),
            //SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      '${widget.whitepaperData.item.additionalFields.contentType}',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    widget.whitepaperData.item.additionalFields.featureFlag !=
                            null
                        ? Text(
                            ' | ${widget.whitepaperData.item.additionalFields.featureFlag}',
                            style: Theme.of(context).textTheme.caption,
                          )
                        : SizedBox(width: 0),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Consumer<BookmarkState>(
                      builder: (_, bookmarkState, __) {
                        bool isBookmarked = bookmarkState.bookmarks
                            .contains(widget.whitepaperData.item.id);
                        return IconButton(
                          icon: widget.isBookmarkScreen
                              ? Icon(Icons.delete,
                                  color: Theme.of(context).primaryColor)
                              : isBookmarked
                                  ? Icon(Icons.bookmark,
                                      color: Theme.of(context).primaryColor)
                                  : Icon(Icons.bookmark_border,
                                      color: Theme.of(context).primaryColor),
                          onPressed: () {
                            if (isBookmarked) {
                              if (widget.onBookmarkDeleteAnimation != null) {
                                widget.onBookmarkDeleteAnimation();
                                bookmarkState.removeBookmark(
                                    widget.whitepaperData.item.id);
                                // NOTE: this needs to be called because the bookmark screen will still have the old bookmarks set items, calling getAllBookmarks will set the bookmarks object to the recent state and notify listeners
                                bookmarkState.getAllBookmarks();
                              } else {
                                bookmarkState.removeBookmark(
                                    widget.whitepaperData.item.id);
                              }
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
                          widget.whitepaperData.item.additionalFields.primaryURL
                                  .toLowerCase()
                                  .contains(".pdf")
                              ? Icons.picture_as_pdf
                              : Icons.open_in_browser,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: widget
                                .whitepaperData.item.additionalFields.primaryURL
                                .toLowerCase()
                                .contains('.pdf')
                            ? _navigateToPdfScreen
                            : _launchUrlForPrimaryWhitepaperLink),
                    Consumer<DownloadsState>(
                        builder: (context, downloadState, _) {
                      return IconButton(
                        icon: Icon(Icons.file_download,
                            color: Theme.of(context).primaryColor),
                        onPressed: () async {
                          await PermissionService.storagePermission();
                          DownloadService.downloadWhitepaper(
                              widget.whitepaperData);
                        },
                      );
                    }),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _navigateToPdfScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PdfViewScreen(currentWhitepaper: widget.whitepaperData);
    }));
  }

  _launchUrlForPrimaryWhitepaperLink() async {
    final url = widget.whitepaperData.item.additionalFields.primaryURL;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
