
import 'package:cat_album_lab_flutter/model/cat_album.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<CatAlbum> fetchCatAlbum([client]) async {
  final response = await http
      .get(Uri.parse('https://api.thecatapi.com/v1/images/search'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return CatAlbum.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}