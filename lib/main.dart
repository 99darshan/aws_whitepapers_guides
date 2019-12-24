import 'package:admob_flutter/admob_flutter.dart';
import 'package:aws_whitepapers_guides/screens/bookmark_screen.dart';
import 'package:aws_whitepapers_guides/screens/downloads_screen.dart';
import 'package:aws_whitepapers_guides/screens/filter_screen.dart';
import 'package:aws_whitepapers_guides/screens/home_screen.dart';
import 'package:aws_whitepapers_guides/screens/search_screen.dart';
import 'package:aws_whitepapers_guides/screens/whitepapers_screen.dart';
import 'package:aws_whitepapers_guides/state/bookmark_state.dart';
import 'package:aws_whitepapers_guides/state/downloads_state.dart';
import 'package:aws_whitepapers_guides/state/filter_state.dart';
import 'package:aws_whitepapers_guides/state/search_state.dart';
import 'package:aws_whitepapers_guides/state/whitepaper_state.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() {
  // add this, and it should be the first line in main method
  // NOTE: ideally main shouldn't be waited, if flutter downloader is intialized with await add below line to avoid getting an exception
  WidgetsFlutterBinding.ensureInitialized();
  FlutterDownloader.initialize();
  Admob.initialize("np.com.a99darshan.aws_whitepapers_guides");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //final _pageController = PageController();
  final _screens = [
    HomeScreen(),
    SearchScreen(),
    BookmarkScreen(),
    DownloadsScreen()
  ];
  int _selectedScreenIndex = 0;
  @override
  Widget build(BuildContext context) {
    // Changes color of status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Color(0xff303F9F),
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FilterState>(
          create: (_) => new FilterState(),
        ),
        ChangeNotifierProvider<WhitepaperState>(
          create: (_) => WhitepaperState(),
        ),
        ChangeNotifierProvider<BookmarkState>(
          create: (_) => BookmarkState(),
        ),
        ChangeNotifierProvider<DownloadsState>(
          create: (_) => DownloadsState(),
        ),
        ChangeNotifierProvider<SearchState>(
          create: (_) => SearchState(),
        ),
        //Provider.value(value: WhitepaperBloc())
      ],
      child: MaterialApp(
        title: 'Aws Whitepapers And Guides',
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.light,
          primaryColor: Colors.indigo,
          primaryColorLight: Color(0xffC5CAE9),
          primaryColorDark: Color(0xff303F9F),
          accentColor: Colors.deepOrange,
          backgroundColor: Colors.grey[200],

          // colorScheme: ColorScheme(
          //     primary: Colors.lightBlue[800],
          //     secondary: Colors.orange[600],
          //     onError: Colors.red),

          // Define the default font family.
          //fontFamily: 'Montserrat',

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: TextTheme(
            display1: Theme.of(context).textTheme.display1.copyWith(
                fontSize: 24.0,
                fontFamily: 'GFSDidot',
                fontWeight: FontWeight.bold),
            headline: Theme.of(context).textTheme.headline.copyWith(
                fontSize: 20.0,
                fontFamily: 'GFSDidot',
                fontWeight: FontWeight.bold,
                color: Colors.black54),
            subhead: Theme.of(context).textTheme.subhead.copyWith(
                fontSize: 16.0,
                fontFamily: 'GFSDidot',
                color: Colors.black54,
                fontWeight: FontWeight.bold),
            title: Theme.of(context).textTheme.title.copyWith(
                  fontSize: 20.0,
                ),
            body1: Theme.of(context)
                .textTheme
                .body1
                .copyWith(fontSize: 16.0, color: Colors.grey[700]),

            //body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SafeArea(
            child: _screens[_selectedScreenIndex],
            // child: PageView(
            //   physics: AlwaysScrollableScrollPhysics(),
            //   controller: _pageController,
            //   onPageChanged: (index) {
            //     setState(() {
            //       _selectedScreenIndex = index;
            //     });
            //   },
            //   children: <Widget>[
            //     HomeScreen(),
            //     SearchScreen(),
            //     BookmarkScreen(),
            //     DownloadsScreen()
            //   ],
            // ),
          ),
          bottomNavigationBar: BottomNavyBar(
            backgroundColor: Colors.grey[200],
            selectedIndex: _selectedScreenIndex,
            //animationDuration: Duration(milliseconds: 300),
            onItemSelected: (index) {
              setState(() {
                _selectedScreenIndex = index;
                //_pageController.jumpToPage(index);
                // _pageController.animateToPage(index,
                //     curve: Curves.easeIn,
                //     duration: Duration(milliseconds: 300));
              });
            },
            //backgroundColor: Colors.white10,
            showElevation: true,
            items: [
              BottomNavyBarItem(
                  title: Text('Home'),
                  icon: Icon(Icons.home),
                  activeColor: Colors.deepOrange,
                  inactiveColor: Colors.blueGrey[400]),
              BottomNavyBarItem(
                  title: Text('Search'),
                  icon: Icon(
                    Icons.search,
                  ),
                  activeColor: Colors.deepOrange,
                  inactiveColor: Colors.blueGrey[400]),
              BottomNavyBarItem(
                  title: Text('Bookmarks'),
                  icon: Icon(Icons.collections_bookmark),
                  activeColor: Colors.deepOrange,
                  inactiveColor: Colors.blueGrey[400]),
              BottomNavyBarItem(
                  title: Text('Downloads'),
                  icon: Icon(Icons.file_download),
                  activeColor: Colors.deepOrange,
                  inactiveColor: Colors.blueGrey[400]),
            ],
          ),
        ),
        //initialRoute: '/',
        routes: {
          //'/': (context) => HomeScreen(),
          '/whitepapersScreen': (context) => WhitepapersScreen(),
          '/filterScreen': (context) => FilterScreen(),
          //'/bookmarkScreen': (context) => BookmarkScreen(),
          //'/downloadsScreen': (context) => DownloadsScreen()
          //'/pdfViewScreen': (context) => PdfViewScreen()
        },
      ),
    );
  }
}
