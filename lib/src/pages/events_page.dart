import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marvelio/src/search/event_search_delegate.dart';
import 'package:provider/provider.dart';

import 'package:marvelio/src/theme/theme.dart';

import 'package:marvelio/src/models/events_model.dart';

import 'package:marvelio/src/services/events_service.dart';

import 'package:marvelio/src/wigets/events.dart';

class EventsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    ThemeChanger themeChanger = Provider.of<ThemeChanger>(context);
    final theme = Provider.of<ThemeChanger>(context).getTheme();  
    
    final events = Provider.of<EventsService>(context).events;

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
                delegate: EventSearch(events),
                query: 'Civil War'
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
                child: EventsSection(events: events),
              ),
            ],
          ),
        ),
      )
    );
  }
}

class EventsSection extends StatelessWidget {
  const EventsSection({@required this.events});

  final List<Result> events;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height,
      child: (events.length > 0)
      ? Events(events)
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