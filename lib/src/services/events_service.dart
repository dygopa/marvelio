import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

import 'package:marvelio/src/models/events_model.dart';

String _PRIVATEKEY = "2c835e79761bd3d12a141d4d10f951d989b38f99";
String _PUBLICKEY = "c0364ab10a40a67baa026a001e7ebe4e";
String _URL_MARVEL = "http://gateway.marvel.com/v1/public/";
String _CATEGORY = "events?";
String _TIMESTAMP = DateTime.now().millisecondsSinceEpoch.toString();

class EventsService with ChangeNotifier{
  List<Result> events = [];

  EventsService(){
    this.getEventsHome();
  }

  getEventsHome() async{

    var firstChunk = utf8.encode(_TIMESTAMP);
    var secondChunk = utf8.encode(_PRIVATEKEY);
    var thirdChunk = utf8.encode(_PUBLICKEY);

    var output = AccumulatorSink<Digest>();
    var input = md5.startChunkedConversion(output);

    input.add(firstChunk);
    input.add(secondChunk);
    input.add(thirdChunk);
    input.close();

    var digest = output.events.single;

    final url = "${_URL_MARVEL}${_CATEGORY}ts=${_TIMESTAMP}&apikey=${_PUBLICKEY}&hash=${digest}&limit=100&offset=0";
    final resp = await http.get(url);

    final eventsResponse = eventsResponseFromJson(resp.body);
    
    final resultado = eventsResponse.data.results;

    this.events.addAll(resultado);

    notifyListeners();
  }

}