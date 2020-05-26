import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_state.dart';
import 'package:flutter/material.dart';
import 'package:marvelio/src/models/characters_model.dart';
import 'package:marvelio/src/theme/theme.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class ListaCharacters extends StatelessWidget {

  final List<Result> characters;

  const ListaCharacters(this.characters);

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
          height: 290.0,
          autoPlay: false,
          enlargeCenterPage: true,
          viewportFraction: 0.6,
          initialPage: 1,
        ),
        itemCount: this.characters.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: _Characters(
              character: this.characters[index],
              index: index
            ),
          );
        },
      ),
    );
  }
}

class _Characters extends StatelessWidget {

  final Result character;
  final int index;

  const _Characters({@required this.character, @required this.index});

  @override
  Widget build(BuildContext context) {
    // return (character.thumbnail.path != 'http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available' || character.thumbnail.path == null )
    // ? Container(child: _Character(character: character, index: index))
    // : Container(
    //   color: Colors.red
    // );
    return Container(child: _Character(character: character, index: index));

  }
}

class _Character extends StatelessWidget {
  const _Character({ @required this.character, @required this.index});

  final Result character;
  final int index;

  

  @override
  Widget build(BuildContext context) {

    final theme = Provider.of<ThemeChanger>(context).getTheme();  

    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, 'character', arguments: character);
      },
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0.0,
            left: 20.0,
            child: Container(
              width: 160.0,
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
                    child: Image(
                      image: NetworkImage(character.thumbnail.path + '/portrait_incredible.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: new ImageFilter.blur(sigmaX: 05.0, sigmaY: 05.0),
                        child: Container(
                          color: Colors.black.withOpacity(0.2),
                          width: 200.0,
                          height: 70.0,
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              character.name,
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
