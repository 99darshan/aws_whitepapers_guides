import 'package:aws_whitepapers_guides/components/error_and_info_card.dart';
import 'package:aws_whitepapers_guides/components/shimmer_list.dart';
import 'package:aws_whitepapers_guides/components/whitepaper_card.dart';
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
      return WillPopScope(
        onWillPop: () {
          filterState.resetAllFilters();
          Navigator.of(context).pop('/');
          return;
        },
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/filterScreen');
            },
            child: Icon(
              Icons.filter_list,
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
          appBar: AppBar(
            title: Text('AWS Whitepapers'),
            actions: <Widget>[
              IconButton(
                //color: Colors.teal,
                icon: Icon(Icons.home),
                onPressed: () {
                  // reset all existing filters when navigating to home
                  filterState.resetAllFilters();
                  Navigator.of(context).pop('/');
                },
              )
            ],
          ),
          body: Container(
            color: Colors.grey[200],
            width: double.infinity,
            //padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: whitepaperState.isFetchingData
                ? ShimmerList()
                //? Center(child: CircularProgressIndicator())
                // TODO: Error on no network and unkown error
                // TODO: show no data widget if filtered result fetches no cards
                : whitepaperState.rootAwsResponse.items.length > 0
                    ? ListView.builder(
                        itemCount: whitepaperState.rootAwsResponse.items.length,
                        itemBuilder: (context, index) {
                          return WhitepaperCard(
                              whitepaperData:
                                  whitepaperState.rootAwsResponse.items[index]);
                        },
                      )
                    : ErrorAndInfoCard(
                        assetName: 'assets/svg/no_data.svg',
                        label: Text("No Whitepapers Found !!",
                            style: Theme.of(context)
                                .textTheme
                                .display1
                                .copyWith(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
                      ),
          ),
        ),
      );
    });
  }
}
