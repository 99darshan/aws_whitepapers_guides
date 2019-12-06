import 'dart:io';

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
            child: FutureBuilder(
              future: whitepaperState.rootAwsResponse,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return ShimmerList();
                } else {
                  if (snapshot.hasError) {
                    String errorAsset;
                    String errorMessage;
                    if (snapshot.error is SocketException) {
                      errorAsset = 'assets/svg/no_internet.svg';
                      errorMessage = "No Active Internet Connection Found !!";
                    } else {
                      errorAsset = 'assets/svg/unknown_error.svg';
                      errorMessage = "Error Fetching Whitepapers !!";
                    }
                    return ErrorAndInfoCard(
                      assetName: errorAsset,
                      label: Text(errorMessage,
                          style: Theme.of(context).textTheme.display1.copyWith(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    );
                  } else {
                    return snapshot.data.items.length > 0
                        ? ListView.builder(
                            itemCount: snapshot.data.items.length,
                            itemBuilder: (context, index) {
                              return WhitepaperCard(
                                  whitepaperData: snapshot.data.items[index]);
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
                          );
                  }
                }
              },
            ),
          ),
        ),
      );
    });
  }
}
