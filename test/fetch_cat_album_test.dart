
import 'package:cat_album_lab_flutter/controller/fetch_cat_album.dart';
import 'package:cat_album_lab_flutter/model/cat_album.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_cat_album_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  test("retornar um cat album com sucesso", ()async{
    final client = MockClient();
    when(client.get(Uri.parse('https://api.thecatapi.com/v1/images/search')))
      .thenAnswer((_) async => 
        http.Response('{"id": "a8p", "url": "https://cdn2.thecatapi.com/images/a8p.jpg", "width": 720, "height": 960}', 200));
    expect(await fetchCatAlbum(client), isA<CatAlbum>());
  });
}