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
      body: Consumer<BookmarkState>(
        builder: (context, bookmarkState, _) {
          return Container(
            padding: EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: bookmarkState.bookmarks.length,
              itemBuilder: (context, index) {
                return WhitepaperCard(
                  whitepaperData: bookmarkState.getBookmarkedItem(
                      bookmarkState.bookmarks.elementAt(index)),
                );
              },
            ),
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
