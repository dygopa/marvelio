import 'package:flutter/material.dart';
import 'package:marvelio/src/models/comics_model.dart';
import 'package:marvelio/src/theme/theme.dart';
import 'package:provider/provider.dart';
export 'package:marvelio/src/pages/comic_page.dart';


class ComicPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    final theme = Provider.of<ThemeChanger>(context).getTheme();     
    final Result comic = ModalRoute.of(context).settings.arguments;
    final List<Thumbnail> comicImages = comic.images;
    final List<Series> comicCharacters = comic.characters.items;

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
                                margin: EdgeInsets.only(bottom: 20.0),
                                child: Text(
                                  'Descripción',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 21.0
                                  ),
                                ),
                              ),
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
                        Container(                      
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
                        //Personajes
                        Container(
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
                        Container(                      
                          child: (comicCharacters.length> 1 )
                          ? Container(
                            height: 261.0,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              itemCount: comicCharacters.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Character(
                                  comicCharacter: comicCharacters[index],
                                  index: index
                                );
                              },
                            ),
                          )
                        : Container(
                            child: Text(
                              'Error'
                            ),
                          )
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

class Character extends StatelessWidget {

  final Series comicCharacter;
  final int index;
  const Character({@required this.comicCharacter, @required this.index});

  @override
  Widget build(BuildContext context) {

    final String characterUri = comicCharacter.resourceUri;

    return GestureDetector(
      onTap: (){
        // print(comicCharacter.zzz);
      },
      child: Text(
        comicCharacter.name
      ),
    );
  }
}