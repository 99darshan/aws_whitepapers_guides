import 'dart:io';

import 'package:aws_whitepapers_guides/components/error_and_info_card.dart';
import 'package:aws_whitepapers_guides/components/shimmer_list.dart';
import 'package:aws_whitepapers_guides/components/whitepaper_card.dart';
import 'package:aws_whitepapers_guides/models/index.dart';
import 'package:aws_whitepapers_guides/state/search_state.dart';
import 'package:aws_whitepapers_guides/state/whitepaper_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchText;
  bool _isSearching = false;
  Future<RootAwsResponse>
      _searchResults; // store and use the results in a local variable to clear the previous search actions
  @override
  Widget build(BuildContext context) {
    WhitepaperState whitepaperState = Provider.of<WhitepaperState>(context);
    SearchState searchState = Provider.of<SearchState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
            //initialValue: _searchText,
            // validator: (value) {
            //   return value.isEmpty ? 'Search term can not be empty !!' : null;
            // },
            //autofocus: true,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: 'Search Whitepapers',
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              focusColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                //borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              prefixIcon:
                  Icon(Icons.search, color: Theme.of(context).primaryColor),
            ),
            onFieldSubmitted: (value) async {
              await _onSearch(whitepaperState, searchState, value);
            },
          ),
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        width: double.infinity,
        child: _searchResults == null
            ? _recentSearches(context, whitepaperState, searchState)
            : FutureBuilder(
                future: _searchResults,
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
                            style: Theme.of(context)
                                .textTheme
                                .display1
                                .copyWith(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
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
                              assetName: 'assets/svg/no_search_items.svg',
                              label: Text("o results found for $_searchText!!",
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
    );
  }

  _onSearch(WhitepaperState whitepaperState, SearchState searchState,
      String value) async {
    print('searching...');
    setState(() {
      _searchText = value;
      _isSearching = true;
    });
    print('search text is $_searchText');
    await whitepaperState.fetchWhitepapersBySearchKeywords(_searchText);
    searchState.updateRecentSearches(_searchText);

    setState(() {
      _isSearching = false;
      _searchResults = whitepaperState.searchAwsResponse;
    });
  }

  Widget _recentSearches(BuildContext context, WhitepaperState whitepaperState,
      SearchState searchState) {
    return searchState.recentSearches.length > 0
        ? Container(
            //margin: EdgeInsets.only(top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Recent Searches",
                          style: Theme.of(context).textTheme.title,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.blueGrey,
                          ),
                          onPressed: () {
                            searchState.deleteAllRecentSearches();
                          },
                        ),
                      ]),
                ),
                Expanded(
                    flex: 2,
                    child: ListView.builder(
                      itemCount: searchState.recentSearches.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            _onSearch(whitepaperState, searchState,
                                searchState.recentSearches[index]);
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero),
                            margin: EdgeInsets.only(bottom: 1.0),
                            child: ListTile(
                              title: Text(searchState.recentSearches[index]),
                            ),
                          ),
                        );
                      },
                    ))
              ],
            ),
          )
        : ErrorAndInfoCard(
            assetName: 'assets/svg/no_search_items.svg',
            label: Text(
              "No Recent Searches! \n You can Start Searching For Whitepapers! ",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .display1
                  .copyWith(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          );
    // no recet searches widget
  }
}
