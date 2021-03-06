import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

void mostrarMensaje() {

  String _PRIVATEKEY = "2c835e79761bd3d12a141d4d10f951d989b38f99";
  String _PUBLICKEY = "c0364ab10a40a67baa026a001e7ebe4e";
  String _URL_MARVEL = "http://gateway.marvel.com/v1/public/";
  String _CATEGORY = "comics?";

  String _TIMESTAMP = DateTime.now().millisecondsSinceEpoch.toString();

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

  final urlComics = "${_URL_MARVEL}${_CATEGORY}ts=${_TIMESTAMP}&apikey=${_PUBLICKEY}&hash=${digest}" ;

  print(urlComics);
  print("Digest as hash: ${_URL_MARVEL}ts=${_TIMESTAMP}&apikey=${_PUBLICKEY}&hash=${digest}");
  print(_TIMESTAMP);


}