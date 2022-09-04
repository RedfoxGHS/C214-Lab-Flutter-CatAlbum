import 'package:cat_album_lab_flutter/model/CatAlbum.dart';
import 'package:cat_album_lab_flutter/controller/fetchCatAlbum.dart';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart'; 

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<CatAlbum> futureCatAlbum;
  TextStyle titleStyle = GoogleFonts.openSans(
      fontSize: 35, color: Colors.white, fontWeight: FontWeight.w600);

  @override
  void initState() {
    super.initState();
    futureCatAlbum = fetchCatAlbum(http.Client());
  }

  void refresh() => setState(() {
        futureCatAlbum = fetchCatAlbum(http.Client());
      });

  List<Color> background = [
    Color.fromARGB(255, 2, 2, 2),
    Color.fromARGB(255, 172, 172, 172),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Fotos Aleatorias de Gatinhos'),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: background,
                begin: Alignment.bottomRight,
                end: Alignment.topLeft)),
        child: Center(
          child: Column(children: [
            FutureBuilder<CatAlbum>(
              future: futureCatAlbum,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return outputCard(
                      snapshot.data!.url,
                     );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
            navigationButtons()
          ]),
        ),
      ),
    );
  }

  Widget outputCard(String url) {

    return SizedBox(
      width: double.infinity,
      height: 450,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Image.network(url),
      ),
    );
  }

  Widget navigationButtons() {
    return  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: FloatingActionButton(
              onPressed: () => {refresh()},
              backgroundColor: Colors.transparent,
              shape: const CircleBorder(side: BorderSide(color: Colors.white)),
              child: const Icon(Icons.replay_rounded),
            ),
          ),
        ]);
  }
}