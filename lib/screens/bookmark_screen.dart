import 'package:aws_whitepapers_guides/components/error_and_info_card.dart';
import 'package:aws_whitepapers_guides/components/whitepaper_card.dart';
import 'package:aws_whitepapers_guides/models/whitepaperData.dart';
import 'package:aws_whitepapers_guides/state/bookmark_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookmarkScreen extends StatefulWidget {
  BookmarkScreen({Key key}) : super(key: key);

  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  final GlobalKey<AnimatedListState> _animationKey = GlobalKey();

  Widget _buildItem(WhitepaperData whitepaperData, int index) {
    return WhitepaperCard(
        isBookmarkScreen: true,
        whitepaperData: whitepaperData,
        onBookmarkDeleteAnimation: () {
          _animationKey.currentState.removeItem(index, (context, animation) {
            return FadeTransition(
              opacity: CurvedAnimation(curve: Curves.easeIn, parent: animation),
              child: SlideTransition(
                  position:
                      Tween<Offset>(begin: Offset(2.0, 0.0), end: Offset.zero)
                          .animate(animation),
                  child: _buildItem(whitepaperData, index)),
            );
          }, duration: Duration(milliseconds: 500));
        });
  }

  @override
  Widget build(BuildContext context) {
    BookmarkState bookmarkState = Provider.of<BookmarkState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
        // actions: <Widget>[
        //   //TODO: search through bookmarks
        //   IconButton(
        //     icon: Icon(Icons.search),
        //     onPressed: () {},
        //   ),
        // ],
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        width: double.infinity,
        //padding: EdgeInsets.all(8.0),
        child: bookmarkState.bookmarks.length > 0
            ? AnimatedList(
                key: _animationKey,
                //reverse: true,
                initialItemCount: bookmarkState.bookmarks.length,
                itemBuilder: (context, index, animation) {
                  return _buildItem(
                      bookmarkState.getBookmarkedItem(
                          bookmarkState.bookmarks.elementAt(index)),
                      index);
                },
              )
            : ErrorAndInfoCard(
                assetName: 'assets/svg/no_bookmarks.svg',
                label: "You haven't bookmarked any whitepapers yet !!",
              ),
      ),
    );
  }
}
