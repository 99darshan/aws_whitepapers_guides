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
        whitepaperData: whitepaperData,
        onBookmarkDeleteAnimation: () {
          _animationKey.currentState.removeItem(index, (context, animation) {
            return SlideTransition(
                position:
                    Tween<Offset>(begin: Offset(2.0, 0.0), end: Offset.zero)
                        .animate(animation),
                child: _buildItem(whitepaperData, index));
          }, duration: Duration(milliseconds: 500));
        });
  }

  @override
  Widget build(BuildContext context) {
    BookmarkState bookmarkState = Provider.of<BookmarkState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
        actions: <Widget>[
          //TODO: search through bookmarks
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      // TODO: if no bookmarked items exists
      body: Container(
        color: Colors.grey[200],
        //padding: EdgeInsets.all(8.0),
        child: bookmarkState.bookmarks.length > 0
            ? AnimatedList(
                key: _animationKey,
                initialItemCount: bookmarkState.bookmarks.length,
                itemBuilder: (context, index, animation) {
                  return _buildItem(
                      bookmarkState.getBookmarkedItem(
                          bookmarkState.bookmarks.elementAt(index)),
                      index);
                },
              )
            : Text("no bookmarks found"),
      ),
    );
  }
}
