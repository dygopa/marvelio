import 'package:flutter/material.dart';
import 'package:marvelio/src/pages/creator_page.dart';
import 'package:marvelio/src/pages/series_page.dart';
import 'package:marvelio/src/services/creators_service.dart';
import 'package:provider/provider.dart';

import 'package:marvelio/src/pages/home_page.dart';
import 'package:marvelio/src/pages/comic_page.dart';
import 'package:marvelio/src/pages/character_page.dart';
import 'package:marvelio/src/pages/serie_page.dart';
import 'package:marvelio/src/pages/comics_page.dart';
import 'package:marvelio/src/pages/event_page.dart';

import 'package:marvelio/src/services/characters_service.dart';
import 'package:marvelio/src/services/comics_service.dart';
import 'package:marvelio/src/services/series_service.dart';
import 'package:marvelio/src/services/events_service.dart';

import 'package:marvelio/src/theme/theme.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:(_)=>ComicsService(),
        ),
        ChangeNotifierProvider(
          create:(_)=>SeriesService(),
        ),
        ChangeNotifierProvider(
          create:(_)=>CharactersService(),
        ),
        ChangeNotifierProvider(
          create:(_)=>EventsService(),
        ),
        ChangeNotifierProvider(
          create:(_)=>CreatorsService(),
        ),
        ChangeNotifierProvider<ThemeChanger>(
          create: (_) => ThemeChanger(ThemeData.light().copyWith(
            primaryColor: Colors.white
          )),
        )
      ],
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final theme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marvelio',
      theme: theme.getTheme(),
      // home: HomePage(),
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'comic': (BuildContext context) => ComicPage(),
        'character': (BuildContext context) => CharacterPage(),
        'comics': (BuildContext context) => ComicsPage(),
        'serie': (BuildContext context) => SeriePage(),
        'series': (BuildContext context) => SeriesPage(),
        'creator': (BuildContext context) => CreatorPage(),
        'event': (BuildContext context) => EventPage(),
      }
    );
  }
}
