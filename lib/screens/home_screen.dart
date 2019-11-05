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
    FilterState filterState = Provider.of<FilterState>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        //title: Text('Home'),
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.teal[200],
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ),
          SizedBox(width: 20.0),
          CircleAvatar(
            backgroundColor: Colors.teal[200],
            child: IconButton(
              icon: Icon(Icons.collections_bookmark),
              onPressed: () {},
            ),
          ),
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
            Text('Categories', style: Theme.of(context).textTheme.title),
            SizedBox(height: 16.0),
            SizedBox(
              height: 150.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: CategoriesFilter.categories.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      filterState.addFilter(CategoriesFilter.categories[index],
                          FilterBy.Categories);
                      await whitepaperState.fetchFilteredWhitepapers(
                          filterState.typesFilterList,
                          filterState.categoriesFilterList,
                          filterState.industriesFilterList,
                          filterState.productsFilterList);
                      Navigator.pushReplacementNamed(
                          context, '/whitepapersScreen');
                    },
                    child: Container(
                        width: 200.0, //TODO: check overflow??
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.teal, Colors.green]),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              CategoriesFilter.categories[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .subhead
                                  .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              color: Colors.greenAccent,
                              child: Text(
                                  '${index + 1} of ${CategoriesFilter.categories.length}'),
                            )
                          ],
                        )),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            Text('Types', style: Theme.of(context).textTheme.title),
            SizedBox(height: 16.0),
            SizedBox(
              height: 150.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: TypesFilter.types.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    //TODO: change splash color
                    onTap: () async {
                      filterState.addFilter(
                          TypesFilter.types[index], FilterBy.Categories);
                      await whitepaperState.fetchFilteredWhitepapers(
                          filterState.typesFilterList,
                          filterState.categoriesFilterList,
                          filterState.industriesFilterList,
                          filterState.productsFilterList);
                      Navigator.pushReplacementNamed(
                          context, '/whitepapersScreen');
                    },
                    child: Container(
                        width: 200.0, //TODO: check overflow??
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.purple, Colors.blue]),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              TypesFilter.types[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .subhead
                                  .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              color: Colors.purpleAccent,
                              child: Text(
                                  '${index + 1} of ${TypesFilter.types.length}'),
                            )
                          ],
                        )),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            Text('Products', style: Theme.of(context).textTheme.title),
            SizedBox(height: 16.0),
            FiltersHorizontalList(
              filters: ProductsFilter.products,
              filterBy: FilterBy.Products,
            )
          ],
        ),
      ),
    );
  }
}
