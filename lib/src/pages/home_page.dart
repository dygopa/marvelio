import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:marvelio/src/utils/hashCode.dart';

import 'package:marvelio/src/theme/theme.dart';

import 'package:marvelio/src/models/characters_model.dart' as c;
import 'package:marvelio/src/models/series_model.dart' as s;
import 'package:marvelio/src/models/events_model.dart' as e;

import 'package:marvelio/src/services/characters_service.dart';
import 'package:marvelio/src/services/series_service.dart';
import 'package:marvelio/src/services/events_service.dart';

import 'package:marvelio/src/wigets/lista_characters.dart';
import 'package:marvelio/src/wigets/lista_series.dart';
import 'package:marvelio/src/wigets/lista_events.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    ThemeChanger themeChanger = Provider.of<ThemeChanger>(context);
    
    final series = Provider.of<SeriesService>(context).series;
    final characters = Provider.of<CharactersService>(context).characters;
    final events = Provider.of<EventsService>(context).events;
    
    return Scaffold(
      // backgroundColor: Color(0XFFF2F2F2),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: ListView(
          physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                margin: EdgeInsets.only(bottom: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Discover all about',
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w200,
                            fontSize: 21
                          )
                        ),
                        IconButton(
                          icon: Icon(Icons.brightness_6),
                          onPressed: (){
                            _bottomSheet(context, themeChanger);
                          },
                        )
                      ],
                    ),
                    Text(
                      'Marvel Comics',
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w600,
                        fontSize: 21
                      )
                    )
                  ],
                ),
              ),
              CharactersSectionHome(characters: characters),
              SizedBox(
                height: 20.0
              ),
              SeriesSectionHome(series: series),
              SizedBox(
                height: 20.0
              ),
              EventsSectionHome(events: events),
              SizedBox(
                height: 20.0
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                child: Text(
                  'Data provided by Marvel. © 2014 Marvel',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w200,
                    fontSize: 12
                  )
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}

class CharactersSectionHome extends StatelessWidget {

  final List<c.Result> characters;
  const CharactersSectionHome({@required this.characters});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                margin: EdgeInsets.only(bottom: 0.0),
                child: Text(
                  'Characters',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w200,
                    fontSize: 19
                  )
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, 'characters');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  margin: EdgeInsets.only(bottom: 0.0),
                  child: Text(
                    'see more',
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w600,
                      fontSize: 14
                    )
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 365.0,
            child: (characters.length > 0)
            ? ListaCharacters(characters)
            : Center(
              child: Container(
                width: 70.0,
                height: 70.0,
                child: CircularProgressIndicator()
              ),
            )
          ),
        ],
      ),
    );
  }
}

class SeriesSectionHome extends StatelessWidget {
  const SeriesSectionHome({@required this.series});

  final List<s.Result> series;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              margin: EdgeInsets.only(bottom: 25.0),
              child: Text(
                'Series',
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w200,
                  fontSize: 19
                )
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, 'series');
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                margin: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'see more',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w600,
                    fontSize: 14
                  )
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 760.0,
          child: (series.length > 0)
          ? ListaSeries(series)
          : Center(
            child: Container(
              width: 70.0,
              height: 70.0,
              child: CircularProgressIndicator()
            ),
          )
        )
      ],
    );
  }
}

class EventsSectionHome extends StatelessWidget {
  const EventsSectionHome({@required this.events});

  final List<e.Result> events;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                margin: EdgeInsets.only(bottom: 0.0),
                child: Text(
                  'Events',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w200,
                    fontSize: 19
                  )
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, 'events');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    'see more',
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w600,
                      fontSize: 14
                    )
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 280.0,
            child: (events.length > 0)
            ? ListaEvents(events)
            : Center(
              child: Container(
                width: 70.0,
                height: 70.0,
                child: CircularProgressIndicator()
              ),
            )
          ),
        ],
      ),
    );
  }
}

void _bottomSheet(BuildContext context, ThemeChanger themeChanger) {
  showModalBottomSheet(
    context: context, 
    builder: (context){
      return Container(
        height: 130.0,
        decoration: BoxDecoration(
          borderRadius:BorderRadius.only(
            topLeft: Radius.circular(20), 
            topRight: Radius.circular(20)
          )
        ),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.brightness_2),
              title: Text(
                'Dark mode',
                style: TextStyle(
                  fontFamily: 'Gilroy'
                )
              ),
              onTap: (){
                themeChanger.setTheme(ThemeData.dark());
              },
            ),
            ListTile(
              leading: Icon(Icons.brightness_1),
              title: Text(
                'Light mode',
                style: TextStyle(
                  fontFamily: 'Gilroy'
                )
              ),
              onTap: (){
                themeChanger.setTheme(ThemeData.light().copyWith(
                  primaryColor: Colors.white
                ));
              },
            )
          ],
        ),
      );
    });
}
