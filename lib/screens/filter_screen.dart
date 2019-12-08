import 'package:aws_whitepapers_guides/components/filter_chip_widget.dart';
import 'package:aws_whitepapers_guides/constants/filter_constants.dart';
import 'package:aws_whitepapers_guides/state/filter_state.dart';
import 'package:aws_whitepapers_guides/state/whitepaper_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  FilterScreen({Key key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    WhitepaperState whitepaperState = Provider.of<WhitepaperState>(context);
    FilterState filterState = Provider.of<FilterState>(context);
    return WillPopScope(
      onWillPop: () {
        whitepaperState.resetWhitepaperState();
        whitepaperState.fetchFilteredWhitepapers(
            filterState.typesFilterList,
            filterState.categoriesFilterList,
            filterState.industriesFilterList,
            filterState.productsFilterList);
        return Navigator.of(context).popAndPushNamed('/whiteppaersScreen');
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Select Filter'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.done_all),
              onPressed: () {
                whitepaperState.resetWhitepaperState();
                whitepaperState.fetchFilteredWhitepapers(
                    filterState.typesFilterList,
                    filterState.categoriesFilterList,
                    filterState.industriesFilterList,
                    filterState.productsFilterList);
                return Navigator.of(context)
                    .popAndPushNamed('/whiteppaersScreen');
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Consumer<FilterState>(
            builder: (context, filterBloc, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Types',
                    style: Theme.of(context)
                        .textTheme
                        .display1
                        .copyWith(fontWeight: FontWeight.bold)),
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
                Divider(
                  thickness: 2.0,
                  height: 32.0,
                ),
                //SizedBox(height: 8.0),
                Text('Categories',
                    style: Theme.of(context)
                        .textTheme
                        .display1
                        .copyWith(fontWeight: FontWeight.bold)),
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
                Divider(
                  thickness: 2.0,
                  height: 32.0,
                ),
                //SizedBox(height: 8.0),
                Text('Industries',
                    style: Theme.of(context)
                        .textTheme
                        .display1
                        .copyWith(fontWeight: FontWeight.bold)),
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
                Divider(
                  thickness: 2.0,
                  height: 32.0,
                ),
                //SizedBox(height: 8.0),
                Text('Products',
                    style: Theme.of(context)
                        .textTheme
                        .display1
                        .copyWith(fontWeight: FontWeight.bold)),
                SizedBox(height: 8.0),

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
      ),
    );
  }
}
