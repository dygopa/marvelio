import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marvelio/src/search/character_search_delegate.dart';
import 'package:provider/provider.dart';

import 'package:marvelio/src/theme/theme.dart';

import 'package:marvelio/src/models/characters_model.dart';

import 'package:marvelio/src/services/characters_service.dart';

import 'package:marvelio/src/wigets/characters.dart';

class CharactersPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    ThemeChanger themeChanger = Provider.of<ThemeChanger>(context);
    final theme = Provider.of<ThemeChanger>(context).getTheme();  
    
    final characters = Provider.of<CharactersService>(context).characters;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: theme != ThemeData.dark()
            ? Colors.black
            : Colors.white,
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
             icon: Icon(Icons.search),
             onPressed:(){
              showSearch(
                context: context, 
                delegate: CharacterSearch(characters),
                query: 'Capitan America'
              );
             },
           )
        ],
      ),
      // backgroundColor: Color(0XFFF2F2F2),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 0.0),
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 0.0),
                child: CharactersSection(characters: characters),
              ),
            ],
          ),
        ),
      )
    );
  }
}

class CharactersSection extends StatelessWidget {
  const CharactersSection({@required this.characters});

  final List<Result> characters;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height,
      child: (characters.length > 0)
      ? Characters(characters)
      : Center(
        child: Container(
          width: 70.0,
          height: 70.0,
          child: CircularProgressIndicator()
        ),
      )
    );
  }
}