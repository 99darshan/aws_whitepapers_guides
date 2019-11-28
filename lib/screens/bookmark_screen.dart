import 'package:aws_whitepapers_guides/components/whitepaper_card.dart';
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

  @override
  Widget build(BuildContext context) {
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
      body: Consumer<BookmarkState>(
        builder: (context, bookmarkState, _) {
          return Container(
            padding: EdgeInsets.all(8.0),
            child: AnimatedList(
              key: _animationKey,
              initialItemCount: bookmarkState.bookmarks.length,
              itemBuilder: (context, index, animation) {
                return WhitepaperCard(
                    whitepaperData: bookmarkState.getBookmarkedItem(
                        bookmarkState.bookmarks.elementAt(index)),
                    onBookmarkDeleteAnimation: () {
                      _animationKey.currentState.removeItem(index,
                          (context, animation) {
                        return SlideTransition(
                            position: Tween<Offset>(
                                    begin: Offset(2.0, 0.0), end: Offset.zero)
                                .animate(animation),
                            child: WhitepaperCard(
                              whitepaperData: bookmarkState.getBookmarkedItem(
                                  bookmarkState.bookmarks.elementAt(index + 1)),
                            ));
                      }, duration: Duration(seconds: 1));
                    });
              },
            ),
            // child: ListView.builder(
            //   itemCount: bookmarkState.bookmarks.length,
            //   itemBuilder: (context, index) {
            //     return WhitepaperCard(
            //       whitepaperData: bookmarkState.getBookmarkedItem(
            //           bookmarkState.bookmarks.elementAt(index)),
            //     );
            //   },
            // ),
          );
        },
      ),
      // body: Container(
      //     child: FutureBuilder(
      //   future: BookmarkService.getAllKeys(),
      //   builder: (context, AsyncSnapshot<Set<String>> snapshot) {
      //     if (snapshot.hasData) {
      //       return ListView.builder(
      //         itemCount: snapshot.data.length,
      //         itemBuilder: (context, index) {
      //           return FutureBuilder(
      //             future: BookmarkService.getBookmarkedItem(
      //                 snapshot.data.elementAt(index)),
      //             builder: (_, itemSnapshot) {
      //               return itemSnapshot.connectionState == ConnectionState.done
      //                   ? WhitepaperCard(
      //                       whitepaperData: itemSnapshot.data,
      //                     )
      //                   : Container();
      //             },
      //           );
      //         },
      //       );
      //     } else {
      //       return Text('No Bookmarks found');
      //     }
      //   },
      // )),
    );
  }
}
