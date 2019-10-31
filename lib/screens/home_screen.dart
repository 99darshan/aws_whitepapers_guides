import 'package:aws_whitepapers_guides/bloc/filter_bloc.dart';
import 'package:aws_whitepapers_guides/bloc/whitepaper_bloc.dart';
import 'package:aws_whitepapers_guides/components/base_widget.dart';
import 'package:aws_whitepapers_guides/components/whitepaper_card.dart';
import 'package:aws_whitepapers_guides/models/index.dart';
import 'package:aws_whitepapers_guides/screens/filter_screen.dart';
import 'package:aws_whitepapers_guides/services/aws_service.dart';
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
  RootAwsResponse awsResponse;
  List<String> types = List<String>();
  List<String> categories = List<String>();
  WhitepaperBloc whitepaperBloc;
  FilterBloc filterBloc;

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
    return Consumer<WhitepaperBloc>(builder: (context, whitepaperBloc, _) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Home'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => FilterScreen()));
                },
              )
            ],
          ),
          body: Container(
              child: whitepaperBloc.isFetchingData
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: whitepaperBloc.rootAwsResponse.items.length,
                      itemBuilder: (context, index) {
                        return WhitepaperCard(
                            whitepaperData:
                                whitepaperBloc.rootAwsResponse.items[index]);
                      },
                    )));
    });
  }
}
