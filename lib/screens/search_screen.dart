import 'package:aws_whitepapers_guides/components/shimmer_list.dart';
import 'package:aws_whitepapers_guides/components/whitepaper_card.dart';
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
  bool _isSearchingCompleted = false;
  @override
  Widget build(BuildContext context) {
    WhitepaperState whitepaperState = Provider.of<WhitepaperState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(
              focusColor: Colors.white,
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(
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
              });
              print('search text is $_searchText');
              await whitepaperState
                  .fetchWhitepapersBySearchKeywords(_searchText);
              setState(() {
                _isSearchingCompleted = true;
              });
            },
          ),
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        //padding: EdgeInsets.all(8.0),
        child: whitepaperState.isFetchingData
            ? ShimmerList()
            : _isSearchingCompleted
                ? ListView.builder(
                    shrinkWrap: false,
                    itemCount: whitepaperState.searchAwsResponse.items.length,
                    itemBuilder: (context, index) {
                      return WhitepaperCard(
                          whitepaperData:
                              whitepaperState.searchAwsResponse.items[index]);
                    },
                  )
                : SizedBox(width: 0.0),
      ),
    );
  }
}
