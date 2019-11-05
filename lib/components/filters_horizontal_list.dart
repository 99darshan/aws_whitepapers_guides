import 'package:aws_whitepapers_guides/constants/filter_constants.dart';
import 'package:aws_whitepapers_guides/state/filter_state.dart';
import 'package:aws_whitepapers_guides/state/whitepaper_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FiltersHorizontalList extends StatelessWidget {
  final List<String> filters;
  final FilterBy filterBy;
  const FiltersHorizontalList({Key key, this.filters, this.filterBy})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    FilterState filterState = Provider.of<FilterState>(context);
    WhitepaperState whitepaperState = Provider.of<WhitepaperState>(context);
    return SizedBox(
      height: 150.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          return InkWell(
            //TODO: change splash color
            onTap: () async {
              filterState.addFilter(filters[index], filterBy);
              await whitepaperState.fetchFilteredWhitepapers(
                  filterState.typesFilterList,
                  filterState.categoriesFilterList,
                  filterState.industriesFilterList,
                  filterState.productsFilterList);
              Navigator.pushReplacementNamed(context, '/whitepapersScreen');
            },
            child: Container(
                width: 210.0, //TODO: check overflow??
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.indigo, Colors.teal]),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      filters[index],
                      style: Theme.of(context).textTheme.subhead.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: EdgeInsets.all(4.0),
                      color: Colors.indigoAccent,
                      child: Text('${index + 1} of ${filters.length}'),
                    )
                  ],
                )),
          );
        },
      ),
    );
  }
}
