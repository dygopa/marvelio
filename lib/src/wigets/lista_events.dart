import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:marvelio/src/models/events_model.dart';
import 'package:marvelio/src/theme/theme.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class ListaEvents extends StatelessWidget {

  final List<Result> events;

  const ListaEvents(this.events);

  @override
  Widget build(BuildContext context) {

    return Container(
      // color: Colors.red,
      // height: 400.0,
      // width: MediaQuery.of(context).size.width,
      child: CarouselSlider.builder(
        options: CarouselOptions(
          scrollPhysics: BouncingScrollPhysics(),
          enableInfiniteScroll: false,
          height: 200.0,
          autoPlay: false,
          enlargeCenterPage: true,
          viewportFraction: 0.9,
          initialPage: 1,
        ),
        itemCount: this.events.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: _Events(
              event: this.events[index],
              index: index
            ),
          );
        },
      ),
    );
  }
}

class _Events extends StatelessWidget {

  final Result event;
  final int index;

  const _Events({@required this.event, @required this.index});

  @override
  Widget build(BuildContext context) {
    // return (character.thumbnail.path != 'http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available' || character.thumbnail.path == null )
    // ? Container(child: _Character(character: character, index: index))
    // : Container(
    //   color: Colors.red
    // );
    return Container(child: _Event(event: event, index: index));

  }
}

class _Event extends StatelessWidget {

  final Result event;
  final int index;

  const _Event({ @required this.event, @required this.index});
  

  @override
  Widget build(BuildContext context) {

    final theme = Provider.of<ThemeChanger>(context).getTheme();  

    return GestureDetector(
      onTap: (){
        print(event.thumbnail.path);
        print(index);
      },
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0.0,
            left: 20.0,
            child: Container(
              width: 210.0,
              height: 110.0,
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
            margin: EdgeInsets.only(bottom: 00.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 200.0,
                    // width: 270.0,
                    child: Image(
                      image: NetworkImage(event.thumbnail.path + '/landscape_incredible.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 05.0, sigmaY: 05.0),
                        child: Container(
                          color: Colors.black.withOpacity(0.2),
                          width: 260.0,
                          height: 50.0,
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              event.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600                         
                              ),
                            )
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
