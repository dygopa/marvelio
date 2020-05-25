import 'dart:ui';

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
    final theme = Provider.of<ThemeChanger>(context).getTheme();  
    
    final comics = Provider.of<ComicsService>(context).comics;

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
                child: ComicsSection(comics: comics),
              ),
              // ClipRRect(
              //   child: BackdropFilter(
              //     filter: ImageFilter.blur(sigmaX: 05.0, sigmaY: 05.0),
              //     child: Container(
              //       height: 50.0,
              //       width: MediaQuery.of(context).size.width,
              //       color: Color(0XFFF2F2F2).withOpacity(0.4),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: <Widget>[
              //           Container(
              //             child: IconButton(
              //               icon: Icon(Icons.arrow_back_ios),
              //               onPressed:(){
              //                 Navigator.pop(context);
              //               },
              //             )
              //           ),
              //           Container(
              //             child: IconButton(
              //               icon: Icon(Icons.favorite_border),
              //               onPressed:(){},
              //             )
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
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