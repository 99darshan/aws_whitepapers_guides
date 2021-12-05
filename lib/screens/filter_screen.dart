import 'package:aws_whitepapers_guides/components/filter_chip_widget.dart';
import 'package:aws_whitepapers_guides/constants/filters/filter_by.dart';
import 'package:aws_whitepapers_guides/constants/filters/business_categories.dart';
import 'package:aws_whitepapers_guides/constants/filters/content_types.dart';
import 'package:aws_whitepapers_guides/constants/filters/industries.dart';
import 'package:aws_whitepapers_guides/constants/filters/methodology.dart';
import 'package:aws_whitepapers_guides/constants/filters/technology_categories.dart';
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

    Future<bool> _onWillPopScopeCallback() async {
      whitepaperState.resetWhitepaperState();
      whitepaperState.fetchFilteredWhitepapers(
          filterState.contentTypeFilters,
          filterState.methodologyFilters,
          filterState.industryFilters,
          filterState.technologyCategoryFilters,
          filterState.businessCategoryFilters);
      return true;
    }

    return WillPopScope(
      onWillPop: _onWillPopScopeCallback,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Select Filter'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.done_all),
              onPressed: () {
                whitepaperState.resetWhitepaperState();
                whitepaperState.fetchFilteredWhitepapers(
                    filterState.contentTypeFilters,
                    filterState.methodologyFilters,
                    filterState.industryFilters,
                    filterState.technologyCategoryFilters,
                    filterState.businessCategoryFilters);
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
                Text('Content Types',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.bold)),
                SizedBox(height: 8.0),
                // FILTER BY CONTENT TYPES
                Wrap(
                  //alignment: WrapAlignment.center,
                  spacing: 8.0,
                  children: ContentTypes.all
                      .map((item) => FilterChipWidget(
                            labelText: item,
                            filterBy: FilterBy.ContentTypes,
                          ))
                      .toList(),
                ),
                Divider(
                  thickness: 2.0,
                  height: 32.0,
                ),
                //SizedBox(height: 8.0),
                Text('Methodology',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.bold)),
                SizedBox(height: 8.0),
                // FILTER BY CATEGORIES
                Wrap(
                  //alignment: WrapAlignment.center,
                  spacing: 8.0,
                  children: Methodology.all
                      .map((item) => FilterChipWidget(
                            labelText: item,
                            filterBy: FilterBy.Methodology,
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
                        .headline5
                        .copyWith(fontWeight: FontWeight.bold)),
                SizedBox(height: 8.0),
                // FILTER BY INDUSTRY
                Wrap(
                  //alignment: WrapAlignment.center,
                  spacing: 8.0,
                  children: Industries.all
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
                Text('Technology Categories',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.bold)),
                SizedBox(height: 8.0),

                Wrap(
                  spacing: 8.0,
                  children: TechnologyCategories.all
                      .map((item) => FilterChipWidget(
                            labelText: item,
                            filterBy: FilterBy.TechnologyCategories,
                          ))
                      .toList(),
                ),
                Divider(
                  thickness: 2.0,
                  height: 32.0,
                ),
                Text(
                  'Business Categories',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Wrap(
                  spacing: 8.0,
                  children: BusinessCategories.all
                      .map((item) => FilterChipWidget(
                          labelText: item,
                          filterBy: FilterBy.BusinessCategories))
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
