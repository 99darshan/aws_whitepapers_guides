import 'package:aws_whitepapers_guides/screens/bookmark_screen.dart';
import 'package:aws_whitepapers_guides/screens/downloads_screen.dart';
import 'package:aws_whitepapers_guides/screens/filter_screen.dart';
import 'package:aws_whitepapers_guides/screens/home_screen.dart';
import 'package:aws_whitepapers_guides/screens/search_screen.dart';
import 'package:aws_whitepapers_guides/screens/whitepapers_screen.dart';
import 'package:aws_whitepapers_guides/state/bookmark_state.dart';
import 'package:aws_whitepapers_guides/state/downloads_state.dart';
import 'package:aws_whitepapers_guides/state/filter_state.dart';
import 'package:aws_whitepapers_guides/state/whitepaper_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() async {
  await FlutterDownloader.initialize();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _screens = [
    HomeScreen(),
    //WhitepapersScreen(),
    SearchScreen(),
    BookmarkScreen(),
    DownloadsScreen()
  ];
  int _selectedScreenIndex = 0;
  @override
  Widget build(BuildContext context) {
    // Changes color of status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Theme.of(context).primaryColor,
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FilterState>(
          builder: (_) => new FilterState(),
        ),
        ChangeNotifierProvider<WhitepaperState>(
          builder: (_) => WhitepaperState(),
        ),
        ChangeNotifierProvider<BookmarkState>(
          builder: (_) => BookmarkState(),
        ),
        ChangeNotifierProvider<DownloadsState>(
          builder: (_) => DownloadsState(),
        ),
        //Provider.value(value: WhitepaperBloc())
      ],
      child: MaterialApp(
        title: 'Aws Whitepapers And Guides',
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.light,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.orange[600],
          // colorScheme: ColorScheme(
          //     primary: Colors.lightBlue[800],
          //     secondary: Colors.orange[600],
          //     onError: Colors.red),

          // Define the default font family.
          //fontFamily: 'Montserrat',

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: TextTheme(
              display1:
                  Theme.of(context).textTheme.display1.copyWith(fontSize: 24.0)
              //headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              //title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
              //body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
              ),
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SafeArea(
            child: _screens[_selectedScreenIndex],
          ),
          bottomNavigationBar: BottomNavigationBar(
              //fixedColor: Theme.of(context).primaryColor,
              //backgroundColor: Theme.of(context).accentColor,
              selectedItemColor: Colors.orange,
              //unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              currentIndex: _selectedScreenIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                setState(() {
                  _selectedScreenIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  title: Text('Home'),
                  icon: Icon(
                    Icons.home,
                  ),
                ),
                // BottomNavigationBarItem(
                //   title: Text('Whitepapers'),
                //   icon: Icon(
                //     Icons.receipt,
                //   ),
                // ),
                BottomNavigationBarItem(
                  title: Text('Search'),
                  icon: Icon(
                    Icons.search,
                  ),
                ),
                BottomNavigationBarItem(
                  title: Text('Bookmarks'),
                  icon: Icon(
                    Icons.collections_bookmark,
                  ),
                ),
                BottomNavigationBarItem(
                  title: Text('Downloads'),
                  icon: Icon(
                    Icons.file_download,
                  ),
                ),
              ]),
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
