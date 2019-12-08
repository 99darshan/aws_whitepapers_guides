import 'package:aws_whitepapers_guides/components/error_and_info_card.dart';
import 'package:aws_whitepapers_guides/screens/pdf_view_screen.dart';
import 'package:aws_whitepapers_guides/state/downloads_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DownloadsScreen extends StatelessWidget {
  final GlobalKey<AnimatedListState> _downloadsAnimatedListKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    DownloadsState downloadsState = Provider.of<DownloadsState>(context);
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Downloads'),
          actions: <Widget>[
            //NOTE: This button will refetch all downloaded files info,
            // if a file is current in progress of being downloaded it won't show up in the downloads screen
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  downloadsState.fetchAllDownloadedFilesName();
                }),
          ],
        ),
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: FutureBuilder(
              future: downloadsState.allDownloadedFilesName,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasError) {
                    // TODO: Error Card
                    return Text(snapshot.error.toString());
                  } else {
                    // TODO: show downloaded item is the count is zero
                    return snapshot.data.length > 0
                        ? AnimatedList(
                            key: _downloadsAnimatedListKey,
                            initialItemCount: snapshot.data.length,
                            itemBuilder: (context, index, animation) {
                              return _buildDownloadsListItem(context, index,
                                  snapshot.data[index], downloadsState);
                            },
                          )
                        : ErrorAndInfoCard(
                            assetName: 'assets/svg/no_downloads.svg',
                            label: Text(
                              "You haven't downloaded any files yet! \n Please press the refresh button above to fetch recent downloads. ",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .display1
                                  .copyWith(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                            ),
                          );
                  }
                }
              }),
        ),
      ),
    );
  }

  Widget _buildDownloadsListItem(context, index, item, downloadsState) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PdfViewScreen(
                  whitepaperFileName: item,
                )));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        margin: EdgeInsets.symmetric(vertical: 1.0),
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: null,
            title: Text(
              item,
              style: Theme.of(context).textTheme.subhead,
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                downloadsState.deleteFile(item);
                _downloadsAnimatedListKey.currentState.removeItem(index,
                    (context, animation) {
                  return FadeTransition(
                    opacity: CurvedAnimation(
                        curve: Curves.easeIn, parent: animation),
                    child: SizeTransition(
                      sizeFactor: CurvedAnimation(
                          parent: animation, curve: Curves.easeOutCubic),
                      child: _buildDownloadsListItem(
                          context, index, item, downloadsState),
                    ),
                  );
                }, duration: Duration(milliseconds: 1200));
              },
            ),
          ),
        ),
      ),
    );
  }
}
