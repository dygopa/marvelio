import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:marvelio/src/theme/theme.dart';

import 'package:marvelio/src/models/series_model.dart';

import 'package:marvelio/src/services/series_service.dart';

import 'package:marvelio/src/wigets/series.dart';

class SeriesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    ThemeChanger themeChanger = Provider.of<ThemeChanger>(context);
    final theme = Provider.of<ThemeChanger>(context).getTheme();  
    
    final series = Provider.of<SeriesService>(context).series;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: theme != ThemeData.dark()
            ? Colors.black
            : Colors.white,
        ),
        elevation: 0.0,
        actions: <Widget>[
          // IconButton(
          //    icon: Icon(Icons.arrow_back_ios),
          //    onPressed:(){
          //      Navigator.pop(context);
          //    },
          //  )
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
                child: SeriesSection(series: series),
              ),
            ],
          ),
        ),
      )
    );
  }
}

class SeriesSection extends StatelessWidget {
  const SeriesSection({@required this.series});

  final List<Result> series;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height,
      child: (series.length > 0)
      ? Series(series)
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