import 'package:admob_flutter/admob_flutter.dart';
import 'package:aws_whitepapers_guides/components/filters_horizontal_list.dart';
import 'package:aws_whitepapers_guides/constants/app_constants.dart';
import 'package:aws_whitepapers_guides/constants/filter_constants.dart';
import 'package:aws_whitepapers_guides/state/whitepaper_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isAdLoadingCompleted = false;
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
            // background: Image.network(
            //   "https://d1.awsstatic.com/webteam/homepage/heroes/backgrounds/Site-Merch_Blue_Pattern_06_Hero-BG.7d47bbb326ce6d8cf1fe024aed2f682d939ddf63.png",
            //   fit: BoxFit.fill,
            // ),
            title: Text("AWS Whitepapers"),
            centerTitle: false,
            titlePadding: EdgeInsets.only(left: 16.0, bottom: 16.0),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: EdgeInsets.only(left: 16.0, bottom: 16.0, top: 24.0),
              child: Text('Categories',
                  style: Theme.of(context)
                      .textTheme
                      .display1
                      .copyWith(fontWeight: FontWeight.bold)),
            ),
            FiltersHorizontalList(
              filterBy: FilterBy.Categories,
              filters: CategoriesFilter.categories,
              gradientStartColor: Colors.indigo,
              gradientEndColor: Colors.teal,
            ),
            SizedBox(height: 24.0),
            Stack(children: <Widget>[
              Align(
                child: AdmobBanner(
                  adUnitId: AppConstants.BANNER_AD_UNIT_ID,
                  adSize: AdmobBannerSize.LARGE_BANNER,
                  listener: (AdmobAdEvent event, Map<String, dynamic> args) {
                    // if (event == AdmobAdEvent.completed) {
                    // NOTE: the completed was never called
                    //   print('ad Loading completed');
                    //   setState(() {
                    //     _isAdLoadingCompleted = true;
                    //   });
                    // }
                    if (event == AdmobAdEvent.loaded) {
                      print('ad loaded...');
                      // IMPORTANT: NOTE: the set state method causes the ad to load multiple times so setState is wrapped if the if block
                      if (!_isAdLoadingCompleted) {
                        setState(() {
                          _isAdLoadingCompleted = true;
                        });
                      }
                    }
                  },
                ),
              ),
              !_isAdLoadingCompleted
                  ? Align(
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        backgroundColor:
                            Theme.of(context).accentColor.withAlpha(900),
                      ),
                    )
                  : SizedBox(height: 0.0),
            ]),
            Padding(
              padding: EdgeInsets.only(left: 16.0, bottom: 16.0, top: 24.0),
              child: Text('Types',
                  style: Theme.of(context)
                      .textTheme
                      .display1
                      .copyWith(fontWeight: FontWeight.bold)),
            ),
            FiltersHorizontalList(
              filters: TypesFilter.types,
              filterBy: FilterBy.Types,
              gradientStartColor: Colors.deepPurple,
              gradientEndColor: Colors.deepOrange,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0, bottom: 16.0, top: 24.0),
              child: Text('Products',
                  style: Theme.of(context)
                      .textTheme
                      .display1
                      .copyWith(fontWeight: FontWeight.bold)),
            ),
            FiltersHorizontalList(
              filters: ProductsFilter.products,
              filterBy: FilterBy.Products,
              gradientStartColor: Colors.indigo,
              gradientEndColor: Colors.teal,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0, bottom: 16.0, top: 24.0),
              child: Text('Industries',
                  style: Theme.of(context)
                      .textTheme
                      .display1
                      .copyWith(fontWeight: FontWeight.bold)),
            ),
            FiltersHorizontalList(
              filters: IndustriesFilter.industries,
              filterBy: FilterBy.Industries,
              gradientStartColor: Colors.deepPurple,
              gradientEndColor: Colors.deepOrange,
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
