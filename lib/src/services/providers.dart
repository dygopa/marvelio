import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

import 'package:marvelio/src/models/characters_model.dart';
import 'package:marvelio/src/models/comics_model.dart' as c; 
import 'package:marvelio/src/models/events_model.dart' as e; 
import 'package:marvelio/src/models/series_model.dart' as s; 
import 'package:marvelio/src/models/creators_model.dart' as cr; 

class Providers{

  String _privateKey = "2c835e79761bd3d12a141d4d10f951d989b38f99";
  String _publicKey = "c0364ab10a40a67baa026a001e7ebe4e";
  String _timeStamp = DateTime.now().millisecondsSinceEpoch.toString();

  Future<List<Result>> getComicCharacters(int comicId) async{

    var firstChunk = utf8.encode(_timeStamp);
    var secondChunk = utf8.encode(_privateKey);
    var thirdChunk = utf8.encode(_publicKey);

    var output = AccumulatorSink<Digest>();
    var input = md5.startChunkedConversion(output);

    input.add(firstChunk);
    input.add(secondChunk);
    input.add(thirdChunk);
    input.close();

    var digest = output.events.single;

    final url = "https://gateway.marvel.com:443/v1/public/comics/${comicId}/characters?ts=${_timeStamp}&apikey=${_publicKey}&hash=${digest}";

    final resp = await http.get(url);
    final comicCharactersResponse = charactersResponseFromJson(resp.body);
    final resultado = comicCharactersResponse.data.results;

    // print(resultado);
    return resultado;
  }

  Future<List<cr.Result>> getComicCreators(int comicId) async{

    var firstChunk = utf8.encode(_timeStamp);
    var secondChunk = utf8.encode(_privateKey);
    var thirdChunk = utf8.encode(_publicKey);

    var output = AccumulatorSink<Digest>();
    var input = md5.startChunkedConversion(output);

    input.add(firstChunk);
    input.add(secondChunk);
    input.add(thirdChunk);
    input.close();

    var digest = output.events.single;

    final url = "https://gateway.marvel.com:443/v1/public/comics/${comicId}/creators?ts=${_timeStamp}&apikey=${_publicKey}&hash=${digest}";

    final resp = await http.get(url);
    final comicCreatorsResponse = cr.creatorsResponseFromJson(resp.body);
    final resultado = comicCreatorsResponse.data.results;

    // print(resultado);
    return resultado;
  }

  Future<List<Result>> getSerieCharacters(int serieId) async{

    var firstChunk = utf8.encode(_timeStamp);
    var secondChunk = utf8.encode(_privateKey);
    var thirdChunk = utf8.encode(_publicKey);

    var output = AccumulatorSink<Digest>();
    var input = md5.startChunkedConversion(output);

    input.add(firstChunk);
    input.add(secondChunk);
    input.add(thirdChunk);
    input.close();

    var digest = output.events.single;

    final url = "https://gateway.marvel.com:443/v1/public/series/${serieId}/characters?ts=${_timeStamp}&apikey=${_publicKey}&hash=${digest}";

    final resp = await http.get(url);
    final serieCharactersResponse = charactersResponseFromJson(resp.body);
    final resultado = serieCharactersResponse.data.results;

    // print(resultado);
    return resultado;
  }

  Future<List<c.Result>> getSerieComics(int serieId) async{

    var firstChunk = utf8.encode(_timeStamp);
    var secondChunk = utf8.encode(_privateKey);
    var thirdChunk = utf8.encode(_publicKey);

    var output = AccumulatorSink<Digest>();
    var input = md5.startChunkedConversion(output);

    input.add(firstChunk);
    input.add(secondChunk);
    input.add(thirdChunk);
    input.close();

    var digest = output.events.single;

    final url = "https://gateway.marvel.com:443/v1/public/series/${serieId}/comics?ts=${_timeStamp}&apikey=${_publicKey}&hash=${digest}";

    final resp = await http.get(url);
    final serieComicsResponse = c.comicsResponseFromJson(resp.body);
    final resultado = serieComicsResponse.data.results;

    // print(resultado);
    return resultado;
  }


  Future<List<c.Result>> getCharacterComics(int characterId) async{

    var firstChunk = utf8.encode(_timeStamp);
    var secondChunk = utf8.encode(_privateKey);
    var thirdChunk = utf8.encode(_publicKey);

    var output = AccumulatorSink<Digest>();
    var input = md5.startChunkedConversion(output);

    input.add(firstChunk);
    input.add(secondChunk);
    input.add(thirdChunk);
    input.close();

    var digest = output.events.single;

    final url = "https://gateway.marvel.com:443/v1/public/characters/${characterId}/comics?orderBy=title&ts=${_timeStamp}&apikey=${_publicKey}&hash=${digest}";

    final resp = await http.get(url);
    final characterComicsResponse = c.comicsResponseFromJson(resp.body);
    final resultado = characterComicsResponse.data.results;

    // print(resultado);
    return resultado;
  }

