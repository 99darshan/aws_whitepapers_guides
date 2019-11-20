import 'package:aws_whitepapers_guides/components/filters_horizontal_list.dart';
import 'package:aws_whitepapers_guides/components/gradient_button.dart';
import 'package:aws_whitepapers_guides/constants/filter_constants.dart';
import 'package:aws_whitepapers_guides/state/filter_state.dart';
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
      appBar: AppBar(
        elevation: 0.0,
        //title: Text('Home'),
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.teal,
            child: IconButton(
              color: Colors.white,
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ),
          SizedBox(width: 16.0),
          CircleAvatar(
            backgroundColor: Colors.teal,
            child: IconButton(
              color: Colors.white,
              icon: Icon(Icons.collections_bookmark),
              onPressed: () {},
            ),
          ),
          SizedBox(width: 16.0),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("AWS Whitepapers & Guides ",
                style: Theme.of(context)
                    .textTheme
                    .display1
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.teal)),
            SizedBox(height: 16.0),
            GradientButton(
              buttonText: 'View All',
              onPressed: () async {
                // fetch all whitepapers
                await whitepaperState.initFetchWhitepapers();
                Navigator.pushReplacementNamed(context, '/whitepapersScreen');
              },
            ),
            SizedBox(height: 24.0),
            Text('Categories',
                style: Theme.of(context)
                    .textTheme
                    .display1
                    .copyWith(fontWeight: FontWeight.bold)),
            SizedBox(height: 16.0),
            FiltersHorizontalList(
              filterBy: FilterBy.Categories,
              filters: CategoriesFilter.categories,
            ),
            SizedBox(height: 16.0),
            Text('Types',
                style: Theme.of(context)
                    .textTheme
                    .display1
                    .copyWith(fontWeight: FontWeight.bold)),
            SizedBox(height: 16.0),
            FiltersHorizontalList(
              filters: TypesFilter.types,
              filterBy: FilterBy.Types,
            ),
            SizedBox(height: 16.0),
            Text('Products',
                style: Theme.of(context)
                    .textTheme
                    .display1
                    .copyWith(fontWeight: FontWeight.bold)),
            SizedBox(height: 16.0),
            FiltersHorizontalList(
              filters: ProductsFilter.products,
              filterBy: FilterBy.Products,
            ),
            SizedBox(height: 16.0),
            Text('Industries',
                style: Theme.of(context)
                    .textTheme
                    .display1
                    .copyWith(fontWeight: FontWeight.bold)),
            SizedBox(height: 16.0),
            FiltersHorizontalList(
              filters: IndustriesFilter.industries,
              filterBy: FilterBy.Industries,
            )
          ],
        ),
      ),
    );
  }
}
