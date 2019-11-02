import 'package:aws_whitepapers_guides/components/filter_chip_widget.dart';
import 'package:aws_whitepapers_guides/constants/filter_constants.dart';
import 'package:aws_whitepapers_guides/state/filter_state.dart';
import 'package:aws_whitepapers_guides/state/whitepaper_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                Navigator.pop(context);
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
                children: <Widget>[
                  FilterChipWidget(
                    labelText: TypesFilter.whitepaper,
                    filterBy: FilterBy.Types,
                  ),
                  FilterChipWidget(
                    labelText: TypesFilter.technicalGuide,
                    filterBy: FilterBy.Types,
                  ),
                  FilterChipWidget(
                    labelText: TypesFilter.referenceMaterial,
                    filterBy: FilterBy.Types,
                  ),
                  FilterChipWidget(
                    labelText: TypesFilter.architectureDiagram,
                    filterBy: FilterBy.Types,
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Text('Categories', style: Theme.of(context).textTheme.title),
              SizedBox(height: 8.0),
              // FILTER BY CATEGORIES
              Wrap(
                //alignment: WrapAlignment.center,
                spacing: 8.0,
                children: <Widget>[
                  FilterChipWidget(labelText: 'Introduction to AWS'),
                  FilterChipWidget(labelText: 'Well-Architected Framework'),
                  FilterChipWidget(labelText: 'Cloud Adoptation Framework'),
                ],
              ),
              SizedBox(height: 8.0),
              Text('Industries', style: Theme.of(context).textTheme.title),
              SizedBox(height: 8.0),
              // FILTER BY INDUSTRY
              Wrap(
                //alignment: WrapAlignment.center,
                spacing: 8.0,
                children: <Widget>[
                  FilterChipWidget(labelText: 'Financial Services'),
                  FilterChipWidget(labelText: 'Government'),
                  FilterChipWidget(labelText: 'Healthcare'),
                  FilterChipWidget(labelText: 'Life Sciences'),
                  FilterChipWidget(labelText: 'Manufacturing'),
                  FilterChipWidget(labelText: 'Media & Entertainment'),
                  FilterChipWidget(labelText: 'Telecommunications'),
                  FilterChipWidget(labelText: 'Travel'),
                ],
              ),
              SizedBox(height: 8.0),
              Text('Products', style: Theme.of(context).textTheme.title),
              Wrap(
                spacing: 8.0,
                children: <Widget>[
                  FilterChipWidget(labelText: 'Analytics & Big Data'),
                  FilterChipWidget(labelText: 'Application Integration'),
                  FilterChipWidget(labelText: 'Compute'),
                  FilterChipWidget(labelText: 'Containers'),
                  FilterChipWidget(labelText: 'Cost Management'),
                  FilterChipWidget(labelText: 'Customer Engagement'),
                  FilterChipWidget(labelText: 'Databases'),
                  FilterChipWidget(labelText: 'Developer Tools'),
                  FilterChipWidget(labelText: 'End-User Computing'),
                  FilterChipWidget(labelText: 'Enterprise Applications'),
                  FilterChipWidget(labelText: 'Internet of Things (IOT)'),
                  FilterChipWidget(labelText: 'Machine Learning & AI'),
                  FilterChipWidget(labelText: 'Management & Governance'),
                  FilterChipWidget(labelText: 'Media Services'),
                  FilterChipWidget(labelText: 'Mobile'),
                  FilterChipWidget(labelText: 'Networking & Content Delivery'),
                  FilterChipWidget(
                      labelText: 'Security, Identity & Compliance'),
                  FilterChipWidget(labelText: 'Serverless'),
                  FilterChipWidget(labelText: 'Storage'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
