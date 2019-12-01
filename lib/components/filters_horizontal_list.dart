import 'package:aws_whitepapers_guides/constants/filter_constants.dart';
import 'package:aws_whitepapers_guides/state/filter_state.dart';
import 'package:aws_whitepapers_guides/state/whitepaper_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FiltersHorizontalList extends StatelessWidget {
  final List<String> filters;
  final FilterBy filterBy;
  final Color gradientStartColor;
  final Color gradientEndColor;
  const FiltersHorizontalList(
      {Key key,
      this.filters,
      this.filterBy,
      this.gradientStartColor,
      this.gradientEndColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    FilterState filterState = Provider.of<FilterState>(context);
    WhitepaperState whitepaperState = Provider.of<WhitepaperState>(context);
    return SizedBox(
      height: 150.0,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          return InkWell(
            //TODO: change splash color
            onTap: () {
              filterState.addFilter(filters[index], filterBy);
              whitepaperState.fetchFilteredWhitepapers(
                  filterState.typesFilterList,
                  filterState.categoriesFilterList,
                  filterState.industriesFilterList,
                  filterState.productsFilterList);
              Navigator.of(context).pushReplacementNamed('/whitepapersScreen');
            },
            child: Container(
                width: 280.0, //TODO: check overflow??
                margin: EdgeInsets.only(right: 16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [this.gradientStartColor, this.gradientEndColor]),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      filters[index],
                      style: Theme.of(context)
                          .textTheme
                          .headline
                          .copyWith(color: Colors.white),
                    ),
                    Container(
                      //margin: EdgeInsets.only(top: 4.0),
                      padding: EdgeInsets.all(4.0),
                      //color: this.gradientEndColor,
                      child: Text(
                        '${index + 1} of ${filters.length}',
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Colors.white),
                      ),
                    )
                  ],
                )),
          );
        },
      ),
    );
  }
}
