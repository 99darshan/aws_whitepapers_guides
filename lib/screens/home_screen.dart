import 'package:aws_whitepapers_guides/components/filters_horizontal_list.dart';
import 'package:aws_whitepapers_guides/constants/filters/filter_by.dart';
import 'package:aws_whitepapers_guides/constants/filters/business_categories.dart';
import 'package:aws_whitepapers_guides/constants/filters/content_types.dart';
import 'package:aws_whitepapers_guides/constants/filters/industries.dart';
import 'package:aws_whitepapers_guides/constants/filters/methodology.dart';
import 'package:aws_whitepapers_guides/constants/filters/technology_categories.dart';
import 'package:aws_whitepapers_guides/state/whitepaper_state.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          floating: true,
          pinned: true,
          expandedHeight: MediaQuery.of(context).size.height * 0.3,
          //centerTitle: false,
          //automaticallyImplyLeading: false,
          actions: <Widget>[
            ActionChip(
              avatar: Icon(
                Icons.view_list,
                color: Theme.of(context).primaryColor,
              ),
              backgroundColor: Theme.of(context).primaryColorLight,
              label: Text('View All',
                  style: Theme.of(context).textTheme.button.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                // fetch all whitepapers
                whitepaperState.initFetchWhitepapers();
                Navigator.of(context).pushNamed('/whitepapersScreen');
              },
            ),
            SizedBox(width: 8.0),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset('assets/img/aws_whitepapers_banner.png',
                fit: BoxFit.fill),
            title: Text("AWS Whitepapers"),
            centerTitle: false,
            titlePadding: EdgeInsets.only(left: 16.0, bottom: 16.0),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: EdgeInsets.only(left: 16.0, bottom: 16.0, top: 24.0),
              child: Text('Content Types',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontWeight: FontWeight.bold)),
            ),
            FiltersHorizontalList(
              filters: ContentTypes.all,
              filterBy: FilterBy.ContentTypes,
              gradientStartColor: Colors.deepPurple,
              gradientEndColor: Colors.deepOrange,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0, bottom: 16.0, top: 24.0),
              child: Text('Technology Categories',
                  style: Theme.of(context)
                      .textTheme
                      .display1
                      .copyWith(fontWeight: FontWeight.bold)),
            ),
            FiltersHorizontalList(
              filters: TechnologyCategories.all,
              filterBy: FilterBy.TechnologyCategories,
              gradientStartColor: Colors.indigo,
              gradientEndColor: Colors.teal,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0, bottom: 16.0, top: 24.0),
              child: Text('Industries',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontWeight: FontWeight.bold)),
            ),
            FiltersHorizontalList(
              filters: Industries.all,
              filterBy: FilterBy.Industries,
              gradientStartColor: Colors.deepPurple,
              gradientEndColor: Colors.deepOrange,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0, bottom: 16.0, top: 24.0),
              child: Text('Business Categories',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontWeight: FontWeight.bold)),
            ),
            FiltersHorizontalList(
              filters: BusinessCategories.all,
              filterBy: FilterBy.BusinessCategories,
              gradientStartColor: Colors.deepPurple,
              gradientEndColor: Colors.deepOrange,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0, bottom: 16.0, top: 24.0),
              child: Text('Methodology',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontWeight: FontWeight.bold)),
            ),
            FiltersHorizontalList(
              filterBy: FilterBy.Methodology,
              filters: Methodology.all,
              gradientStartColor: Colors.indigo,
              gradientEndColor: Colors.teal,
            ),
            SizedBox(
              height: 32.0,
            ),
          ]),
        ),
      ]),
    );
  }
}
