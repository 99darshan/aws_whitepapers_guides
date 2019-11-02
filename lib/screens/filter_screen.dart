import 'package:aws_whitepapers_guides/components/filter_chip_widget.dart';
import 'package:aws_whitepapers_guides/constants/filter_constants.dart';
import 'package:aws_whitepapers_guides/state/filter_state.dart';
import 'package:aws_whitepapers_guides/state/whitepaper_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

// TODO: don't push filter_screen route, define route in main and use it, back button doesn't look intuitive
// TODO: use the filter bloc to store the filterTypes and filterCategories list and use that block to filter the items
// is the types and categories really necessary to be passed down the filter chip widget??? filter_bloc can be used maybe

class FilterScreen extends StatefulWidget {
  FilterScreen({Key key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: replace accessing with provider using consumer
    //FilterBloc filterBloc = Provider.of<FilterBloc>(context);
    WhitepaperState whitepaperState = Provider.of<WhitepaperState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Filter'),
        actions: <Widget>[
          Consumer<FilterState>(
            builder: (context, filterState, _) => IconButton(
              icon: Icon(Icons.done_all),
              onPressed: () {
                whitepaperState.fetchWhitepapers(filterState.typesFilterList);
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Consumer<FilterState>(
          builder: (context, filterBloc, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Types', style: Theme.of(context).textTheme.title),
              SizedBox(height: 8.0),
              // FILTER BY CONTENT TYPES
              Wrap(
                //alignment: WrapAlignment.center,
                spacing: 8.0,
                children: TypesFilter.types
                    .map((item) => FilterChipWidget(
                          labelText: item,
                          filterBy: FilterBy.Types,
                        ))
                    .toList(),
              ),
              SizedBox(height: 8.0),
              Text('Categories', style: Theme.of(context).textTheme.title),
              SizedBox(height: 8.0),
              // FILTER BY CATEGORIES
              Wrap(
                //alignment: WrapAlignment.center,
                spacing: 8.0,
                children: CategoriesFilter.categories
                    .map((item) => FilterChipWidget(
                          labelText: item,
                          filterBy: FilterBy.Categories,
                        ))
                    .toList(),
              ),
              SizedBox(height: 8.0),
              Text('Industries', style: Theme.of(context).textTheme.title),
              SizedBox(height: 8.0),
              // FILTER BY INDUSTRY
              Wrap(
                //alignment: WrapAlignment.center,
                spacing: 8.0,
                children: IndustriesFilter.industries
                    .map((item) => FilterChipWidget(
                          labelText: item,
                          filterBy: FilterBy.Industries,
                        ))
                    .toList(),
              ),
              SizedBox(height: 8.0),
              Text('Products', style: Theme.of(context).textTheme.title),
              Wrap(
                spacing: 8.0,
                children: ProductsFilter.products
                    .map((item) => FilterChipWidget(
                          labelText: item,
                          filterBy: FilterBy.Products,
                        ))
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
