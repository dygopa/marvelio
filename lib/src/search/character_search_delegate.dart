import 'package:flutter/material.dart';
import 'package:marvelio/src/models/characters_model.dart';
import 'package:marvelio/src/theme/theme.dart';
import 'package:provider/provider.dart';

class CharacterSearch extends SearchDelegate {

  String seleccion = '';
  final List<Result> characters;

  CharacterSearch(this.characters);

  // final List<Result> seriesRecomendadas = [
  //   'Infinity War',
  //   'Secret Invasion',
  //   'Kingdom Wars',
  // ];

  @override
  List<Widget> buildActions(BuildContext context) {
      // TODO: Acciones de nuestro appBar
      return [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: (){
            query = '';
          },
        )
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      // TODO: Icono a la izquierda del appBar
      return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: (){
          close(context, null);
        },
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      // TODO: Construye los resultados
      if(query.isEmpty){
        return Container();
      }

      final charactersSugerida = characters.where((c)=> c.name.toLowerCase().startsWith(query.toLowerCase())).toList();

      return Container(
      // height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: charactersSugerida.length,
        itemBuilder: (BuildContext context, int index) {
          return _Characters(
            character: charactersSugerida[index],
            index: index
          );
        },
      ),
    );

    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
    // TODO: Muestra las sugerencias cuando se escribe

      if(query.isEmpty){
        return Container();
      }

      final charactersSugerida = characters.where((c)=> c.name.toLowerCase().startsWith(query.toLowerCase())).toList();

      return Container(
      // height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: charactersSugerida.length,
        itemBuilder: (BuildContext context, int index) {
          return _Characters(
            character: charactersSugerida[index],
            index: index
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
    return (character.thumbnail.path != 'http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available')
    ? _Character(character: character, index: index)
    : Container();
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
        print(character.id);
      },
      child: Container(
        padding: EdgeInsets.only(left: 15.0),
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 30.0),
        child: Stack(
          children: <Widget>[
            Hero(
              tag: character.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  width: 110,
                  // height: 250,
                  child: Image(
                    image: NetworkImage(character.thumbnail.path + '/portrait_incredible.jpg'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 28.0,
              left: 100.0,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 14.0,
                    child: Container(
                      width: 160.0,
                      height: 110.0,
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
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 190.0,
                    height: 110.0,
                    decoration: BoxDecoration(
                      color: theme != ThemeData.dark()
                      ? Colors.white
                      : Colors.black,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                character.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w600                              
                                )
                              ),
                              Text(
                                'Spider-man',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w200
                                )
                              ),
                            ],
                          ),
                          Text(
                            'Spider-man',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w200
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}