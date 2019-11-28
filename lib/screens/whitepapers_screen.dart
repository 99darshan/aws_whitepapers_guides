import 'package:aws_whitepapers_guides/components/whitepaper_card.dart';
import 'package:aws_whitepapers_guides/components/whitepapers_listview.dart';
import 'package:aws_whitepapers_guides/screens/filter_screen.dart';
import 'package:aws_whitepapers_guides/state/filter_state.dart';
import 'package:aws_whitepapers_guides/state/whitepaper_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// TODO: when offline display from stored json or cache updated json
class WhitepapersScreen extends StatefulWidget {
  WhitepapersScreen({Key key}) : super(key: key);

  @override
  _WhitepapersScreenState createState() => _WhitepapersScreenState();
}

class _WhitepapersScreenState extends State<WhitepapersScreen> {
  // TODO: fetch response using filters, sort option , new and update etc.
  @override
  void initState() {
    //awsResponse = AwsService.fetchWhitepapers(types);
    //WhitepaperBloc whitepaperBloc = Provider.of<WhitepaperBloc>(context);
    //filterBloc = Provider.of<FilterBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FilterState filterState = Provider.of<FilterState>(context);
    return Consumer<WhitepaperState>(builder: (context, whitepaperState, _) {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // reset all existing filters when navigating to home
              filterState.resetAllFilters();
              Navigator.pushReplacementNamed(context, '/');
            },
            child: Icon(
              Icons.home,
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
          appBar: AppBar(
            title: Text('AWS Whitepapers'),
            actions: <Widget>[
              IconButton(
                //color: Colors.teal,
                icon: Icon(Icons.search),
                onPressed: () {}, // TODO: implement search
              ),
              IconButton(
                //color: Colors.teal,
                icon: Icon(Icons.collections_bookmark),
                onPressed: () {
                  Navigator.pushNamed(context, '/bookmarkScreen');
                },
              ),
              IconButton(
                //color: Colors.teal,
                icon: Icon(Icons.filter_list),
                onPressed: () {
                  //Navigator.pushReplacementNamed(context, '/filterScreen');
                  Navigator.pushNamed(context, '/filterScreen');
                },
              )
            ],
          ),
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: whitepaperState.isFetchingData
                ? Center(child: CircularProgressIndicator())

                // TODO: show no data widget if filtered result fetches no cards
                : ListView.builder(
                    itemCount: whitepaperState.rootAwsResponse.items.length,
                    itemBuilder: (context, index) {
                      return WhitepaperCard(
                          whitepaperData:
                              whitepaperState.rootAwsResponse.items[index]);
                    },
                  ),
          ));
    });
  }
}
