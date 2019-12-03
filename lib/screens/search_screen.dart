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
  RootAwsResponse
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
            //autofocus: true,
            decoration: InputDecoration(
              hintText: 'Search Whitepapers',
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              focusColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
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
              print('searching...');
              setState(() {
                _searchText = value;
                _isSearching = true;
              });
              print('search text is $_searchText');
              await whitepaperState
                  .fetchWhitepapersBySearchKeywords(_searchText);
              searchState.updateRecentSearches(_searchText);

              setState(() {
                _isSearching = false;
                _searchResults = whitepaperState.searchAwsResponse;
              });
            },
          ),
        ),
      ),
      // TODO: recent searches and no result
      body: Container(
        color: Colors.grey[200],
        //padding: EdgeInsets.all(8.0),
        child: _isSearching
            ? ShimmerList()
            : _searchResults == null
                ? _recentSearches(context, searchState)
                : _searchResults.items.length > 0
                    ? ListView.builder(
                        shrinkWrap: false,
                        itemCount: _searchResults.items.length,
                        itemBuilder: (context, index) {
                          return WhitepaperCard(
                              whitepaperData: _searchResults.items[index]);
                        },
                      )
                    : Text("No results found"),
      ),
    );
  }

  Widget _recentSearches(BuildContext context, SearchState searchState) {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              "Recent Searches",
              style: Theme.of(context).textTheme.title,
            ),
          ),
          searchState.recentSearches.length > 0
              ? Expanded(
                  flex: 2,
                  child: ListView.builder(
                    itemCount: searchState.recentSearches.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.only(bottom: 1.0),
                        child: ListTile(
                          title: Text(searchState.recentSearches[index]),
                        ),
                      );
                    },
                  ))
              : SizedBox(width: 0.0)
        ],
      ),
    );
  }
}
