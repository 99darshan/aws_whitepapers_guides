import 'dart:io';

import 'package:aws_whitepapers_guides/components/error_and_info_card.dart';
import 'package:aws_whitepapers_guides/components/load_more_button.dart';
import 'package:aws_whitepapers_guides/components/shimmer_list.dart';
import 'package:aws_whitepapers_guides/components/whitepaper_card.dart';
import 'package:aws_whitepapers_guides/models/index.dart';
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
      Future<bool> _willPopCallback() async {
        whitepaperState.resetWhitepaperState();
        filterState.resetAllFilters();
        return true;
      }

      return WillPopScope(
        onWillPop: _willPopCallback,
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
                  whitepaperState.resetWhitepaperState();
                  Navigator.of(context).pop('/');
                },
              )
            ],
          ),
          body: Container(
            color: Colors.grey[200],
            width: double.infinity,
            child: FutureBuilder(
              // NOTE: multiple futures to handle multiple page requests
              future: Future.wait(whitepaperState.rootAwsResponse),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return ShimmerList();
                } else {
                  if (snapshot.hasError) {
                    String errorAsset;
                    String errorMessage;
                    if (snapshot.error is SocketException) {
                      errorAsset = 'assets/svg/no_internet.svg';
                      errorMessage =
                          "No Active Internet Connection Found !! \n No worries though, you can view your downloaded whitepapers form the downlads tab !! ";
                    } else {
                      errorAsset = 'assets/svg/unknown_error.svg';
                      errorMessage = "Error Fetching Whitepapers !!";
                    }
                    return ErrorAndInfoCard(
                      assetName: errorAsset,
                      label: errorMessage,
                    );
                  } else {
                    // NOTE: snapshot.data is List<RootAwsResponse>
                    List<WhitepaperData> whitepaperData = [];
                    // update the has next page flag based on metadata of last RootAwsResponse
                    whitepaperState.updateHasNextPage(
                        snapshot.data[snapshot.data.length - 1].metadata);
                    snapshot.data.forEach((rootAwsResItem) {
                      // rootAWsResitem.items is itself a List<WhitepaperData>
                      rootAwsResItem.items
                          .forEach((wpData) => whitepaperData.add(wpData));
                    });

                    return whitepaperData.length > 0
                        ? ListView.builder(
                            // NOTE: the additional last item will either be a load more button or an empty sized box with height so the FAB won't hide the downloads icon on the last item
                            itemCount: whitepaperData.length + 1,

                            itemBuilder: (context, index) {
                              if (index == whitepaperData.length) {
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.25,
                                  ),
                                  child: whitepaperState.hasNextPage
                                      ? LoadMore(
                                          onPressed: () {
                                            whitepaperState.setPageNumber();
                                            whitepaperState.fetchFilteredWhitepapers(
                                                filterState.contentTypeFilters,
                                                filterState.methodologyFilters,
                                                filterState.industryFilters,
                                                filterState
                                                    .technologyCategoryFilters,
                                                filterState
                                                    .businessCategoryFilters);
                                          },
                                        )
                                      : SizedBox(
                                          height: 64.0,
                                        ),
                                );
                              } else {
                                return WhitepaperCard(
                                    whitepaperData: whitepaperData[index]);
                              }
                            },
                          )
                        : ErrorAndInfoCard(
                            assetName: 'assets/svg/no_data.svg',
                            label: "No Whitepapers Found !!",
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
