import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:marvelio/src/theme/theme.dart';

import 'package:marvelio/src/models/comics_model.dart';

import 'package:marvelio/src/services/characters_service.dart';
import 'package:marvelio/src/services/comics_service.dart';
import 'package:marvelio/src/services/events_service.dart';

import 'package:marvelio/src/wigets/lista_characters.dart';
import 'package:marvelio/src/wigets/lista_comics.dart';
import 'package:marvelio/src/wigets/lista_events.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    ThemeChanger themeChanger = Provider.of<ThemeChanger>(context);
    
    final comics = Provider.of<ComicsService>(context).comics;
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
                          'Descubre todo sobre',
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
              Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          margin: EdgeInsets.only(bottom: 0.0),
                          child: Text(
                            'Personajes',
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w200,
                              fontSize: 19
                            )
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          margin: EdgeInsets.only(bottom: 0.0),
                          child: Text(
                            'ver más',
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600,
                              fontSize: 14
                            )
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
              ),
              ComicsSectionHome(comics: comics),
              SizedBox(
                height: 20.0
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          margin: EdgeInsets.only(bottom: 0.0),
                          child: Text(
                            'Eventos',
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w200,
                              fontSize: 19
                            )
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          margin: EdgeInsets.only(bottom: 0.0),
                          child: Text(
                            'ver más',
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600,
                              fontSize: 14
                            )
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 250.0,
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
              ),
            ],
          ),
        ),
      )
    );
  }
}

class ComicsSectionHome extends StatelessWidget {
  const ComicsSectionHome({@required this.comics});

  final List<Result> comics;

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
                'Cómics recientes',
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w200,
                  fontSize: 19
                )
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, 'comics');
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                margin: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'ver más',
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
          child: (comics.length > 0)
          ? ListaComics(comics)
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
                'Modo oscuro',
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
                'Modo claro',
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