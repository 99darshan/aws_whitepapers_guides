import 'package:aws_whitepapers_guides/screens/bookmark_screen.dart';
import 'package:aws_whitepapers_guides/screens/filter_screen.dart';
import 'package:aws_whitepapers_guides/screens/home_screen.dart';
import 'package:aws_whitepapers_guides/screens/pdf_view_screen.dart';
import 'package:aws_whitepapers_guides/screens/whitepapers_screen.dart';
import 'package:aws_whitepapers_guides/state/bookmark_state.dart';
import 'package:aws_whitepapers_guides/state/filter_state.dart';
import 'package:aws_whitepapers_guides/state/whitepaper_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';

void main() async {
  await FlutterDownloader.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
        )
        //Provider.value(value: WhitepaperBloc())
      ],
      child: MaterialApp(
        title: 'Aws Whitepapers And Guides',
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.light,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.orange[600],

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
        //home: HomeScreen(),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/whitepapersScreen': (context) => WhitepapersScreen(),
          '/filterScreen': (context) => FilterScreen(),
          '/bookmarkScreen': (context) => BookmarkScreen(),
          //'/pdfViewScreen': (context) => PdfViewScreen()
        },
      ),
    );
  }
}
