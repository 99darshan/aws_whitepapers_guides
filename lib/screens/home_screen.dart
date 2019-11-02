import 'package:aws_whitepapers_guides/components/whitepaper_card.dart';
import 'package:aws_whitepapers_guides/state/whitepaper_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// TODO: when offline display from stored json or cache updated json
class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    //WhitepaperBloc whitepaperBloc = Provider.of<WhitepaperBloc>(context);
    return Consumer<WhitepaperState>(builder: (context, whitepaperState, _) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Home'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/filterScreen');
                },
              )
            ],
          ),
          body: Container(
              child: whitepaperState.isFetchingData
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: whitepaperState.rootAwsResponse.items.length,
                      itemBuilder: (context, index) {
                        return WhitepaperCard(
                            whitepaperData:
                                whitepaperState.rootAwsResponse.items[index]);
                      },
                    )));
    });
  }
}
