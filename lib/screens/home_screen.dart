import 'package:aws_whitepapers_guides/components/gradient_button.dart';
import 'package:aws_whitepapers_guides/constants/filter_constants.dart';
import 'package:aws_whitepapers_guides/state/filter_state.dart';
import 'package:aws_whitepapers_guides/state/whitepaper_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    WhitepaperState whitepaperState = Provider.of<WhitepaperState>(context);
    FilterState filterState = Provider.of<FilterState>(context);
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0.0,
      //   //backgroundColor: Colors.transparent,
      // ),
      floatingActionButton: SpeedDial(
        // TODO: overlay colors
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            child: Icon(Icons.search),
            label: 'Search Whitepapers',
            onTap: () {},
          ),
          SpeedDialChild(
            child: Icon(Icons.bookmark),
            label: 'View Bookmarks',
            onTap: () {
              Navigator.pushNamed(context, '/bookmarkScreen');
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      // TODO: get this network image from local
                      image: NetworkImage(
                          'https://d1.awsstatic.com/webteam/homepage/heroes/backgrounds/Site-Merch_Blue_Pattern_06_Hero-BG.7d47bbb326ce6d8cf1fe024aed2f682d939ddf63.png'))),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "AWS Whitepapers & Guides ",
                    style: Theme.of(context)
                        .textTheme
                        .headline
                        .copyWith(color: Colors.white),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "Expand your knowledge of the cloud with AWS technical content authored by AWS and the AWS community, including technical whitepapers, technical guides, reference material, and reference architecture diagrams. ",
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .copyWith(color: Colors.white70),
                  ),
                  SizedBox(height: 16.0),
                  GradientButton(
                    buttonText: 'View All',
                    onPressed: () async {
                      // fetch all whitepapers
                      await whitepaperState.initFetchWhitepapers();
                      Navigator.pushReplacementNamed(
                          context, '/whitepapersScreen');
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Categories', style: Theme.of(context).textTheme.title),
                  SizedBox(height: 16.0),
                  ...CategoriesFilter.categories.map((item) => InkWell(
                        onTap: () async {
                          filterState.addFilter(item, FilterBy.Categories);
                          await whitepaperState.fetchFilteredWhitepapers(
                              filterState.typesFilterList,
                              filterState.categoriesFilterList,
                              filterState.industriesFilterList,
                              filterState.productsFilterList);
                          Navigator.pushReplacementNamed(
                              context, '/whitepapersScreen');
                        },
                        child: Card(
                          // TODO: add box decoration
                          child: Container(
                              decoration: BoxDecoration(
                                  // borderRadius:
                                  //     BorderRadius.all(Radius.circular(4.0)),
                                  border: Border(
                                      left: BorderSide(
                                          color: Colors.red, width: 4.0))),
                              padding: EdgeInsets.all(16.0),
                              child: Text(item)),
                        ),
                      ))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Types', style: Theme.of(context).textTheme.title),
                  SizedBox(height: 16.0),
                  ...TypesFilter.types.map((item) => InkWell(
                        onTap: () async {
                          filterState.addFilter(item, FilterBy.Types);
                          await whitepaperState.fetchFilteredWhitepapers(
                              filterState.typesFilterList,
                              filterState.categoriesFilterList,
                              filterState.industriesFilterList,
                              filterState.productsFilterList);
                          Navigator.pushReplacementNamed(
                              context, '/whitepapersScreen');
                        },
                        child: Card(
                          // TODO: add box decoration
                          child: Container(
                              padding: EdgeInsets.all(16.0), child: Text(item)),
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