  Future<List<s.Result>> getCharacterSeries(int characterId) async{

    var firstChunk = utf8.encode(_timeStamp);
    var secondChunk = utf8.encode(_privateKey);
    var thirdChunk = utf8.encode(_publicKey);

    var output = AccumulatorSink<Digest>();
    var input = md5.startChunkedConversion(output);

    input.add(firstChunk);
    input.add(secondChunk);
    input.add(thirdChunk);
    input.close();

    var digest = output.events.single;

    final url = "https://gateway.marvel.com:443/v1/public/characters/${characterId}/series?orderBy=-title&ts=${_timeStamp}&apikey=${_publicKey}&hash=${digest}";

    final resp = await http.get(url);
    final characterSeriesResponse = s.seriesResponseFromJson(resp.body);
    final resultado = characterSeriesResponse.data.results;

    // print(resultado);
    return resultado;
  }


  Future<List<c.Result>> getCreatorComics(int creatorId) async{

    var firstChunk = utf8.encode(_timeStamp);
    var secondChunk = utf8.encode(_privateKey);
    var thirdChunk = utf8.encode(_publicKey);

    var output = AccumulatorSink<Digest>();
    var input = md5.startChunkedConversion(output);

    input.add(firstChunk);
    input.add(secondChunk);
    input.add(thirdChunk);
    input.close();

    var digest = output.events.single;

    final url = "https://gateway.marvel.com:443/v1/public/creators/${creatorId}/comics?ts=${_timeStamp}&apikey=${_publicKey}&hash=${digest}";

    final resp = await http.get(url);
    final creatorComicsResponse = c.comicsResponseFromJson(resp.body);
    final resultado = creatorComicsResponse.data.results;

    // print(resultado);
    return resultado;
  }
  
  Future<List<s.Result>> getCreatorSeries(int creatorId) async{

    var firstChunk = utf8.encode(_timeStamp);
    var secondChunk = utf8.encode(_privateKey);
    var thirdChunk = utf8.encode(_publicKey);

    var output = AccumulatorSink<Digest>();
    var input = md5.startChunkedConversion(output);

    input.add(firstChunk);
    input.add(secondChunk);
    input.add(thirdChunk);
    input.close();

    var digest = output.events.single;

    final url = "https://gateway.marvel.com:443/v1/public/creators/${creatorId}/series?ts=${_timeStamp}&apikey=${_publicKey}&hash=${digest}";

    final resp = await http.get(url);
    final creatorSeriesResponse = s.seriesResponseFromJson(resp.body);
    final resultado = creatorSeriesResponse.data.results;

    // print(resultado);
    return resultado;
  }

  Future<List<Result>> getEventCharacters(int eventId) async{

    var firstChunk = utf8.encode(_timeStamp);
    var secondChunk = utf8.encode(_privateKey);
    var thirdChunk = utf8.encode(_publicKey);

    var output = AccumulatorSink<Digest>();
    var input = md5.startChunkedConversion(output);

    input.add(firstChunk);
    input.add(secondChunk);
    input.add(thirdChunk);
    input.close();

    var digest = output.events.single;

    final url = "https://gateway.marvel.com:443/v1/public/events/${eventId}/characters?orderBy=name&ts=${_timeStamp}&apikey=${_publicKey}&hash=${digest}";

    final resp = await http.get(url);
    final eventCharactersResponse = charactersResponseFromJson(resp.body);
    final resultado = eventCharactersResponse.data.results;

    // print(resultado);
    return resultado;
  }
  Future<List<c.Result>> getEventComics(int eventId) async{

    var firstChunk = utf8.encode(_timeStamp);
    var secondChunk = utf8.encode(_privateKey);
    var thirdChunk = utf8.encode(_publicKey);

    var output = AccumulatorSink<Digest>();
    var input = md5.startChunkedConversion(output);

    input.add(firstChunk);
    input.add(secondChunk);
    input.add(thirdChunk);
    input.close();

    var digest = output.events.single;

    final url = "https://gateway.marvel.com:443/v1/public/events/${eventId}/comics?orderBy=title&ts=${_timeStamp}&apikey=${_publicKey}&hash=${digest}";

    final resp = await http.get(url);
    final eventComicsResponse = c.comicsResponseFromJson(resp.body);
    final resultado = eventComicsResponse.data.results;

    // print(resultado);
    return resultado;
  }

}