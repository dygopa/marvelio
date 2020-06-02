import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:marvelio/src/services/providers.dart';
import 'package:marvelio/src/theme/theme.dart';

import 'package:marvelio/src/models/creators_model.dart'; 
import 'package:marvelio/src/models/comics_model.dart' as c;
import 'package:marvelio/src/models/series_model.dart' as s;
import 'package:marvelio/src/models/events_model.dart' as e;

class CreatorPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    final theme = Provider.of<ThemeChanger>(context).getTheme();     
    final Result creador = ModalRoute.of(context).settings.arguments;
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
                    height: 20.0
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        //Cover
                        Container(
                          height: 290.0,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: <Widget>[
                              Positioned(
                                child: Container(
                                  width: 140.0,
                                  height: 270.0,
                                  decoration: BoxDecoration(                    
                                  borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: theme != ThemeData.dark()
                                        ? Colors.black54.withOpacity(0.4)
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
                                    showCover(context, creador);
                                  },
                                  child: Hero(
                                    tag: creador.id,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Container(
                                        width: 180.0,
                                        height: 270.0,
                                        child: Image(
                                          image: NetworkImage(creador.thumbnail.path + '/portrait_incredible.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Nombre
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          margin: EdgeInsets.only(bottom: 25.0),
                          child: Text(
                            creador.firstName +  ' ' + creador.lastName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600
                            ),
                          )
                        ),
                        //Series
                        Container(              
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                margin: EdgeInsets.only(bottom: 20.0),
                                child: Text(
                                  'Series',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 21.0
                                  ),
                                ),
                              ),
                              FutureBuilder(
                                future: provider.getCreatorSeries(creador.id), 
                                builder: (BuildContext context, AsyncSnapshot<List<s.Result>> snapshot) {
                                  if(snapshot.connectionState == ConnectionState.done){
                                    if(snapshot.hasData){
                                      return _crearSeriesView(snapshot.data);
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
                        // Comics
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
                                future: provider.getCreatorComics(creador.id), 
                                builder: (BuildContext context, AsyncSnapshot<List<c.Result>> snapshot) {
                                  if(snapshot.connectionState == ConnectionState.done){
                                    if(snapshot.hasData){
                                      return _crearComicsView(snapshot.data);
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

  void showCover(BuildContext context, creador){
    Dialog dialogWithImage = Dialog(
      child: Container(
        // height: 200,
        width: 216,
        child: Image(
          image: NetworkImage(creador.thumbnail.path + '/portrait_incredible.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
    showDialog(
      context: context, builder: (BuildContext context) => dialogWithImage
    );

  }

  Widget _crearSeriesView(List<s.Result> series) {
    return SizedBox(
      height: 250.0,
      child: (series.length > 0 ) 
      ? CarouselSlider.builder(
        options: CarouselOptions(
          scrollPhysics: BouncingScrollPhysics(),
          enableInfiniteScroll: false,
          height: 350.0,
          autoPlay: false,
          enlargeCenterPage: true,
          viewportFraction: 0.4,
          initialPage: 1,
        ),
        itemCount: series.length,
        itemBuilder:(context, i) => _series(series[i], context),
      )
      : Text(
        'Whitout series',
        style: TextStyle(
          fontFamily: 'Gilroy',
          fontWeight: FontWeight.w200,
          fontSize: 14.0
        )
      )
    ); 
  }

  Widget _series(s.Result serie, BuildContext context) {
    
    final theme = Provider.of<ThemeChanger>(context).getTheme();     

    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, 'serie', arguments: serie);
      },
      child: Container(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Positioned(
              top: 10.0,
              child: Container(
                width: 90.0,
                height: 170.0,
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
                    width: 300.0,
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image(
                        image: NetworkImage(serie.thumbnail.path + '/portrait_incredible.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                  child: Text(
                      serie.title,
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

  Widget _crearComicsView(List<c.Result> comics) {
    return SizedBox(
      height: 250.0,
      child: (comics.length > 0 ) 
      ? CarouselSlider.builder(
        options: CarouselOptions(
          scrollPhysics: BouncingScrollPhysics(),
          enableInfiniteScroll: false,
          height: 350.0,
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

    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, 'comic', arguments: comic);
      },
      child: Container(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Positioned(
              top: 10.0,
              child: Container(
                width: 90.0,
                height: 170.0,
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
                    width: 300.0,
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