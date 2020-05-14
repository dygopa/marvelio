import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:marvelio/src/theme/theme.dart';

import 'package:marvelio/src/models/comics_model.dart';

import 'package:marvelio/src/services/comics_service.dart';

import 'package:marvelio/src/wigets/comics.dart';

class ComicsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    ThemeChanger themeChanger = Provider.of<ThemeChanger>(context);
    
    final comics = Provider.of<ComicsService>(context).comicsAll;

    return Scaffold(
      // backgroundColor: Color(0XFFF2F2F2),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Container(
            child: ComicsSection(comics: comics),
          ),
        ),
      )
    );
  }
}

class ComicsSection extends StatelessWidget {
  const ComicsSection({@required this.comics});

  final List<Result> comics;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height,
      child: (comics.length > 0)
      ? Comics(comics)
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