import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:marvelio/src/services/providers.dart';
import 'package:marvelio/src/theme/theme.dart';

import 'package:marvelio/src/models/comics_model.dart';
import 'package:marvelio/src/models/characters_model.dart' as cm; 

class ComicPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    final theme = Provider.of<ThemeChanger>(context).getTheme();     
    final Result comic = ModalRoute.of(context).settings.arguments;
    final List<Thumbnail> comicImages = comic.images;
    final charactersProvider = Providers();


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
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed:(){},
                          )
                        ),
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
                          width: MediaQuery.of(context).size.width,
                          height: 240.0,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                left: MediaQuery.of(context).size.width - 215.0,
                                top: 10.0,
                                child: Container(
                                  width: 115.0,
                                  height: 200.0,
                                  decoration: BoxDecoration(                    
                                  borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: theme != ThemeData.dark()
                                        ? Colors.black54.withOpacity(0.2)
                                        : Colors.black54.withOpacity(0.6),
                                        offset: Offset(0.0, 12.0),
                                        blurRadius: 20.0

                                      )
                                    ]
                                  ),
                                ),
                              ),
                              Positioned(
                                left: MediaQuery.of(context).size.width - 225.0,
                                child: GestureDetector(
                                  onTap: (){
                                    showCover(context, comic);
                                  },
                                  child: Hero(
                                    tag: comic.id,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Container(
                                        width: 135,
                                        child: Image(
                                          image: NetworkImage(comic.thumbnail.path + '/portrait_incredible.jpg'),
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
                        //Título
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          margin: EdgeInsets.only(bottom: 25.0),
                          child: Text(
                            comic.title,
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
                                child: Text( (comic.description != null)
                                  ? comic.description
                                  : 'Sin descripción',
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
                        //Imagenes
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          margin: EdgeInsets.only(bottom: 20.0),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 20.0),
                                child: Text(
                                  'Imágenes',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 21.0
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  showImages(context, comic);
                                },
                                child: Container(                      
                                  child: (comicImages.length > 1 )
                                  ? Container(
                                    height: 261.0,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: comicImages.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return _Image(
                                          comicImage: comicImages[index],
                                          index: index
                                        );
                                      },
                                    ),
                                  )
                                : Container(
                                    child: Text(
                                      'Sin imágenes'
                                    ),
                                  )
                                ),
                              ),
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
                                  'Personajes',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 21.0
                                  ),
                                ),
                              ),
                              FutureBuilder(
                                future: charactersProvider.getComicCharacters(comic.id), 
                                builder: (BuildContext context, AsyncSnapshot<List<cm.Result>> snapshot) {
                                  if(snapshot.connectionState == ConnectionState.done){
                                    if(snapshot.hasData){
                                      return _crearPersonajesView(snapshot.data);
                                    }else{
                                      return Text(
                                        snapshot.error.toString()
                                      );
                                    }
                                  }else{
                                    return CircularProgressIndicator();
                                  }
                                },
                              ),
                            ],
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
      child: Container(
        // height: 200,
        width: 216,
        child: Image(
          image: NetworkImage(comic.thumbnail.path + '/portrait_incredible.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
    showDialog(
      context: context, builder: (BuildContext context) => dialogWithImage
    );

  }

  Widget _crearPersonajesView(List<cm.Result> personajes) {
    return SizedBox(
      height: 250.0,
      child: (personajes.length > 0 ) 
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
        itemCount: personajes.length,
        itemBuilder:(context, i) => _personajeTarjeta(personajes[i], context),
      )
      : Text(
        'No hay personajes disponibles'
      )
    ); 
  }

  Widget _personajeTarjeta(cm.Result personaje, BuildContext context) {
    
    final theme = Provider.of<ThemeChanger>(context).getTheme();     

    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, 'character', arguments: personaje);
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
                        color: Colors.black,
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

  void showImages(BuildContext context, comic) {

    final List<Thumbnail> comicImages = comic.images;

    Dialog dialogWithImage = Dialog(
      clipBehavior: Clip.hardEdge,
      insetPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.transparent,
      child: Container(
        child: (comicImages.length > 1 )
        ? Container(
          height: 350.0,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: comicImages.length,
            itemBuilder: (BuildContext context, int index) {
              return _Image(
                comicImage: comicImages[index],
                index: index
              );
            },
          ),
        )
      : Container(
          child: Text(
            'Sin imágenes'
          ),
        )
      ),
    );
    showDialog(
      context: context, builder: (BuildContext context) => dialogWithImage
    );
  }
}

class _Image extends StatelessWidget {

  final Thumbnail comicImage;
  final int index;
  const _Image({@required this.comicImage, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20.0, right: 20.0),
        // color: Colors.red,
        // width: MediaQuery.of(context).size.width,
        // width: 464.0,
        // height: 261.0,
        child: Image(
          image: NetworkImage(comicImage.path + '/portrait_incredible.jpg' ),
          fit: BoxFit.contain,
        ),
      );      
    }
        
}