import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:marvelio/src/services/providers.dart';
import 'package:marvelio/src/theme/theme.dart';

import 'package:marvelio/src/models/comics_model.dart' as c;
import 'package:marvelio/src/models/characters_model.dart' as cm; 
import 'package:marvelio/src/models/events_model.dart'; 

class EventPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    final theme = Provider.of<ThemeChanger>(context).getTheme();     
    final Result event = ModalRoute.of(context).settings.arguments;
    final provider = Providers();


    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[ 
          SafeArea(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            onPressed:(){
                              Navigator.pop(context);
                            },
                          )
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        //Cover
                        Container(
                          margin: EdgeInsets.only(bottom: 20.0),
                          width: MediaQuery.of(context).size.width,
                          height: 260.0,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: <Widget>[
                              Positioned(
                                top: 5.0,
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 20.0,
                                  height: 250.0,
                                  decoration: BoxDecoration(                    
                                  borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: theme != ThemeData.dark()
                                        ? Colors.black54.withOpacity(0.3)
                                        : Colors.black54.withOpacity(0.6),
                                        offset: Offset(0.0, 12.0),
                                        blurRadius: 20.0
                                      )
                                    ]
                                  ),
                                ),
                              ),
                              Positioned(
                                child: GestureDetector(
                                  onTap: (){
                                    showCover(context, event);
                                  },
                                  child: Hero(
                                    tag: event.id,
                                    child: Container(
                                      height: 250.0,
                                      width: MediaQuery.of(context).size.width,
                                      child: Image(
                                        image: NetworkImage(event.thumbnail.path + '/landscape_incredible.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Título
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          margin: EdgeInsets.only(bottom: 25.0),
                          child: Text(
                            event.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600
                            ),
                          )
                        ),
                        //Descripción
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          margin: EdgeInsets.only(bottom: 20.0),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text( (event.description != null)
                                  ? event.description
                                  : 'Whitout description',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 14.0
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        //Personajes
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                margin: EdgeInsets.only(bottom: 20.0),
                                child: Text(
                                  'Characters',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 21.0
                                  ),
                                ),
                              ),
                              FutureBuilder(
                                future: provider.getEventCharacters(event.id), 
                                builder: (BuildContext context, AsyncSnapshot<List<cm.Result>> snapshot) {
                                  if(snapshot.connectionState == ConnectionState.done){
                                    if(snapshot.hasData){
                                      return _crearPersonajesView(snapshot.data, context);
                                    }else{
                                      return Text(
                                        snapshot.error.toString()
                                      );
                                    }
                                  }else{
                                    return Center(
                                      child: CircularProgressIndicator()
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        //Comics
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                margin: EdgeInsets.only(bottom: 20.0),
                                child: Text(
                                  'Comics',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 21.0
                                  ),
                                ),
                              ),
                              FutureBuilder(
                                future: provider.getEventComics(event.id), 
                                builder: (BuildContext context, AsyncSnapshot<List<c.Result>> snapshot) {
                                  if(snapshot.connectionState == ConnectionState.done){
                                    if(snapshot.hasData){
                                      return _crearComicsView(snapshot.data, context);
                                    }else{
                                      return Text(
                                        snapshot.error.toString()
                                      );
                                    }
                                  }else{
                                    return Center(
                                      child: CircularProgressIndicator()
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
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
                ],
              ),
            ),
          ),
        ]
      ),
    );
  }

void showCover(BuildContext context, comic){
    Dialog dialogWithImage = Dialog(
      insetPadding: EdgeInsets.all(0.0),
      clipBehavior: Clip.hardEdge,
      child: Container(
        // height: 200,
        width: MediaQuery.of(context).size.width,
        child: Image(
          image: NetworkImage(comic.thumbnail.path + '/landscape_incredible.jpg'),
          fit: BoxFit.contain,
        ),
      ),
    );
    showDialog(
      context: context, builder: (BuildContext context) => dialogWithImage
    );

  }

Widget _crearPersonajesView(List<cm.Result> personajes, context) {

    final height = MediaQuery.of(context).size.height;

    return (personajes.length > 0 ) 
      ? SizedBox(
        height: (height / 100) * 40,
        child: CarouselSlider.builder(
            options: CarouselOptions(
              scrollPhysics: BouncingScrollPhysics(),
              enableInfiniteScroll: false,
              height: (height / 100) * 40,
              autoPlay: false,
              enlargeCenterPage: true,
              viewportFraction: 0.4,
              initialPage: 1,
            ),
            itemCount: personajes.length,
            itemBuilder:(context, i) => _personajeTarjeta(personajes[i], context),
          )
        )
        : Text(
          'Whitout characters',
          style: TextStyle(
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.w200,
            fontSize: 14.0
          )
        );
  }

Widget _personajeTarjeta(cm.Result personaje, BuildContext context) {
    
    final theme = Provider.of<ThemeChanger>(context).getTheme();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, 'character', arguments: personaje);
      },
      child: Container(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Positioned(
              top: 10.0,
              child: Container(
                width: 250.0,
                decoration: BoxDecoration(                    
                borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: theme != ThemeData.dark()
                        ? Colors.black54.withOpacity(0.4)
                        : Colors.black54.withOpacity(0.7),
                      offset: Offset(0.0, 13.0),
                      blurRadius: 20.0
                    )
                  ]
                ),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: (width / 100) * 50,
                    height: (height / 100) * 30,
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image(
                        image: NetworkImage(personaje.thumbnail.path + '/portrait_incredible.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                  child: Text(
                      personaje.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w600
                      ),
                    )
                  ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }

Widget _crearComicsView(List<c.Result> comics, context) {

    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: (height / 100) * 40,
      child: (comics.length > 0 ) 
      ? CarouselSlider.builder(
        options: CarouselOptions(
          scrollPhysics: BouncingScrollPhysics(),
          enableInfiniteScroll: false,
          height: (height / 100) * 40,
          autoPlay: false,
          enlargeCenterPage: true,
          viewportFraction: 0.4,
          initialPage: 1,
        ),
        itemCount: comics.length,
        itemBuilder:(context, i) => _comic(comics[i], context),
      )
      : Text(
        'Whitout comics',
        style: TextStyle(
          fontFamily: 'Gilroy',
          fontWeight: FontWeight.w200,
          fontSize: 14.0
        )
      )
    ); 
  }

Widget _comic(c.Result comic, BuildContext context) {
    
    final theme = Provider.of<ThemeChanger>(context).getTheme();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, 'comic', arguments: comic);
      },
      child: Container(
        // color: Colors.red,
        // width: 200.0,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Positioned(
              top: 10.0,
              child: Container(
                width: 250.0,
                decoration: BoxDecoration(                    
                borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: theme != ThemeData.dark()
                        ? Colors.black54.withOpacity(0.4)
                        : Colors.black54.withOpacity(0.7),
                      offset: Offset(0.0, 13.0),
                      blurRadius: 20.0
                    )
                  ]
                ),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: (width / 100) * 50,
                    height: (height / 100) * 30,
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image(
                        image: NetworkImage(comic.thumbnail.path + '/portrait_incredible.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                  child: Text(
                      comic.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w600                         
                      ),
                    )
                  ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }

}